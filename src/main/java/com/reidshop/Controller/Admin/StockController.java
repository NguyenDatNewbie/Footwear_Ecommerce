package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.Product;
import com.reidshop.Reponsitory.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/vendor/stock")
public class StockController {
    @Autowired
    ProductRepository productRepository;
    @GetMapping("")
    String index(){
        return ("admin/stock");
    }

    @GetMapping("/getProduct")
    @ResponseBody
    List<String> getProductByQuery(@RequestParam String query){
        List<String> name = new ArrayList<>();
        List<Product> products = productRepository.findByNameOrId(query);
        for (Product product: products) {
            name.add(product.getNameAndId());
        }
        return name;
    }
}
