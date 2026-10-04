# PYTHON ENTERPRISE CODE DOCTRINE

**Document Class:** 001-01/25-GUIDE
**Version:** 2.0 (Unified)
**Date:** 2026-02-08
**Scope:** Binding standards for all Python development in TEJL projects
**Target Runtime:** Python 3.12+ (3.13/3.14 Ready)

---

## PREAMBLE: THE DYNAMIC TRAP

**Problem Statement:**
Python's greatest strength (dynamic flexibility) is its greatest weakness in enterprise systems. Without discipline, Python codebases devolve into "runtime surprise" engines where type errors crash production services, circular imports paralyze architecture, and "God Dictionaries" obscure data structures.

**Our Solution:**
We write **Static Python**. We treat Python as a strongly-typed, compiled language. We utilize the modern capabilities of Python 3.12+ to enforce rigor at build time, not runtime.

---

## PART I: CORE PHILOSOPHY

### ARTICLE 1: THE PRIME DIRECTIVE

**"Explicit is better than implicit." (PEP 20)**

In an enterprise context, "magic" is technical debt.
1.  **No Magic:** Metaclasses, dynamic attribute injection (`__getattr__`), and complex decorators that obfuscate signatures are forbidden unless wrapped in a strictly typed interface.
2.  **Readability:** Code is written for the junior engineer on call at 3 AM, not for the interpreter.
3.  **Type Safety:** If it's not typed, it doesn't exist.

### ARTICLE 2: SINGLE RESPONSIBILITY & MODULES

#### 2.1 The "Utils" Prohibition
Creating a file named `utils.py`, `common.py`, or `helpers.py` is a failure of taxonomy.
*   ❌ **BAD:** `utils.py` containing string formatting, date parsing, and DB connection logic.
*   ✅ **GOOD:** `formatting.py`, `dates.py`, `db/connection.py`.

#### 2.2 Module Hygiene
Python modules are namespaces. Keep them clean.
*   **Public API:** Use `__all__` in `__init__.py` to explicitly define what a package exports.
*   **Internal logic:** Prefix internal helper functions/classes with `_` to signal "do not touch."

---

## PART II: ARCHITECTURE & STATE

### ARTICLE 3: DATA RIGOR (NO "GOD DICTIONARIES")

**Problem:** Passing dictionaries (`dict`) between layers creates "mystery meat" data structures. No one knows what keys exist without reading the implementation.

❌ **FORBIDDEN (The God Dict):**
```python
def process_user(data: dict):
    # What is in data? 'id'? 'user_id'? 'uid'? Who knows?
    if data.get('is_active'): ...
```

✅ **MANDATORY (Pydantic / Dataclasses):**
Use **Pydantic V2** models for external data (API/DB) and **Dataclasses** for internal domain objects.

```python
from pydantic import BaseModel, EmailStr

class UserPayload(BaseModel):
    user_id: str
    email: EmailStr
    is_active: bool = True

def process_user(user: UserPayload):
    if user.is_active: ...
```

### ARTICLE 4: IMMUTABILITY BY DEFAULT

Python is mutable by default. Enterprise code fights this.
*   **Dataclasses:** Use `@dataclass(frozen=True, slots=True)`. This improves memory usage (Python 3.10+) and prevents accidental state mutation.
*   **Collections:** Prefer `tuple` over `list` for fixed sequences.

### ARTICLE 5: FUNCTIONAL CORE, IMPERATIVE SHELL

Isolate pure logic from I/O to make testing trivial.

✅ **GOOD:**
```python
# Core (Pure)
def calculate_tax(amount: int, rate: float) -> int:
    return int(amount * rate)

# Shell (I/O)
async def process_order(order_id: str):
    order = await db.get_order(order_id) # I/O
    tax = calculate_tax(order.total, 0.2) # Logic
    await db.save_tax(order_id, tax) # I/O
```

### ARTICLE 6: DEPENDENCY HIERARCHY

**The Circular Import Killer:** Python resolves imports at runtime. Circular imports are a symptom of bad architecture.

**Rule:** Dependencies flow **down**.
1.  **Interface/API Layer** (FastAPI/CLI) -> Depends on Service
2.  **Service Layer** (Orchestration) -> Depends on Domain & Repositories
3.  **Domain Layer** (Models/Logic) -> **Depends on NOTHING.**

If `models.py` imports `services.py`, you have broken the architecture.

---

## PART III: IMPLEMENTATION DOCTRINE

### ARTICLE 7: TYPE HINTING (STRICT)

Type hints are not documentation; they are **syntax**.

#### 7.1 Strictness
*   **Rule:** Every function signature **must** have type hints.
*   **Rule:** `Any` is forbidden. If you must use it, you must add a `# type: ignore[misc]` comment with a justification.

#### 7.2 Modern Syntax (Python 3.12+)
Use the modern syntax. Do not import `List`, `Dict`, `Optional` from `typing`.

*   ❌ **Old:** `def fn(x: Optional[List[str]]) -> Union[int, None]:`
*   ✅ **New:** `def fn(x: list[str] | None) -> int | None:`

#### 7.3 Type Aliases
Use the `type` keyword (Python 3.12+) for complex structures.

```python
type JSONValue = dict[str, "JSONValue"] | list["JSONValue"] | str | int | float | bool | None
```

### ARTICLE 8: ERROR HANDLING DOCTRINE

#### 8.1 No Bare Excepts
❌ **STRICTLY FORBIDDEN:**
```python
try:
    process()
except:  # Catches KeyboardInterrupt and SystemExit!
    pass
```

✅ **REQUIRED:** Catch specific exceptions.

#### 8.2 Custom Exception Hierarchy
Don't raise `ValueError` for business logic errors. Define a domain hierarchy.

```python
class DomainError(Exception): ...
class UserNotFoundError(DomainError): ...
class InsufficientFundsError(DomainError): ...
```

#### 8.3 Exception Chaining
Always preserve the stack trace when re-raising.

```python
try:
    db.connect()
except ConnectionError as e:
    # "from e" attaches the original cause
    raise DatabaseUnavailableError("DB down") from e
```

### ARTICLE 9: ASYNC/CONCURRENCY (PYTHON 3.12+)

#### 9.1 No Blocking I/O
Never call a blocking function (requests, time.sleep, expensive CPU math) inside an `async def`. It freezes the entire event loop. Use `asyncio.to_thread` for blocking operations.

#### 9.2 Structured Concurrency
Avoid `asyncio.create_task` or `gather` for fire-and-forget. Use `asyncio.TaskGroup` (Python 3.11+) to guarantee tasks complete or fail together.

```python
async with asyncio.TaskGroup() as tg:
    tg.create_task(task_one())
    tg.create_task(task_two())
# Both await here; if one fails, other is cancelled.
```

---

## PART IV: QUALITY ASSURANCE

### ARTICLE 10: TESTING PYRAMID

1.  **Unit Tests (pytest):** Fast, mocked I/O.
2.  **Integration Tests:** Real DB, real API calls (using Docker containers via `testcontainers`).
3.  **Use Fixtures:** Do not use `setUp`/`tearDown`. Use `pytest.fixture` with `yield` for resource management.

### ARTICLE 11: STATIC ANALYSIS (THE GATES)

Our codebase must pass the following gates in CI:

1.  **Ruff:** The unified linter/formatter. Replaces Black, Isort, Flake8.
    *   Configuration: `line-length = 100`, `select = ["E", "F", "I", "N", "W", "UP", "B", "SIM"]`.
2.  **Mypy:** The type checker.
    *   Configuration: `strict = true`, `disallow_untyped_defs = true`.

---

## PART V: ANTI-PATTERNS (FORBIDDEN)

1.  **Mutable Default Arguments:**
    *   ❌ `def fn(items=[]):` (List persists across calls!)
    *   ✅ `def fn(items: list | None = None):`
2.  **Wildcard Imports:**
    *   ❌ `from module import *` (Pollutes namespace, confuses linters).
3.  **Variable Shadowing:**
    *   Naming variables `id`, `list`, `type`, or `dict`.
4.  **Zombie Code:**
    *   Commented-out code blocks must be deleted. Use Git history if you need to recall it.

---

## PART VI: TOOLING CONFIGURATION

All projects must include a `pyproject.toml` enforcing these standards.

```toml
[project]
requires-python = ">=3.12"

[tool.ruff]
line-length = 100
target-version = "py312"

[tool.ruff.lint]
select = [
    "E", "F", "W", # Pyflakes/pycodestyle
    "I",           # Isort
    "UP",          # Pyupgrade (modern syntax)
    "B",           # Bugbear (potential bugs)
    "SIM",         # Flake8-simplify
    "N",           # Pep8-naming
]

[tool.mypy]
python_version = "3.12"
strict = true
ignore_missing_imports = false
```

---

**Approved by:**
Board for Standardization and Development, TEJL d.o.o.

**Effective Date:** 2026-02-08
**Revision:** 2.0 (Unified Doctrine)
