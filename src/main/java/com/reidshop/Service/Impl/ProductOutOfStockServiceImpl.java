package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Entity.ProductOutOfStock;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Reponsitory.InventoryRepository;
import com.reidshop.Reponsitory.ProductOutOfStockRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Reponsitory.SizeRepository;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.IProductOutOfStockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductOutOfStockServiceImpl implements IProductOutOfStockService {
    @Autowired
    ProductOutOfStockRepository productOutOfStockRepository;
    @Autowired
    InventoryRepository inventoryRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    IOrderItemService orderItemService;
    @Autowired
    SizeRepository sizeRepository;
    @Override
    public double save(List<CartRequest> cartRequests, Long storeId, int stocking, Orders orders) {
        double totalPrice = 0;
        for (CartRequest cart : cartRequests) {
            Product product = productRepository.findById(cart.getId()).orElse(null);
            double price = product.getPrice()*(1-product.getPromotion()/100.0);
            totalPrice +=price+ cart.getQuantity();
            Inventory inventory = inventoryRepository.findByStore(cart.getId(), cart.getSize(), cart.getQuantity(), storeId);
            if (stocking == 0 && inventory == null) {
                ProductOutOfStock productOutOfStock = new ProductOutOfStock();
                productOutOfStock.setOrders(orders);
                productOutOfStock.setSize(sizeRepository.findAllByProductIdAndSize(cart.getId(),cart.getSize()));
                productOutOfStock.setQuantity(cart.getQuantity());
                productOutOfStock.setPrice(price);
                productOutOfStockRepository.save(productOutOfStock);
            }
            else
                orderItemService.save(inventory,cart.getQuantity(),price,orders);
        }
        return totalPrice;
    }
}
