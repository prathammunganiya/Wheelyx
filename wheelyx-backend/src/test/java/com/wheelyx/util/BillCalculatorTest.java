package com.wheelyx.util;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.math.BigDecimal;
import org.junit.jupiter.api.Test;

public class BillCalculatorTest {

    @Test
    void threeDaysWithDiscountTaxAndDeposit() {
        BigDecimal result = BillCalculator.totalPayable(
                new BigDecimal("1500"), 3,
                new BigDecimal("10"), new BigDecimal("18"),
                new BigDecimal("5000"));
        assertEquals(new BigDecimal("9779.00"), result);
    }

    @Test
    void zeroDaysIsNotAllowed() {
        assertThrows(IllegalArgumentException.class, () ->
                BillCalculator.totalPayable(
                        new BigDecimal("1500"), 0,
                        BigDecimal.ZERO, BigDecimal.ZERO, BigDecimal.ZERO));
    }
}
