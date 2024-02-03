package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Request.StockRequest;
import com.reidshop.Reponsitory.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

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
            for (StockRequest stockRequest:stockRequests) {
                Inventory inventory = new Inventory();
                inventory.setStock(complete);
                inventory.setSize(stockRequest.getSize());
                inventory.setQuantity(stockRequest.getQuantity());
                inventory.setImportPrice(stockRequest.getPrice());
                inventory.setStore(store);
                Inventory completeInventory =  inventoryRepository.save(inventory);
                checkAndUpdateInProductOutOfStock(completeInventory,store);
            }
            return "success";
        }
        catch (Exception exception){
            return exception.getMessage();
        }
    }

    // Lỗi orderItem nếu quantity cần nhiều inventory để đáp ứng được quantity thì không biết lưu cho inventory nào
    void checkAndUpdateInProductOutOfStock(Inventory inventory,Store store){
        List<ProductOutOfStock> productOutOfStocks = productOutOfStockRepository.findAllByStoreId(store.getId());
        System.out.println("1");
        for(ProductOutOfStock p: productOutOfStocks){

            if(p.getSize().getId() == inventory.getSize().getId())
            {
                if(inventory.getQuantity()>=p.getQuantity()) {
                    System.out.println("0");
                    inventory.setQuantity(inventory.getQuantity()-p.getQuantity());
                    Orders orders = p.getOrders();
                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrder(orders);
                    orderItem.setPrice(p.getPrice());
                    orderItem.setInventory(inventory);
                    orderItem.setQuantity(p.getQuantity());
                    productOutOfStockRepository.delete(p);
                    orderItemRepository.save(orderItem);
                    orders.setStatus(OrderStatus.PREPARE);
                    ordersRepository.save(orders);
                    inventoryRepository.save(inventory);
                }
                // Nếu như nhập có size đúng thì phải trừ trong productOutOfStock
//                else
            }
        }
    }
}
