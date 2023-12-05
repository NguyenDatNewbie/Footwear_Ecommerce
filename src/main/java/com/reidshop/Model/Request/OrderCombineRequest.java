package com.reidshop.Model.Request;

import com.reidshop.Model.Entity.Orders;
import lombok.Data;

import java.util.List;

@Data
public class OrderCombineRequest {
    Orders orders;
    List<CartRequest> carts;
    List<StoreValidRequest>  storeValid;
    String city;
    String district;
    String ward;
}
