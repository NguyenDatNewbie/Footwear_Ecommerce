package com.reidshop.Model.Request;

import com.reidshop.Model.Entity.Size;
import com.reidshop.Model.Entity.Supplier;
import lombok.Data;

@Data
public class StockRequest {
    Size size;
    int quantity;
    double price;
    Supplier supplier;
}
