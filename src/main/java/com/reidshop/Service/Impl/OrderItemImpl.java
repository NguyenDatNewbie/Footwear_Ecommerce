package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.OrderItem;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Model.Request.OrderCombineRequest;
import com.reidshop.Reponsitory.InventoryRepository;
import com.reidshop.Reponsitory.OrderItemRepository;
import com.reidshop.Service.IOrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderItemImpl implements IOrderItemService {
    @Autowired
    OrderItemRepository orderItemRepository;
    @Autowired
    InventoryRepository inventoryRepository;

    @Override
    public double totalPriceOriginalOrders(int orderId) {
        return orderItemRepository.totalPriceOriginalOrders(orderId);
    }


    @Override
    public void save(Inventory inventory, int quantity, double price, Orders orders){
        OrderItem orderItem = new OrderItem();
        orderItem.setOrder(orders);
        orderItem.setInventory(inventory);
        orderItem.setPrice(price);
        orderItem.setQuantity(quantity);
        orderItemRepository.save(orderItem);
    }

    @Override
    public double save(OrderCombineRequest item, Orders orders){
        double totalPrice = 0.0;
        for(CartRequest cartRequest: item.getCarts()){
            OrderItem orderItem = new OrderItem();
            Inventory inventory = inventoryRepository.findByStore(cartRequest.getId(), cartRequest.getSize(), cartRequest.getQuantity(), item.getStoreValid().get(0).getStore().getId());
            orderItem.setOrder(orders);
            orderItem.setInventory(inventory);
            Product product = inventory.getSize().getProduct();
            orderItem.setPrice(product.getPrice()*(1-product.getPromotion()/100.0));
            orderItem.setQuantity(cartRequest.getQuantity());
            orderItemRepository.save(orderItem);
            totalPrice += orderItem.getPrice()*orderItem.getQuantity();
        }
        return totalPrice;
    }

}
