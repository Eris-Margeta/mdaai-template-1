# NODE.JS & TYPESCRIPT ENTERPRISE CODE DOCTRINE

**Document Class:** 001-01/25-GUIDE
**Version:** 2.0 (Unified)
**Date:** 2026-02-08
**Scope:** Binding standards for all Node.js, TypeScript, and React development
**Target Runtime:** Node 22+, V8 Engine

---

## PREAMBLE: THE DECEPTIVE RUNTIME

**Problem Statement:**
JavaScript is the most accessible language in the world, yet the hardest to scale safely. Its event-loop model is unforgiving: a single blocking line of code halts the entire system. Its dynamic nature allows "works on my machine" code to fail catastrophically under load due to hidden class transitions, memory leaks in closures, or unhandled Promise rejections.

**Our Solution:**
We write **System-Grade TypeScript**. We respect the Heap. We fear the Event Loop lag. We enforce rigid type boundaries to turn runtime chaos into compile-time certainty.

---

## PART I: RUNTIME ARCHITECTURE (THE ENGINE)

### ARTICLE 1: THE SACRED MAIN THREAD

**1.1 The Golden Rule of Node.js**
**"Don't Block the Event Loop."**

*   **Understanding:** Node.js handles thousands of concurrent connections on a single thread via the *libuv* event loop.
*   **Prohibition:** Any synchronous CPU-bound operation >10ms is **strictly forbidden** on the main thread.
    *   ❌ **BAD:** `crypto.pbkdf2Sync`, huge `JSON.parse`, synchronous `fs` methods (`fs.readFileSync`) in hot paths.
    *   ✅ **GOOD:** Offload to Worker Threads, or use the async versions provided by `libuv`.

**1.2 Promise Starvation**
Be aware of Microtasks vs. Macrotasks.
*   **Danger:** An infinite loop of Promises (`.then()` chaining) starves the I/O loop because Microtasks (Promises) have higher priority than Macrotasks (I/O, Timers).
*   **Doctrine:** Break up long-running sync logic with `setImmediate()` to allow I/O ticks.

### ARTICLE 2: MEMORY HYGIENE (HEAP & STACK)

**2.1 Closure leaks**
Closures capture their lexical scope. If a small closure outlives a large parent function execution, it keeps the *entire* parent scope alive in the Heap.
*   **Rule:** Be mindful of what your event listeners and callbacks capture. Explicitly nullify large references if the listener is long-lived.

**2.2 Object Shape & V8 Optimization**
V8 uses "Hidden Classes" and "Inline Caching" to optimize access.
*   ❌ **BAD (Deoptimization):** Adding properties to objects dynamically (`obj.newProp = 1`). This changes the "shape" and forces V8 to bail out to slow dictionary lookups.
*   ✅ **GOOD:** Define the shape interface explicitly. Initialize all properties in the constructor/literal.

---

## PART II: TYPESCRIPT DOCTRINE

### ARTICLE 3: THE "ANY" PROHIBITION

**3.1 The Virus**
`any` is not a type; it is a request to disable the compiler. It spreads like a virus.
*   **Rule:** `any` is **strictly forbidden**.
*   **Alternative:** Use `unknown`. This forces you to perform a Type Guard check before using the variable.

❌ **BAD:**
```typescript
function process(input: any) {
    return input.toUpperCase(); // Runtime crash potential
}
```

✅ **GOOD:**
```typescript
function process(input: unknown) {
    if (typeof input === 'string') {
        return input.toUpperCase(); // Safe
    }
    throw new Error("Invalid input");
}
```

### ARTICLE 4: TRUTHINESS & COERCION

JavaScript's loose typing is a source of infinite bugs.
*   **Rule:** Strict Boolean checks only.
*   ❌ **BAD:** `if (user.count)` (Fails if count is 0, which might be valid).
*   ✅ **GOOD:** `if (user.count > 0)` or `if (user.count !== undefined)`.
*   **Rule:** Use `===`, never `==`.

### ARTICLE 5: STRICT NULL CHECKS

**5.1 The Billion Dollar Mistake**
`null` and `undefined` are distinct types.
*   **Configuration:** `strictNullChecks: true` is mandatory.
*   **Doctrine:** Do not use `!` (non-null assertion) unless you have mathematically proven existence (and commented why). Use Optional Chaining `?.` and Nullish Coalescing `??`.

---

## PART III: BACKEND ARCHITECTURE

### ARTICLE 6: DEPENDENCY INJECTION

**6.1 No Side-Effect Imports**
Modules should not run code upon import. They should export factories or classes.
*   ❌ **BAD:** Connecting to DB at the top level of `db.ts`.
*   ✅ **GOOD:** Exporting a `connect()` function called during application bootstrap.

**6.2 Inversion of Control**
Do not instantiate dependencies inside business logic. Pass them in.
*   **Why?** Testability. You cannot mock a dependency if it's hard-coded in the `import`.

### ARTICLE 7: ERROR HANDLING

**7.1 Throw Errors, Not Strings**
*   ❌ **BAD:** `throw "User not found"` (No stack trace).
*   ✅ **GOOD:** `throw new UserNotFoundError(id)`.

**7.2 The Result Pattern**
For expected failure states (validation, not found), prefer returning a `Result` type rather than throwing. Throwing is for *exceptional* system failures (DB down).

```typescript
type Result<T, E = Error> =
  | { ok: true; value: T }
  | { ok: false; error: E };
```

---

## PART IV: ASYNC MASTERY

### ARTICLE 8: PROMISE DISCIPLINE

**8.1 No Floating Promises**
Every Promise must be awaited or returned.
*   **Risk:** An unawaited Promise consumes errors silently. If it fails, the application continues in an undefined state.
*   **Enforcement:** `eslint-plugin-promise` rules.

**8.2 Parallelism**
Don't `await` in a loop sequentially unless order matters.
*   ❌ **Slow:** `for (const id of ids) await db.get(id)`
*   ✅ **Fast:** `await Promise.all(ids.map(id => db.get(id)))`

---

## PART V: REACT & VITE DOCTRINE (FRONTEND SPECIFIC)

**Scope:** This section applies specifically to Frontend development using React + Vite.

### ARTICLE 9: THE VITE STANDARD (ESM ONLY)

**9.1 No Default Exports**
Default exports are hostile to refactoring tools and static analysis (Tree Shaking).
*   ❌ **FORBIDDEN:** `export default function Component() {}`
*   ✅ **REQUIRED:** `export function Component() {}`
*   **Rationale:**
    *   **Renaming:** Named exports enforce consistent naming across the codebase. `import { Button }` is safer than `import MyBtn from './Button'`.
    *   **Speed:** Named exports simplify the module graph for bundlers (Vite/Rollup).

**9.2 Barrel Files (Index.ts)**
Use `index.ts` files strictly for exporting the public API of a feature folder.
*   ✅ `export * from './Component';`
*   ❌ Do not write implementation logic inside `index.ts`.

### ARTICLE 10: REACT COMPONENT PURITY

**10.1 Render is Sacred**
The render function must be pure.
*   **Rule:** No side effects (API calls, DOM mutation) in the render body.
*   **Rule:** Use `useEffect` for side effects, but prefer event handlers where possible.

**10.2 The Dependency Array**
*   **Rule:** `useEffect` and `useCallback` dependency arrays must be exhaustive.
*   **Enforcement:** `eslint-plugin-react-hooks` / `exhaustive-deps` set to **ERROR**.
*   **Doctrine:** If you feel the need to lie to the linter about dependencies, your logic is flawed. Refactor the logic, don't disable the linter.

### ARTICLE 11: FOLDER STRUCTURE (FEATURE-BASED)

Do not group by file type (`components/`, `hooks/`, `utils/`). Group by **Feature Domain**.

✅ **GOOD:**
```text
src/
  features/
    auth/
      components/
      hooks/
      api/
      types.ts
      index.ts
    dashboard/
```

This adheres to the **Single Responsibility Principle** at the architectural level.

---

## PART VI: TOOLING & ENFORCEMENT

### ARTICLE 12: THE TOOLCHAIN

1.  **Package Manager:** `pnpm`. (Strict dependency isolation, fast installation).
2.  **Linter:** `eslint` (Flat Config).
3.  **Formatter:** `prettier`.
4.  **Test Runner:** `vitest`. (Jest is legacy).

### ARTICLE 13: CONFIGURATION GATES

**tsconfig.json (Strict Base):**
```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "noUncheckedIndexedAccess": true, // The "undefined" protector
    "exactOptionalPropertyTypes": true,
    "useUnknownInCatchVariables": true
  }
}
```

**Reasoning for `noUncheckedIndexedAccess`:**
Accessing `array[0]` in standard TS returns `T`. In reality, it returns `T | undefined`. This flag forces you to handle the `undefined` case, preventing runtime crashes on empty arrays.

---

**Approved by:**
Board for Standardization and Development, TEJL d.o.o.

**Effective Date:** 2026-02-08
**Revision:** 2.0 (Unified Doctrine)
