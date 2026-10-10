package com.wheelyx.service;

import com.wheelyx.dao.*;
import com.wheelyx.model.*;

import java.util.UUID;

public class BillingService {

    private final BillDAO billDAO = new BillDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    public Bill getBillForBooking(Long bookingId) {
        return billDAO.findByBookingId(bookingId);
    }

    public Payment processPayment(Long billId, Long customerId, String paymentMethod, String ipAddress) {
        Bill bill = billDAO.findById(billId);
        if (bill == null) return null;

        Booking booking = bookingDAO.findById(bill.getBookingId());
        if (booking == null || !booking.getCustomerId().equals(customerId)) {
            return null;
        }

        String txnId = "TXN-" + UUID.randomUUID().toString().substring(0, 10).toUpperCase();
        String gatewayRef = "SIM-GW-" + System.currentTimeMillis();

        Payment payment = new Payment();
        payment.setTransactionId(txnId);
        payment.setBillId(billId);
        payment.setBookingId(bill.getBookingId());
        payment.setCustomerId(customerId);
        payment.setPaymentMethod(paymentMethod != null ? paymentMethod.toUpperCase() : "UPI");
        payment.setAmount(bill.getFinalAmount());
        payment.setStatus("SUCCESS");
        payment.setGatewayRef(gatewayRef);

        boolean created = paymentDAO.create(payment);
        if (created) {
            AuditLogDAO.log(customerId, "CUSTOMER", "PAYMENT_SUCCESS", "PAYMENT", payment.getId(),
                    "Simulated payment processed via " + payment.getPaymentMethod() + " (" + txnId + ")", ipAddress);
            return payment;
        }
        return null;
    }
}
