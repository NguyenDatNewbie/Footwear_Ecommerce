package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Reponsitory.*;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.IProductOutOfStockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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
    @Autowired
    ColorRepository colorRepository;
    @Override
    public double save(List<CartRequest> cartRequests, Long storeId, int stocking, Orders orders) {
        double totalPrice = 0;
        for (CartRequest cart : cartRequests) {
            Product product = productRepository.findById(cart.getId()).orElse(null);
            double price = product.getPrice()*(1-product.getPromotion()/100.0);
            totalPrice += price*cart.getQuantity();
            List<Inventory> inventories = inventoryRepository.findByStore(cart.getId(), cart.getSize(), cart.getQuantity(), storeId, cart.getColor());

            if (stocking == 0 && inventories.size()==0) {
                ProductOutOfStock productOutOfStock = new ProductOutOfStock();
                productOutOfStock.setOrders(orders);
                productOutOfStock.setSize(sizeRepository.findAllByProductIdAndSize(cart.getId(),cart.getSize()));
                productOutOfStock.setQuantity(cart.getQuantity());
                productOutOfStock.setPrice(price);
                productOutOfStock.setColor(colorRepository.findById(cart.getColor()).orElse(null));
                productOutOfStockRepository.save(productOutOfStock);
            }
            else
                orderItemService.save(inventories.get(0),cart.getQuantity(),price,orders);
        }
        return totalPrice;
    }

    @Override
    public boolean checkOrder(Long orderId) {
        List<ProductOutOfStock> listItem = productOutOfStockRepository.findByOrderId(orderId);
        if (listItem.isEmpty())
            return true;
        return false;
    }

    @Override
    public List<ProductOutOfStock> listProductBySize(Long storeId) {
        List<Object[]> result = productOutOfStockRepository.listProductImport(storeId);
        List<ProductOutOfStock> products = new ArrayList<>();

        Long id = 1L;
        for (Object[] item : result){
            Long productId = id;
            Long size_id = (Long) item[0];
            Long color_id = (Long) item[1];
            Long  quantity = (Long) item[2];

            Size size = sizeRepository.findById(size_id).orElse(null);
            Color color = colorRepository.findById(color_id).orElse(null);
            Orders orders = new Orders();
            orders.setId((Long) item[3]);
            ProductOutOfStock product = new ProductOutOfStock();
            product.setId(productId);
            product.setSize(size);
            product.setColor(color);
            product.setPrice(0.0);
            product.setQuantity(quantity.intValue());
            product.setOrders(orders);
            products.add(product);
            id++;
        }
        return products;
    }
}
