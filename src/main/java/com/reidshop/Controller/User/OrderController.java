package com.reidshop.Controller.User;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order")
public class OrderController {
    @RequestMapping("")
    String index(){
        return "user/cart";
    }
}
