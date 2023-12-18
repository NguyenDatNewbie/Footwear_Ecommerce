package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.OrderItem;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Model.Request.OrderCombineRequest;
import com.reidshop.Reponsitory.InventoryRepository;
import com.reidshop.Reponsitory.OrderItemRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.IOrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderItemImpl implements IOrderItemService {
    @Autowired
    OrderItemRepository orderItemRepository;
    @Autowired
    InventoryRepository inventoryRepository;
    @Autowired
    ProductRepository productRepository;
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


        inventory.setQuantity(inventory.getQuantity()-quantity);
        inventoryRepository.save(inventory);
        Product product = inventory.getSize().getProduct();
        product.setSold(product.getSold()+quantity);
        productRepository.save(product);
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

            inventory.setQuantity(inventory.getQuantity()-cartRequest.getQuantity());
            inventoryRepository.save(inventory);
            product.setSold(product.getSold()+cartRequest.getQuantity());
            productRepository.save(product);

            totalPrice += orderItem.getPrice()*orderItem.getQuantity();
        }
        return totalPrice;
    }

    @Override
    public double totalPriceOfOrderId(Long orderId) {
        List<OrderItem> itemList = orderItemRepository.findAllItemByOrderId(orderId);
        double priceOrder = 0;
        for(OrderItem item : itemList){
            priceOrder += (item.getPrice()*item.getQuantity());
        }
        return priceOrder;
    }

}
