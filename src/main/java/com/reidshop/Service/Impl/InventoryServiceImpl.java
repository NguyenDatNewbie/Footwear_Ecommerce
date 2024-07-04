package com.reidshop.Service.Impl;

import com.reidshop.Reponsitory.InventoryRepository;
import com.reidshop.Service.IInventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InventoryServiceImpl implements IInventoryService {
    @Autowired
    InventoryRepository inventoryRepository;
    @Override
    public int getQuantityOfProduct(Long storeId, Long sizeId, Long colorId) {
        return inventoryRepository.getQuantityOfProduct(storeId, sizeId, colorId);
    }
}