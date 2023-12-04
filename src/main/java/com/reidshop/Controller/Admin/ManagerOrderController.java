package com.reidshop.Controller.Admin;

import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Reponsitory.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

@Controller
@RequestMapping("/admin/order")
public class ManagerOrderController {
    @Autowired
    OrdersRepository ordersRepository;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String index(ModelMap modelMap){
        modelMap.addAttribute("ordersRepository", ordersRepository);

        return "admin/order";
    }
}
