package com.reidshop.Model.Response;

import com.reidshop.Model.Entity.Color;
import com.reidshop.Model.Entity.Size;
import lombok.Data;

@Data
public class ExcelReStockResponse {
    Long productId;
    String productName;
    Long orderId;
    Long colorId;
    String colorName;
    Long sizeId;
    String size;
    int quantity;
    int inventory;
    int restock;
}
