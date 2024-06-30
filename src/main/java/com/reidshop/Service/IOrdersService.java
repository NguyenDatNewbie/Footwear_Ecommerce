package com.reidshop.Service;


import com.reidshop.Model.Entity.Evaluate;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.PaymentType;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Model.Request.OrderCombineRequest;
import jakarta.servlet.http.HttpServletRequest;

import java.sql.Date;
import java.time.LocalDate;
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

    void savePayment(OrderCombineRequest orderCombineRequest, ReceiveType receiveType, PaymentType paymentType, HttpServletRequest request);

    double calTotalOrder(OrderCombineRequest orderCombineRequest);

    void rateSave(Evaluate evaluate, long orderId);

    void UpdateOrderStatus(Long orderId, OrderStatus orderStatus);

    double totalSalesOfTodayStore(Long storeId);

    List<Orders> findOrdersByAccountAndStatus(Long id, String status);

    List<Orders> findOrderByAccountQuery(Long accountId, String keyword);

    double caculatorRevenueOfStoreByDate(Long storeId, LocalDate date);

    double totalSateOfStoreByDate(Long storeId, LocalDate date);

    double caculatorRevenueByDate(LocalDate date);

    double totalSateByDate(LocalDate date);
}
