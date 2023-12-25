package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Stock;
import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Entity.Supplier;
import com.reidshop.Model.Request.StockRequest;
import com.reidshop.Reponsitory.InventoryRepository;
import com.reidshop.Reponsitory.StockRepository;
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
                inventoryRepository.save(inventory);
            }
        }
        catch (Exception exception){
            return exception.getMessage();
        }
        return "success";
    }
}
