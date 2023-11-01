package com.reidshop.Service.Impl;

import com.reidshop.Reponsitory.OrderItemRepository;
import com.reidshop.Service.IOrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderItemImpl implements IOrderItemService {
    @Autowired
    OrderItemRepository orderItemRepository;
    @Override
    public double totalPriceOriginalOrders(int orderId) {
        return orderItemRepository.totalPriceOriginalOrders(orderId);
    }
}
