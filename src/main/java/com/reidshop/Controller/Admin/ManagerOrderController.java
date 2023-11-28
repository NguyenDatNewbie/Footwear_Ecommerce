package com.reidshop.Controller.Admin;

import com.reidshop.Reponsitory.OrdersRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/order")
public class ManagerOrderController {
    @Autowired
    OrdersRepository ordersRepository;
    @RequestMapping("")
    public String index(ModelMap modelMap){
        modelMap.addAttribute("ordersRepository", ordersRepository);

        return "admin/order";
    }
}
