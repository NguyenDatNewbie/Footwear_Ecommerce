package com.reidshop.Service;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Request.OrderCombineRequest;

public interface IOrderItemService {
    double totalPriceOriginalOrders(int orderId);

    void save(Inventory inventory, int quantity, double price, Orders orders);

    double save(OrderCombineRequest item, Orders orders);

    double totalPriceOfOrderId(Long orderId);   //Tính total price của 1 order
}
