package com.reidshop.Controller.Admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/vendor/stock")
public class StockController {
    @GetMapping("")
    String index(){
        return ("admin/stock");
    }
}
