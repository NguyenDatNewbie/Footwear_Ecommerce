package com.reidshop.Service;


import com.reidshop.Model.Request.OrderCombineRequest;
import jakarta.servlet.http.HttpServletRequest;

import java.sql.Date;
import java.util.List;

public interface IOrdersService {
    int countAllOrders();
    Long countOrdersCreatedToday();
    Long countOrdersInCurrentMonth();
    Long countOrdersInCurrenYear();
    double revenueAll();
    double totalSalesOfToday();
    double totalSalesOfThisMonth();
    double totalSalesOfThisYear();
    Long countOrdersOfMonth(int year, int month);
    Long countOrderByDate(Date date);

    List<Integer> findAllOrderToday();
    List<Integer> findAllOrderOfThisWeek();
    double totalPriceOfThisWeek();

    List<Integer> findAllOrderOfThisMonth();

    List<Double> listTotalPriceOfThisWeek();
    List<Object[]> findOrderIdsByWeek();


    void savePaymentReceive(OrderCombineRequest orderCombineRequest, Long storeId, int type, HttpServletRequest request);
}
