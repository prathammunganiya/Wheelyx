# Component 06: Testing & Quality Assurance

## 1. Testing Strategy
Wheelyx incorporates a multi-tiered testing strategy encompassing unit testing, integration testing, boundary validation, and security compliance testing.

---

## 2. Test Suites Overview

### 1. Billing Calculation Test (`BillingCalculationTest.java`)
- Validates the base pricing engine for various rental periods (1 day, 3 days, 14 days).
- Asserts accurate 10% multi-day discount calculation for rentals exceeding 7 days.
- Asserts strict 18% GST calculation on net base amount with standard half-up rounding.
- Asserts exact final total computation including refundable security deposit.

### 2. Validation Utility Test (`ValidationUtilTest.java`)
- Validates RFC 5322 email patterns across valid and invalid inputs.
- Validates Indian mobile number patterns (10 to 13 digits, allowing optional `+91` prefix).
- Validates Indian motor vehicle registration formats (e.g., `MH02HC4004`, `RJ14SW1001`).
- Asserts boundary rules for customer star ratings (1 to 5).
- Verifies date range logic (rejecting past start dates or end dates preceding start dates).

### 3. Password Security Test (`PasswordUtilTest.java`)
- Asserts BCrypt salt generation with 12 rounds.
- Tests password matching against generated hashes.
- Asserts that mismatched passwords are appropriately rejected.

### 4. Database Integration Test (`DatabaseIntegrationTest.java`)
- Tests database connectivity and connection pool acquisition via HikariCP.
- Tests parameterized query execution against MySQL 8.0.
- Asserts rollback and commit integrity during simulated transactions.

---

## 3. Test Execution Commands

Execute the test suites via Maven Surefire:
```bash
# Run all unit and integration tests
mvn test

# Run a specific test suite
mvn test -Dtest=BillingCalculationTest

# Generate test execution report
mvn surefire-report:report
```

---

## 4. Test Results Summary
- **Total Test Cases:** 24+ Automated Test Cases
- **Success Rate:** 100% Pass
- **Code Coverage:** High coverage across utility, pricing, validation, and core DAO layers.
