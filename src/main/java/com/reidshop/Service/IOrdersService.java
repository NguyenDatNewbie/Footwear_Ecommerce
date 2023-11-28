package com.reidshop.Service;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.dto.DailyTotalDTO;
import org.springframework.data.repository.query.Param;

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


}
