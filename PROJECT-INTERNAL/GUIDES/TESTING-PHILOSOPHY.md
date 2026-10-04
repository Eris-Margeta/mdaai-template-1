# TESTING PHILOSOPHY

**Guidelines for Testing Approach and AI-Human Alignment**

---

## CHAPTER I: CORE PHILOSOPHY

### **Article 1: The Alignment Principle**

(1) **AI tests the same way a human developer would test.**

(2) This means:
- Same commands
- Same tools
- Same frameworks
- Same output interpretation
- Same success/failure criteria

(3) **AI and human developer MUST see the same things, in the same way.**

### **Article 2: No Special AI Environments**

(1) **PROHIBITED:**
- AI-specific test sandboxes
- Obscure testing frameworks only AI uses
- Hidden test outputs
- Special AI-only test modes

(2) **REQUIRED:**
- Use the project's configured test runner
- Use Justfile/Makefile commands when available
- Run tests exactly as documented in README
- See the same output a human would see

### **Article 3: Justfile as Test Interface**

(1) When a project has a Justfile, use it for testing:

```bash
# CORRECT
just test
just test-unit
just test-integration
just lint

# WRONG
python -m pytest tests/ --obscure-ai-flag
npm test -- --special-hidden-mode
```

(2) If Justfile commands don't exist, use the standard commands documented in README.

(3) **Never invent test commands.** Use what the project provides.

---

## CHAPTER II: TEST DESIGN PRINCIPLES

### **Article 4: Universal Tests Over Hardcoded Tests**

(1) Tests should catch **classes of issues**, not specific instances.

(2) **Hardcoded Test (WRONG):**
```javascript
test("user ID 42 doesn't cause error", () => {
  const user = { id: 42, name: "John" };
  expect(process(user)).not.toThrow();
});
```

(3) **Universal Test (CORRECT):**
```javascript
test("all valid users are processed without error", () => {
  const testCases = generateValidUsers(); // Various edge cases
  testCases.forEach(user => {
    expect(process(user)).not.toThrow();
  });
});

test("users with special characters in name are handled", () => {
  const specialNames = ["O'Brien", "José", "名前", ""];
  specialNames.forEach(name => {
    const user = createUser({ name });
    expect(process(user)).not.toThrow();
  });
});
```

### **Article 5: Test What Matters**

(1) **Test BEHAVIOR, not implementation.**

(2) A test should answer: "Does this feature work correctly?"
   NOT: "Does this function call that function?"

(3) **Behavior Test (GOOD):**
```javascript
test("login with valid credentials returns user session", async () => {
  const session = await login("valid@email.com", "correctPassword");
  expect(session.token).toBeDefined();
  expect(session.expiresIn).toBeGreaterThan(0);
});
```

(4) **Implementation Test (BAD):**
```javascript
test("login calls hashPassword then calls database", async () => {
  const hashSpy = jest.spyOn(crypto, "hashPassword");
  const dbSpy = jest.spyOn(database, "findUser");
  await login("email", "password");
  expect(hashSpy).toHaveBeenCalledBefore(dbSpy);
});
```

### **Article 6: Error Path Testing**

(1) **Test error cases as thoroughly as success cases.**

(2) Required error tests:
- Invalid input
- Missing required fields
- Boundary conditions
- Network failures (if applicable)
- Permission denied scenarios
- Resource not found scenarios

(3) **Error tests verify the error itself, not just that something was thrown:**
```javascript
// GOOD - Verifies the specific error
test("missing email returns validation error", async () => {
  const result = await login("", "password");
  expect(result.error.code).toBe("VALIDATION_ERROR");
  expect(result.error.field).toBe("email");
});

// BAD - Only checks something threw
test("missing email throws", async () => {
  expect(() => login("", "password")).toThrow();
});
```

---

## CHAPTER III: TEST ORGANIZATION

### **Article 7: Test File Structure**

(1) **Mirror source structure:**
```
src/
  auth/
    login.ts
    session.ts
  utils/
    validation.ts

tests/
  auth/
    login.test.ts
    session.test.ts
  utils/
    validation.test.ts
```

(2) One test file per source file (for unit tests).

(3) Integration tests may span multiple source files.

### **Article 8: Test Naming Convention**

(1) Test names should describe:
- What is being tested
- Under what conditions
- Expected outcome

(2) **Format:** `[feature] [condition] [expected outcome]`

(3) **Examples:**
```javascript
describe("User Authentication", () => {
  test("login with valid credentials returns session token");
  test("login with invalid password returns authentication error");
  test("login with locked account returns account locked error");
  test("session expires after configured timeout");
});
```

### **Article 9: Test Data Management**

(1) **Use factories/builders for test data:**
```javascript
// GOOD - Factory function
const user = createTestUser({ email: "test@example.com" });

// BAD - Inline object literal repeated everywhere
const user = { id: 1, email: "test@example.com", name: "Test", ... };
```

(2) **Keep test data close to tests** but avoid duplication.

(3) **Use fixtures for complex/large data sets.**

---

## CHAPTER IV: RUNNING TESTS

### **Article 10: Test Commands**

(1) **Standard test commands (prefer these in order):**

1. Justfile commands: `just test`, `just test-unit`, `just lint`
2. Makefile commands: `make test`, `make lint`
3. Package manager: `npm test`, `cargo test`, `go test`
4. Direct tool: `pytest`, `jest`, `vitest`

(2) **Never use undocumented flags or modes.**

### **Article 11: Test Output Interpretation**

(1) AI reads test output exactly as human would.

(2) **Success indicators:**
- "X tests passed"
- Green checkmarks
- Exit code 0

(3) **Failure indicators:**
- "X tests failed"
- Red X marks
- Stack traces
- Exit code non-zero

(4) **When tests fail, report:**
- Which test(s) failed
- The error message
- Relevant stack trace
- What the test was checking

### **Article 12: Test Isolation**

(1) Each test MUST be independent.

(2) Tests MUST NOT:
- Depend on execution order
- Share mutable state
- Leave side effects
- Require manual cleanup

(3) **Tests can run in any order and still pass.**

---

## CHAPTER V: COVERAGE

### **Article 13: Coverage Philosophy**

(1) **Coverage measures BEHAVIOR coverage, not line coverage.**

(2) 100% line coverage with poor tests is worse than 80% coverage with excellent tests.

(3) **Focus on:**
- All public APIs tested
- All user-facing features tested
- All error paths tested
- All edge cases tested

### **Article 14: Coverage Targets**

(1) Recommended minimums (project may set higher):

| Test Type | Minimum Coverage |
|-----------|------------------|
| Unit | 80% of public functions |
| Integration | All component boundaries |
| E2E | All critical user paths |

(2) **Missing coverage is acceptable if documented and justified.**

(3) **False coverage (tests that don't really test anything) is a violation.**

---

## CHAPTER VI: FOR AI AGENTS

### **Article 15: AI Testing Checklist**

(1) Before running tests:
- [ ] Check for Justfile/Makefile
- [ ] Use documented test commands
- [ ] Don't invent special flags

(2) When writing tests:
- [ ] Test is universal, not hardcoded
- [ ] Test verifies behavior, not implementation
- [ ] Test covers both success and error paths
- [ ] Test name describes what it tests

(3) When tests fail:
- [ ] Read and understand the error
- [ ] Don't blindly retry
- [ ] Report failure clearly
- [ ] Follow Beta Error Resolution Workflow if in Beta phase

### **Article 16: AI Test Creation Workflow**

(1) When creating a new test:

```
1. Identify what behavior needs testing
2. Check existing tests for patterns/style
3. Write test following project conventions
4. Run test - should fail if testing fix, pass if testing new feature
5. Verify test actually tests what it claims
```

(2) **Never write a test that always passes regardless of implementation.**

---

## CHAPTER VII: FINAL PROVISIONS

### **Article 17: Testing Agent**

(1) Projects may use a specialized testing agent for:
- Suggesting test types appropriate for the project
- Reviewing test quality
- Identifying missing test coverage
- Running comprehensive test suites

(2) The testing agent follows all principles in this document.

### **Article 18: Entry Into Force**

(1) This philosophy guide applies to all testing work under TEJL governance.

(2) It supplements BETA-PHASE-PROTOCOL.md and CODE-PHILOSOPHY.md.

---

**Compiled by:**
AI Assistant, System Integration Sector

**Approved by:**
Operator, Board for Standardization and Development of TEJL
