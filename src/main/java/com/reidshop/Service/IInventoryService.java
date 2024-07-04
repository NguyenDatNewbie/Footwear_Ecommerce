package com.reidshop.Service;

public interface IInventoryService {
    int getQuantityOfProduct(Long storeId, Long sizeId, Long colorId);
}
