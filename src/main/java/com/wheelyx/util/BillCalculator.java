package com.wheelyx.util;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class BillCalculator {

    // Total payable = (base - discount) + tax + deposit
    public static BigDecimal totalPayable(BigDecimal dailyRate, int days,
                                          BigDecimal discountPercent,
                                          BigDecimal taxPercent,
                                          BigDecimal deposit) {
        if (days <= 0) {
            throw new IllegalArgumentException("Days must be at least 1");
        }
        BigDecimal base = dailyRate.multiply(BigDecimal.valueOf(days));
        BigDecimal discount = percent(base, discountPercent);
        BigDecimal afterDiscount = base.subtract(discount);
        BigDecimal tax = percent(afterDiscount, taxPercent);
        return afterDiscount.add(tax).add(deposit).setScale(2, RoundingMode.HALF_UP);
    }

    // amount ka kitna percent nikalna hai
    private static BigDecimal percent(BigDecimal amount, BigDecimal percent) {
        return amount.multiply(percent)
                     .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);
    }
}