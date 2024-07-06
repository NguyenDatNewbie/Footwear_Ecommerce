package com.reidshop.Model.Response;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Entity.Supplier;
import lombok.Data;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Data
public class StockResponse {
    private Long id;
    private String createdAt;
    private Store store;
    private Supplier supplier;
    private List<Inventory> inventories = new ArrayList<>();
    private int totalQuantity;
    private double totalPrice;

}
