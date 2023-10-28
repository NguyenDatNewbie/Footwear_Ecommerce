package com.reidshop.Service;

import com.reidshop.Model.Entity.Category;
import org.springframework.data.repository.query.Param;

import java.sql.Date;
import java.util.List;

public interface IOrdersService {
    int countAllOrders();
    Long countOrdersCreatedToday();
    Long countOrdersInCurrentMonth();
    Long countOrdersInCurrenYear();
    double revenueAll();
    double totalRevenueOfToday();
    double totalRevenueOfThisMonth();
    double totalRevenueOfThisYear();
    Long countOrdersOfMonth(int year, int month);
    Long countOrderByDate(Date date);


}
