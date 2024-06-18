package com.reidshop.Model.Response;

import com.reidshop.Model.Entity.Color;
import com.reidshop.Model.Entity.Size;
import lombok.Data;

import java.util.List;

@Data
public class StockProductResponse {
    String name;
    List<Size> sizes;
}
