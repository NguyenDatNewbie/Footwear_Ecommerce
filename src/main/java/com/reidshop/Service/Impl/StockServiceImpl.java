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
                inventory.setColor(stockRequest.getColor());
                inventoryRepository.save(inventory);
            }
            checkAndUpdateInProductOutOfStock(stock,store);
            return "success";
        }
        catch (Exception exception){
            return exception.getMessage();
        }
    }

    void checkAndUpdateInProductOutOfStock(Stock stock,Store store){
        List<ProductOutOfStock> productOutOfStocks = productOutOfStockRepository.findAllByStoreId(store.getId());
        for(ProductOutOfStock p: productOutOfStocks){
            List<Inventory> checkExits = inventoryRepository.checkExistInStock(stock,p.getSize().getId(),p.getColor().getId());
            if(checkExits.size()>0){
                List<Inventory> inventories = inventoryRepository.findAllOutStock(stock,p.getSize().getId(),p.getColor().getId());
                inventories.addAll(checkExits);
                for(Inventory i: inventories){
                    Orders orders = p.getOrders();
                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrder(orders);
                    orderItem.setPrice(p.getPrice());
                    orderItem.setInventory(i);
                    if(i.getQuantity()>=p.getQuantity()){
                        i.setQuantity(i.getQuantity()-p.getQuantity());
                        inventoryRepository.save(i);
                        orderItem.setQuantity(p.getQuantity());
                        orderItemRepository.save(orderItem);
                        productOutOfStockRepository.delete(p);
                        break;
                    }
                    else{
                        orderItem.setQuantity(i.getQuantity());
                        i.setQuantity(0);
                        inventoryRepository.save(i);
                        orderItemRepository.save(orderItem);
                    }
                }

            }
        }
    }
}
