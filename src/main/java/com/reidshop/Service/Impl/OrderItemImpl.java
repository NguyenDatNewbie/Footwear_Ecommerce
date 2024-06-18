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

    private void saveComponent(Inventory inventory, OrderItem orderItem){
        Product product = inventory.getSize().getProduct();
        orderItem.setInventory(inventory);
        orderItem.setPrice(product.getPrice()*(1-product.getPromotion()/100.0));
        orderItemRepository.save(orderItem);

        inventoryRepository.save(inventory);

        product.setSold(product.getSold()+orderItem.getQuantity());
        productRepository.save(product);
    }
    @Override
    public double save(OrderCombineRequest item, Orders orders){
        double totalPrice = 0.0;
        for(CartRequest cartRequest: item.getCarts()){
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(orders);
            Inventory inventory = inventoryRepository.findByStore(cartRequest.getId(), cartRequest.getSize(), cartRequest.getQuantity(), item.getStoreValid().get(0).getStore().getId(), cartRequest.getColor());
            if(inventory==null){
                List<Inventory> inventories = inventoryRepository.findAllInventoryValid(cartRequest.getId(), cartRequest.getSize(), cartRequest.getColor(), orders.getStore().getId());
                for (Inventory i: inventories) {
                    if(cartRequest.getQuantity()==0)
                        break;
                    orderItem = new OrderItem();
                    orderItem.setOrder(orders);
                    if(cartRequest.getQuantity()>i.getQuantity()){
                        orderItem.setQuantity(i.getQuantity());
                        cartRequest.setQuantity(cartRequest.getQuantity()-i.getQuantity());
                        i.setQuantity(0);
                    }
                    else {
                        orderItem.setQuantity(cartRequest.getQuantity());
                        i.setQuantity(i.getQuantity()-cartRequest.getQuantity());
                        cartRequest.setQuantity(0);
                    }
                    saveComponent(i,orderItem);
                }
            }
            else {
                inventory.setQuantity(inventory.getQuantity()-cartRequest.getQuantity());
                orderItem.setQuantity(cartRequest.getQuantity());
                saveComponent(inventory,orderItem);
            }
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

    @Override
    public void reInventory(Long orderId){
        List<OrderItem> itemList = orderItemRepository.findAllItemByOrderId(orderId);
        for (OrderItem item: itemList) {
            item.getInventory().setQuantity(item.getQuantity()+item.getInventory().getQuantity());
            inventoryRepository.save(item.getInventory());
        }
    }

    @Override
    public double totalPriceOriginalOrdersNew(Long orderId) {
        return orderItemRepository.totalPriceOriginalOrdersNew(orderId);
    }

}
