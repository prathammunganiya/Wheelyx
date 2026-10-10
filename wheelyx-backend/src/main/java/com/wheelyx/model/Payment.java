package com.wheelyx.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Payment {
    private Long id;
    private String transactionId;
    private Long billId;
    private Long bookingId;
    private Long customerId;
    private String paymentMethod; // UPI, CARD, CASH, NET_BANKING
    private BigDecimal amount;
    private String status; // PENDING, SUCCESS, FAILED, REFUNDED
    private String gatewayRef;
    private Timestamp paymentDate;

    // Joined fields
    private String billNo;
    private String bookingCode;
    private String customerName;

    public Payment() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public Long getBillId() { return billId; }
    public void setBillId(Long billId) { this.billId = billId; }

    public Long getBookingId() { return bookingId; }
    public void setBookingId(Long bookingId) { this.bookingId = bookingId; }

    public Long getCustomerId() { return customerId; }
    public void setCustomerId(Long customerId) { this.customerId = customerId; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getGatewayRef() { return gatewayRef; }
    public void setGatewayRef(String gatewayRef) { this.gatewayRef = gatewayRef; }

    public Timestamp getPaymentDate() { return paymentDate; }
    public void setPaymentDate(Timestamp paymentDate) { this.paymentDate = paymentDate; }

    public String getBillNo() { return billNo; }
    public void setBillNo(String billNo) { this.billNo = billNo; }

    public String getBookingCode() { return bookingCode; }
    public void setBookingCode(String bookingCode) { this.bookingCode = bookingCode; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
}
