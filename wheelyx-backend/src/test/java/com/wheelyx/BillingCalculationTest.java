package com.wheelyx;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.math.RoundingMode;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class BillingCalculationTest {

    @Test
    @DisplayName("Should correctly calculate GST 18%, security deposit and final invoice balance")
    void testInvoiceCalculation() {
        BigDecimal dailyRate = new BigDecimal("1500.00");
        int days = 3;
        BigDecimal securityDeposit = new BigDecimal("2500.00");
        BigDecimal discount = new BigDecimal("200.00");

        // Base amount: 1500 * 3 = 4500
        BigDecimal baseAmount = dailyRate.multiply(BigDecimal.valueOf(days));
        assertEquals(new BigDecimal("4500.00"), baseAmount);

        // Tax: 18% GST on base rental = 4500 * 0.18 = 810.00
        BigDecimal taxRate = new BigDecimal("0.18");
        BigDecimal taxAmount = baseAmount.multiply(taxRate).setScale(2, RoundingMode.HALF_UP);
        assertEquals(new BigDecimal("810.00"), taxAmount);

        // Final amount = base (4500) + deposit (2500) + tax (810) - discount (200) = 7610.00
        BigDecimal finalAmount = baseAmount
                .add(securityDeposit)
                .add(taxAmount)
                .subtract(discount)
                .setScale(2, RoundingMode.HALF_UP);

        assertEquals(new BigDecimal("7610.00"), finalAmount);
    }
}
