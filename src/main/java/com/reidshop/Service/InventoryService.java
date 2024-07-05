package com.reidshop.Service;

public interface InventoryService {
    int getQuantityOfProduct(Long storeId, Long sizeId, Long colorId);
}
