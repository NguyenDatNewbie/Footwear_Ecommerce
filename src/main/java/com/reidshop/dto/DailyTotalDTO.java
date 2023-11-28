package com.reidshop.dto;


import java.sql.Date;

public class DailyTotalDTO {
    private Date orderDate;
    private Double dailyTotal;

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Double getDailyTotal() {
        return dailyTotal;
    }

    public void setDailyTotal(Double dailyTotal) {
        this.dailyTotal = dailyTotal;
    }

    public DailyTotalDTO(Date orderDate, Double dailyTotal) {
        this.orderDate = orderDate;
        this.dailyTotal = dailyTotal;
    }
    public String toString() {
        return "orderDate: " + orderDate + ", dailyTotal: " + dailyTotal;
    }
}
