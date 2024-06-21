package com.reidshop.Model.Request;

import com.reidshop.Model.Entity.Color;
import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Size;
import com.reidshop.Model.Entity.Supplier;
import lombok.Data;

@Data
public class StockRequest {
    Size size;
    Color color;
    int quantity;
    double price;
    Supplier supplier;
    PriorityOrder priorityOrder;

    @Data
    public static class PriorityOrder {
        private Long id;
        private Inventory inventory;
    }
}
