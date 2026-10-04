# GO ENTERPRISE CODE DOCTRINE

**Document Class:** 001-01/25-GUIDE
**Version:** 2.0 (Unified)
**Date:** 2026-02-08
**Scope:** Binding standards for all Go development in TEJL projects
**Target Runtime:** Go 1.25.4

---

## PREAMBLE: THE SIMPLICITY TRAP

**Problem Statement:**
Go is deceptively simple. Its lack of strict architectural guardrails (like Java's classes or Rust's borrow checker) means that without discipline, Go codebases devolve into "flat" spaghetti code where everything depends on everything, goroutines leak silently, and `interface{}` destroys type safety.

**Our Solution:**
We adhere to **Strict Idiomatic Go**. We reject "clever" abstractions in favor of boring, predictable, and robust code. We treat concurrency as a loaded weapon that requires strict safety protocols.

---

## PART I: CORE PHILOSOPHY

### ARTICLE 1: THE PRIME DIRECTIVE

**"Clear is better than clever." (Rob Pike)**

1.  **Readability:** Go code is written to be read by humans, not just the compiler.
2.  **Boring Code:** If you are using `unsafe`, `reflect`, or complex channel logic where a mutex would suffice, you are likely failing.
3.  **No Magic:** We do not use frameworks that rely on magic tags, heavy reflection, or global injection. Dependency Injection is explicit (passed via constructors).

### ARTICLE 2: PACKAGE HYGIENE (SRP)

#### 2.1 The "Util" Prohibition
Creating a package named `util`, `common`, `base`, or `shared` is strictly forbidden.
*   ❌ **BAD:** `util.StringInSlice()`, `util.ConnectDB()`
*   ✅ **GOOD:** `slice.Contains()`, `database.Connect()`

#### 2.2 Package Names
Package names must be:
*   **Singular** (`user`, not `users`).
*   **Descriptive** (`config`, `http`, `json`).
*   **Lowercase** (no `snake_case` or `camelCase`).

#### 2.3 Internal by Default
All application logic belongs in `internal/`.
*   **Why?** It prevents other projects (or even other parts of your monorepo) from importing code that isn't meant to be a public API.
*   **Public:** `pkg/` is reserved *only* for libraries intended to be imported by the wider world.

---

## PART II: ARCHITECTURE & STATE

### ARTICLE 3: DEPENDENCY HIERARCHY

**Rule:** Dependencies flow **down**.
1.  **Transport Layer** (`cmd`, `api`) -> Depends on Service.
2.  **Service Layer** (`service`) -> Depends on Domain & Repository.
3.  **Domain/Repository Layer** -> Depends on **NOTHING** (or standard lib).

**Circular Dependencies:** In Go, a circular dependency is a compile-time error. If you hit one, do not create an interface just to break the cycle. **Refactor your architecture.** You have likely coupled things that should be separate.

### ARTICLE 4: CONCURRENCY DOCTRINE

**4.1 Never Start a Goroutine Without a Stop Plan**
Every `go func()` must have a defined lifecycle.
*   ❌ **BAD:** Fire-and-forget `go process()` that runs forever or until main exits.
*   ✅ **GOOD:** Using `errgroup` or `WaitGroup` to track completion, coupled with `context` for cancellation.

**4.2 Channel Ownership**
The component that writes to a channel is responsible for closing it.
*   **Panic Risk:** Closing a closed channel panics. Writing to a closed channel panics. Strict ownership prevents this.

**4.3 Mutex vs. Channels**
*   Use **Channels** for passing ownership of data.
*   Use **Mutexes** for protecting state/caches.
*   Do not over-engineer complex pipelines with channels when a slice processing loop is faster and easier to read.

### ARTICLE 5: INTERFACE POLLUTION

**Rule:** Define interfaces where they are **used**, not where they are implemented. (Consumer-Defined Interfaces).

❌ **BAD (Java Style):**
Defining `UserRepo` interface inside the `database` package next to the implementation.

✅ **GOOD (Go Style):**
Defining `UserFetcher` interface inside the `service` package because the service *needs* something that fetches users.

**Accept Interfaces, Return Structs.**
*   Functions should accept the smallest interface necessary.
*   Constructors (`New...`) should return concrete types (struct pointers), allowing the consumer to define the interface they need.

---

## PART III: IMPLEMENTATION DOCTRINE

### ARTICLE 6: ERROR HANDLING DOCTRINE

#### 6.1 Handle Every Error
*   ❌ **FORBIDDEN:** `_ = func()` (Ignoring errors).
*   ❌ **FORBIDDEN:** `if err != nil { return err }` (Returning raw errors without context).

#### 6.2 Error Wrapping
Always wrap errors with context using `%w`.

✅ **GOOD:**
```go
if err != nil {
    return fmt.Errorf("failed to fetch user %s: %w", userID, err)
}
```

#### 6.3 Sentinel vs. Type
*   Use **Sentinel Errors** (`var ErrNotFound = errors.New(...)`) for static comparisons (`errors.Is`).
*   Use **Error Types** (`struct { Query string }`) when the caller needs data from the error (`errors.As`).

### ARTICLE 7: CONTEXT PROPAGATION

**Rule:** `context.Context` is the first argument of every function that performs I/O or long-running tasks.

*   ❌ **BAD:** Storing `ctx` in a struct.
*   ✅ **GOOD:** Passing `ctx` down the call stack.

**Why?** Context is request-scoped. Storing it in a struct creates ambiguity about *which* request lifecycle the struct belongs to.

### ARTICLE 8: CONFIGURATION & GLOBAL STATE

**8.1 No Global Mutable State**
*   ❌ **FORBIDDEN:** `var db *sql.DB` in the global scope.
*   ✅ **REQUIRED:** Pass dependencies via constructors.

**8.2 `init()` Prohibition**
Avoid `init()` functions. They make code hard to test and initialization order unpredictable. Initialize explicitly in `main`.

**8.3 Structured Logging**
Use `log/slog` (Go 1.21+). Do not use `fmt.Println` for logging.

```go
slog.Info("processing request", "user_id", uid, "status", status)
```

---

## PART IV: QUALITY ASSURANCE

### ARTICLE 9: TESTING DOCTRINE

#### 9.1 Table-Driven Tests
Go tests should be table-driven. This makes adding test cases trivial.

```go
func TestAdd(t *testing.T) {
    tests := []struct {
        name string
        a, b int
        want int
    }{
        {"positive", 1, 2, 3},
        {"negative", -1, -1, -2},
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            if got := Add(tt.a, tt.b); got != tt.want {
                t.Errorf("Add() = %v, want %v", got, tt.want)
            }
        })
    }
}
```

#### 9.2 Test Packages (`_test`)
Prefer using `package foo_test` (external tests) over `package foo` (internal tests). This forces you to test only the public API, ensuring your interface is usable.

### ARTICLE 10: STATIC ANALYSIS (GATES)

Our codebase must pass the following gates in CI:

1.  **`gofmt`**: Standard formatting.
2.  **`golangci-lint`**: The aggregator.
    *   **Enabled Linters:** `govet`, `errcheck`, `staticcheck`, `gosec`, `prealloc`, `revive`.

---

## PART V: ANTI-PATTERNS (FORBIDDEN)

1.  **Interface{}:** Using `interface{}` (or `any`) to bypass the type system is forbidden unless writing generic infrastructure code (like a JSON marshaler).
2.  **Panic:** Never panic in library code. Return errors. Only `main` may panic on startup failure.
3.  **Goroutine Leaks:** Starting a goroutine without a way to stop it via Context cancellation.
4.  **Naked Returns:** Avoid naked returns (`return` without arguments) in non-trivial functions. They hurt readability.

---

## PART VI: TOOLING CONFIGURATION

All projects must include a `golangci.yaml` enforcing these standards.

```yaml
run:
  timeout: 5m
linters:
  enable:
    - errcheck
    - gosimple
    - govet
    - ineffassign
    - staticcheck
    - typecheck
    - unused
    - gosec
    - revive
```

---

**Approved by:**
Board for Standardization and Development, TEJL d.o.o.

**Effective Date:** 2026-02-08
**Revision:** 2.0 (Unified Doctrine)
