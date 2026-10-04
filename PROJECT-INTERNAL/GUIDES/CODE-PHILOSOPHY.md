This is the **Code Philosophy (Universal Doctrine)**.

It is written not as a list of rules, but as a treatise on **Software Entropy** and **Complexity Management**. It serves as the "First Principles" document. If a developer is coding in a language we have not yet written a guide for (e.g., C++, Lua, Swift), they read this document to derive the correct approach.

This file replaces `PROJECT-INTERNAL/GUIDES/CODE-PHILOSOPHY.md`.

***

# CODE PHILOSOPHY: THE UNIVERSAL DOCTRINE

**Document Class:** 001-01/25-PHILOSOPHY
**Version:** 2.0 (The Axioms)
**Date:** 2026-02-08
**Scope:** Universal engineering principles for all languages and frameworks
**Authority:** Highest (Overrides specific guides in case of ambiguity)

---

## PREAMBLE: THE WAR AGAINST ENTROPY

**The Reality of Systems:**
Software systems do not naturally remain stable. They naturally degrade. Without the constant injection of energy (discipline), a codebase drifts toward **entropy**—a state of disorder, coupling, and unintelligibility.

**The Mission:**
We do not just "write code." We construct **durable logic lattices**. We fight entropy by minimizing complexity, enforcing isolation, and prioritizing understandability over ease of writing.

**The "God-Tier" Perspective:**
A junior engineer optimizes for "getting it to work."
A senior engineer optimizes for "maintainability."
**We optimize for Survival.** We write systems that can survive the rotation of team members, the changing of dependencies, and the passage of time.

---

## AXIOM 1: COMPLEXITY IS THE ENEMY

### 1.1 Simple vs. Easy
*   **Easy** is familiar. It is near at hand. (e.g., Global variables, "God objects," magic frameworks). Easy code is often complex because it braids concerns together.
*   **Simple** is unbraided. It separates concerns. (e.g., Pure functions, explicit state passing). Simple code is often "hard" to write because it requires rigorous thought.
*   **Doctrine:** **We choose Simple over Easy.** We accept the friction of writing boilerplate if it buys us the freedom of decoupling.

### 1.2 Cognitive Load Limiter
A human brain can hold roughly 7 items in working memory.
*   **The Rule:** No function or module should require holding more than 7 concurrent concepts to understand.
*   **Implication:** If a function performs I/O, parses data, *and* applies business logic, it exceeds the limit. Split it.

---

## AXIOM 2: THE IMMUTABILITY MANDATE

### 2.1 State is the Root of All Evil
Mutable state is a time-dependent trap. If `x` can change, then the value of `x` depends on *when* you look at it. This destroys deterministic reasoning.

### 2.2 Immutability by Default
*   **Principle:** Data should be treated as immutable facts.
*   **Application:**
    *   In **Rust**: Prefer passing by value or immutable reference.
    *   In **JS/TS**: Treat objects as frozen. Use `const`. Return new objects instead of mutating `this`.
    *   In **Python**: Use frozen dataclasses.
*   **Exception:** Mutation is permitted only within the strict local scope of a function (e.g., building a result). It must never leak across boundaries.

---

## AXIOM 3: ORTHOGONALITY & ISOLATION

### 3.1 Functional Core, Imperative Shell
This is the **Universal Architecture**.
*   **The Core:** Pure business logic. It takes data in and returns data out. It has zero side effects. It mocks nothing because it depends on nothing.
*   **The Shell:** The "dirty" world. It reads files, talks to networks, gets user input. It passes this data to the Core.
*   **The Law:** The Core never imports the Shell.

### 3.2 Dependency Direction
Dependencies must point toward stability.
*   **Volatile Code** (UI, DB Adapters, CLI) depends on -> **Stable Code** (Domain Entities, Business Rules).
*   **Stable Code** depends on -> **Nothing**.

---

## AXIOM 4: DATA-ORIENTED DESIGN

### 4.1 Parse, Don't Validate
Validation is a weak check (`if x > 0`). Parsing is a structural transformation (`int` -> `NonNegativeInt`).
*   **Doctrine:** Use the type system (or the data structure) to make illegal states **unrepresentable**.
*   **Example:** Don't pass two `bool`s (`is_loading`, `is_error`). Use a Sum Type / Enum / Union (`Loading | Error | Data`).

### 4.2 The Truth is in the Data
Code is transient; data is the payload.
*   Design your data structures **first**.
*   If the data structures are well-designed, the algorithms will be obvious.
*   If the data structures are messy, no amount of clever code will save you.

---

## AXIOM 5: EXPLICITNESS OVER IMPLICIT MAGIC

### 5.1 No Spooky Action at a Distance
*   **Forbidden:** Monkey-patching, global event buses with invisible listeners, implicit dependency injection containers that "scan" for classes.
*   **Required:** Dependencies are passed explicitly (Constructor Injection). Control flow is visible.

### 5.2 Local Reasoning
A developer should be able to understand a function by reading *only* that function and the signatures of the functions it calls. If they need to read a configuration file, a middleware setup, and a global state definition to understand the function, the code has failed.

---

## AXIOM 6: ERROR PHILOSOPHY

### 6.1 Errors are Data
Errors are not "exceptions" to the rule; they are a standard part of the domain.
*   **Network calls fail.**
*   **Files go missing.**
*   **Permissions are denied.**
Treat these as standard return values (`Result<T, E>`), not as catastrophic program interruptions.

### 6.2 Crash Early, Crash Loudly
For **programmer errors** (contract violations, impossible states), do not degrade gracefully. Crash immediately.
*   A hidden bug is a cancer. A crashing bug is a fix waiting to happen.
*   **Assertion:** `assert(user_id != null)` is better than `if (user_id == null) return`.

---

## AXIOM 7: THE TEST OF TIME

### 7.1 Dependencies are Liabilities
Every external library you import is a line of code you didn't write but must maintain.
*   **The Test:** Can you write it yourself in 2 hours? If yes, do not import the library.
*   **The Fear:** Left-pad incidents, abandoned maintainers, supply chain attacks.

### 7.2 Boring Technology
We prefer technology that is "done."
*   We use tools that have survived the hype cycle.
*   We prioritize stability over features.
*   We write code that could run in 5 years with minimal changes.

---

## APPENDIX: APPLYING THIS TO NEW LANGUAGES

When you encounter a language or framework not covered by a specific TEJL Guide, apply these mappings:

1.  **If the language has a Type System:** Enable the strictest mode available (e.g., C++ warnings as errors, PHP strict types).
2.  **If the language is Dynamic:** Create artificial boundaries (e.g., strict naming conventions, runtime schema validation like Zod/Pydantic).
3.  **If the language allows Global State:** Ban it via convention.
4.  **If the language allows Magic (Reflection/Metaprogramming):** Ban it via code review.

**We do not change our philosophy to fit the language. We bend the language to fit our philosophy.**

---

**Approved by:**
Board for Standardization and Development, TEJL d.o.o.

**Effective Date:** 2026-02-08
**Revision:** 2.0 (The Axioms)
