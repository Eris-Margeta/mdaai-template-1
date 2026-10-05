# RUST ENTERPRISE CODE DOCTRINE

**Document Class:** 001-01/25-GUIDE
**Version:** 2.0 (Unified)
**Date:** 2026-02-08
**Scope:** Binding standards for all Rust development in TEJL projects

---

## PREAMBLE: THE CRISIS OF COMPLEXITY

**Problem Statement:**
In complex codebases, the cost of bugs grows exponentially with system size. A bug that takes 2 hours to fix in a 1,000-line codebase can take 2 weeks in a 100,000-line codebase. The difference is not the complexity of the fix—it's the difficulty of **understanding** the system.

**Our Solution:**
This document codifies the principles of writing Rust code that remains **understandable**, **debuggable**, and **maintainable** at enterprise scale. These are not suggestions—they are **binding engineering standards**.

---

## PART I: CORE PHILOSOPHY

### ARTICLE 1: THE PRIME DIRECTIVE

**"Code is read 100x more than it is written."**

Every line of code you write will be:
- Read by future maintainers (including yourself in 6 months)
- Debugged under production pressure
- Modified by developers unfamiliar with the original context
- Analyzed by AI assistants attempting to understand system behavior

**Therefore:**
1. **Optimize for readability over cleverness.**
2. **Optimize for debuggability over performance (until proven necessary).**
3. **Optimize for explicitness over brevity.**

### ARTICLE 2: SINGLE RESPONSIBILITY PRINCIPLE (SACRED)

#### 2.1 Module Responsibility
Every module (file) must have **ONE clear purpose** that can be stated in a single sentence.

*   ✅ **GOOD:** `walker.rs`: "Traverses directory structures."
*   ❌ **BAD:** `walker.rs`: "Traverses directories, checks ignore rules, reads files, and formats output."

#### 2.2 Function Responsibility
Every function must do **ONE thing** at **ONE level of abstraction**.

*   **The Litmus Test:** If you struggle to name a function without using the word "and", it violates SRP (e.g., `walk_and_filter_and_read()`).
*   **Split it:** Create `walk()`, `filter()`, and `read()`.

---

## PART II: ARCHITECTURE & STATE

### ARTICLE 3: EXPLICIT STATE OVER IMPLICIT CONTROL FLOW

**Problem:** Boolean flags create implicit state with $2^N$ combinations.

❌ **BAD (Boolean Soup):**
```rust
struct FileNode {
    is_ignored: bool,
    is_omitted: bool,
    should_debug: bool,
    // 8 possible states. What does ignored=true + should_debug=true mean?
}
```

✅ **GOOD (Algebraic Data Types):**
```rust
#[derive(Debug, PartialEq, Eq)]
enum FileHandlingDecision {
    Include,      // Process fully
    Exclude,      // Skip entirely
    DebugVisible, // Show in tree but don't read content
    OmitContent,  // Show in tree, binary/lockfile placeholder
}
// 4 states. All valid. Compiler enforces exhaustiveness.
```

### ARTICLE 4: PURE FUNCTIONS & SIDE-EFFECT ISOLATION

**Pattern:** "Functional Core, Imperative Shell"

1.  **The Core:** Pure logic. No I/O. Deterministic. 100% Testable.
2.  **The Shell:** Handles I/O, Networking, Config parsing. Calls the Core.

✅ **GOOD:**
```rust
// CORE: Pure logic (easy to test, no mocks needed)
fn should_ignore(path: &str, rules: &[Rule]) -> bool {
    rules.iter().any(|r| r.matches(path))
}

// SHELL: I/O and effects
fn process_dir(path: &Path) -> io::Result<()> {
    let rules = load_rules(path)?; // I/O
    if should_ignore(path.to_str().unwrap(), &rules) { // Pure Logic
        // ...
    }
    Ok(())
}
```

### ARTICLE 5: SINGLE DECISION POINT

**Rule:** Each logical decision should be made in **exactly one place**.

Do not scatter `if is_ignored` checks across `walker.rs`, `formatter.rs`, and `reader.rs`.
Instead, have a central `IgnoreEngine::decide()` that returns a `Decision` enum, and all other modules respect that decision.

### ARTICLE 6: MODULE ORGANIZATION

**Rule:** Dependencies flow in one direction only.

```
┌──────────┐
│   CLI    │  (User interface)
└──────────┘
     ↓
┌──────────┐
│  Walker  │  (Orchestration)
└──────────┘
     ↓
┌──────────┐
│  Engine  │  (Business logic)
└──────────┘
     ↓
┌──────────┐
│  Domain  │  (Data types - Structs/Enums)
└──────────┘
```

*   **Circular dependencies** are a sign of architectural failure.
*   **Domain types** should rarely depend on I/O.

---

## PART III: IMPLEMENTATION DOCTRINE

### ARTICLE 7: ERROR HANDLING DOCTRINE

#### 7.1 No Panics in Production
*   **Rule:** Using `.unwrap()` and `.expect()` is **strictly forbidden** in production code.
*   **Rationale:** Robust software handles errors; it does not crash.
*   **Exception:** `mutex.lock().unwrap()` is acceptable if the lock poisoning strategy is "crash".

#### 7.2 Error Context Propagation
Never return a raw error if the context is lost. Wrap it.

❌ **BAD:**
```rust
fs::read_to_string(path)? // Returns "Permission denied" - on which file?
```

✅ **GOOD:**
```rust
fs::read_to_string(path).map_err(|e|
    io::Error::new(e.kind(), format!("Failed to read config at {:?}: {}", path, e))
)?
```

#### 7.3 Panic vs Result
*   Use `panic!` for **Programmer Errors** (violated contract, e.g., `assert!(divisor != 0)`).
*   Use `Result` for **Runtime Errors** (file not found, network down).

### ARTICLE 8: IDIOMATIC RUST PATTERNS

#### 8.1 Iterators Over Loops
Rust's iterator system is safer and more expressive than manual indexing.

❌ **BAD:**
```rust
for i in 0..items.len() { process(items[i]); }
```

✅ **GOOD:**
```rust
for item in &items { process(item); }
for (i, item) in items.iter().enumerate() { ... }
```

#### 8.2 Flatten Over Nesting
When dealing with `Option` or `Result` in loops, avoid nested `if let`.

❌ **BAD:**
```rust
for x in list { if let Some(i) = x { process(i); } }
```

✅ **GOOD:**
```rust
for i in list.into_iter().flatten() { process(i); }
```

#### 8.3 The Default Trait
If a struct has a constructor `new()` that takes no arguments, it **must** implement `Default`.

✅ **GOOD:**
```rust
impl Default for Config {
    fn default() -> Self { Self { verbose: false } }
}

impl Config {
    pub fn new() -> Self { Self::default() }
}
```

### ARTICLE 9: NAMING CONVENTIONS

1.  **Reveal Intent:** `filter_ignored_files()` vs `proc_data()`.
2.  **Domain Language:** Use terms from the business domain (e.g., `IgnoreRule`), not the implementation (e.g., `RegexPattern`).
3.  **Boolean Questions:** Boolean functions must ask a question: `is_valid()`, `should_process()`, `has_errors()`.

---

## PART IV: QUALITY ASSURANCE

### ARTICLE 10: TESTING DOCTRINE

#### 10.1 Test Pyramid
1.  **Unit Tests (80%):** Test pure functions in isolation.
2.  **Integration Tests (15%):** Test module interactions via public APIs.
3.  **E2E Tests (5%):** Test the full binary/application from the outside.

#### 10.2 Independence
Each test must be **completely independent**.
*   No shared global mutable state (`static mut`).
*   Tests must be able to run in parallel and in any order.

### ARTICLE 11: DEBUGGING SUPPORT

#### 11.1 Loggable Decisions
Complex logic engines should have a `log_decision` or `explain` method.

```rust
if cfg!(debug_assertions) || env::var("APP_DEBUG").is_ok() {
    eprintln!("Decision for '{}': {:?}", ctx.name, decision);
}
```

---

## PART V: TOOLING & ENFORCEMENT

### ARTICLE 12: CODE QUALITY TOOLS

Our development process relies on two fundamental tools to automate these standards.

#### 12.1 Formatting: `rustfmt`
*   **Rule:** All code must be formatted with `rustfmt`.
*   **Enforcement:** CI pipeline fails on unformatted code.
*   **Action:** Run `cargo fmt --all` before every commit.

#### 12.2 Static Analysis: `clippy`
*   **Rule:** Code must pass `clippy` checks with **zero warnings**.
*   **Enforcement:** CI runs `cargo clippy --workspace -- -D warnings`.
*   **Action:** Run `cargo clippy` locally. Clippy is your "virtual senior engineer."

### ARTICLE 13: FORBIDDEN ANTI-PATTERNS

1.  **God Objects:** Structs that manage config, I/O, *and* logic.
2.  **Primitive Obsession:** Using `String` for file paths (use `PathBuf`) or IDs (use newtypes).
3.  **The Boolean Trap:** Functions taking 3+ boolean arguments (`process(true, false, true)`). Use a `Config` struct or Enums.
4.  **Premature Optimization:** Using `unsafe` without a benchmark proving it is the bottleneck.

---

**Approved by:**
Board for Standardization and Development, TEJL d.o.o.

**Effective Date:** 2026-02-08
**Revision:** 2.0 (Unified Doctrine)
