package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Request.StockRequest;
import com.reidshop.Reponsitory.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.Optional;

@Service
public class StockServiceImpl {
    @Autowired
    InventoryRepository inventoryRepository;
    @Autowired
    StockRepository stockRepository;
    @Autowired
    ProductOutOfStockRepository productOutOfStockRepository;
    @Autowired
    OrdersRepository ordersRepository;
    @Autowired
    OrderItemRepository orderItemRepository;
    public String save(Store store, List<StockRequest> stockRequests, Supplier supplier){
        try {
            Stock stock = new Stock();
            stock.setSupplier(supplier);
            stock.setStore(store);
            stock.setCreatedAt(Date.valueOf(LocalDate.now()));
            Stock complete = stockRepository.save(stock);
            List<StockRequest.PriorityOrder> priorityOrders = new ArrayList<>();
            for (StockRequest stockRequest:stockRequests) {
                Inventory inventory = new Inventory();
                inventory.setStock(complete);
                inventory.setSize(stockRequest.getSize());
                inventory.setQuantity(stockRequest.getQuantity());
                inventory.setImportPrice(stockRequest.getPrice());
                inventory.setStore(store);
                inventory.setColor(stockRequest.getColor());
                Inventory i =  inventoryRepository.save(inventory);
                if(stockRequest.getPriorityOrder().getId()!=0)
                {
                    StockRequest.PriorityOrder priorityOrder = stockRequest.getPriorityOrder();
                    priorityOrder.setInventory(i);
                    priorityOrders.add(priorityOrder);
                }
            }
            checkAndUpdateInProductOutOfStock(stock,store,priorityOrders);
            return "success";
        }
        catch (Exception exception){
            return exception.getMessage();
        }
    }

    void checkAndUpdateInProductOutOfStock(Stock stock, Store store, List<StockRequest.PriorityOrder> priorityOrders){
        List<ProductOutOfStock> productOutOfStocks = productOutOfStockRepository.findAllByStoreId(store.getId());
        List<ProductOutOfStock> removed = new ArrayList<>();

        for (StockRequest.PriorityOrder priorityOrder : priorityOrders){
            Inventory iv = priorityOrder.getInventory();
            // Xử lý ưu tiên cho order
            Optional<ProductOutOfStock> foundItem = productOutOfStocks.stream()
                    .filter(item -> item.getOrders().getId() == priorityOrder.getId()
                            && item.getColor() == iv.getColor()
                            && item.getSize() == iv.getSize())
                    .findFirst();

            if(foundItem.isPresent()){
                productOutOfStocks = sortByPriority(productOutOfStocks,foundItem.get());
            }
            int count =0;

            for(ProductOutOfStock p: productOutOfStocks){
                count++;
                if(removed.contains(p))
                    continue;
                List<Inventory> checkExits = inventoryRepository.checkExistInStock(stock,iv.getSize().getId(),iv.getColor().getId());
                if(checkExits.contains(priorityOrder.getInventory())
                        && priorityOrder.getId() == p.getOrders().getId()) {
                    int quantity = addToOrderItemFollowPriority(p,priorityOrder.getInventory());
                    if(quantity!=0)
                    {
                        p.setQuantity(quantity);
                        productOutOfStocks.set(count-1,p);
                    }
                    else{ removed.add(p); continue;}
                }

                checkExits = inventoryRepository.checkExistInStock(stock,p.getSize().getId(),p.getColor().getId());
                List<Inventory> inventories = inventoryRepository.findAllOutStock(stock,p.getSize().getId(),p.getColor().getId());
                inventories.addAll(checkExits);
                int quantity = p.getQuantity();
                List<Inventory> beUsed = new ArrayList<>();
                for(Inventory i: inventories){
                    beUsed.add(i);
                    // Code ở trên sẽ xử lý priority
                    if(priorityOrders.contains(i))
                        continue;
                    if(i.getQuantity()>=quantity){
                        addToOrderItem(beUsed,p);
                        // Send mail
                        break;
                    }
                    else{
                        quantity -= i.getQuantity();
                    }
                }

            }
        }

    }

    List<ProductOutOfStock> sortByPriority(List<ProductOutOfStock> list, ProductOutOfStock priority){
        List<ProductOutOfStock> newList = new ArrayList<>();
        newList.add(priority);
        for (ProductOutOfStock p: list) {
            if(!list.equals(p))
                newList.add(p);
        }
        return newList;
    }
    int addToOrderItemFollowPriority(ProductOutOfStock p, Inventory inventory){
        OrderItem orderItem = new OrderItem();
        orderItem.setOrder(p.getOrders());
        orderItem.setPrice(p.getPrice());
        orderItem.setInventory(inventory);
        int quantity = 0;
        if(inventory.getQuantity()>=p.getQuantity())
        {
            orderItem.setQuantity(p.getQuantity());
            inventory.setQuantity(inventory.getQuantity()-p.getQuantity());
            productOutOfStockRepository.delete(p);
        }
        else {
            orderItem.setQuantity(inventory.getQuantity());
            p.setQuantity(p.getQuantity()-inventory.getQuantity());
            quantity = p.getQuantity();
            inventory.setQuantity(0);
            productOutOfStockRepository.save(p);
        }

        inventoryRepository.save(inventory);
        orderItemRepository.save(orderItem);
        return quantity;
    }
    void addToOrderItem(List<Inventory> inventories, ProductOutOfStock p){
        Orders orders = p.getOrders();
        for (Inventory i: inventories) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(orders);
            orderItem.setPrice(p.getPrice());
            orderItem.setInventory(i);
            orderItem.setQuantity(p.getQuantity());
            orderItemRepository.save(orderItem);

            i.setQuantity(i.getQuantity()-p.getQuantity());
            inventoryRepository.save(i);
            productOutOfStockRepository.delete(p);
        }
    }
}
