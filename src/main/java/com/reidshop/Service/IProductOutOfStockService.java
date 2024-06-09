package com.reidshop.Service;

import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.ProductOutOfStock;
import com.reidshop.Model.Request.CartRequest;

import java.util.List;

public interface IProductOutOfStockService {
    double save(List<CartRequest> cartRequests, Long storeId, int type, Orders orders);
    boolean checkOrder(Long orderId);

    List<ProductOutOfStock> listProductBySize(Long storeId);
}
