package com.reidshop.Service.Impl;

import com.reidshop.Entity.Orders;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Service.IOrdersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrdersServiceImpl implements IOrdersService {
    @Autowired
    OrdersRepository ordersRepository;

    public OrdersServiceImpl(OrdersRepository ordersRepository) {
        this.ordersRepository = ordersRepository;
    }
    @Override
    public int countAllOrders() {
        return ordersRepository.countAllOrders();
    }

    @Override
    public Long countOrdersCreatedToday() {
        return ordersRepository.countOrdersCreatedToday();
    }

    @Override
    public Long countOrdersInCurrentMonth() {
        return ordersRepository.countOrdersInCurrentMonth();
    }

    @Override
    public Long countOrdersInCurrenYear() {
        return ordersRepository.countOrdersInCurrenYear();
    }

    @Override
    public double revenueAll() {
        return ordersRepository.revenueAll();
    }

    @Override
    public double totalRevenueOfToday() {
        return ordersRepository.totalRevenueOfToday();
    }

    @Override
    public double totalRevenueOfThisMonth() {
        return ordersRepository.totalRevenueOfThisMonth();
    }

    @Override
    public double totalRevenueOfThisYear() {
        return ordersRepository.totalRevenueOfThisYear();
    }

    @Override
    public Long countOrdersOfMonth(int year, int month) {
        return ordersRepository.countOrdersOfMonth(year, month);
    }

    @Override
    public Long countOrderByDate(Date date) {
        return ordersRepository.countOrderByDate(date);
    }
}
