package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.AccountDetail;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.Impl.OrdersServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

@Controller
@RequestMapping("/admin/order")
public class ManagerOrderController {
    @Autowired
    OrdersRepository ordersRepository;

    @Autowired
    OrdersServiceImpl ordersService;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String index(ModelMap modelMap){
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("ordersRepository", ordersRepository);
        List<Orders> orders = ordersRepository.findAll();
        modelMap.addAttribute("orders", orders);

        return "admin/order";
    }

    @GetMapping("{orderId}")
    public ModelAndView detail(ModelMap model, @PathVariable("orderId") Long orderId){
        Optional<Orders> opt = ordersRepository.findById(orderId);

        if(opt.isPresent()){
            Orders order = opt.get();
            model.addAttribute("order", order);
            model.addAttribute("formatVND",formatVND);
            return new ModelAndView("admin/orderDetail", model);
        }
        return new ModelAndView("redirect:/admin/order", model);
    }

    @GetMapping("cancelOrder/{orderId}")
    public ModelAndView cancelOrder(ModelMap model, @PathVariable("orderId") Long orderId) {
        ordersService.UpdateOrderStatus(orderId, OrderStatus.CANCEL);
        return new ModelAndView("forward:/admin/order", model);
    }

    @GetMapping("updateStatus/{orderId}")
    public ModelAndView updateOrderStatus(ModelMap model, @PathVariable("orderId") Long orderId) {
        Optional<Orders> opt = ordersRepository.findById(orderId);

        if (opt.isPresent()){
            Orders order = opt.get();
            OrderStatus status = order.getStatus();
            switch (status) {
                case WAIT -> ordersService.UpdateOrderStatus(orderId, OrderStatus.PREPARE);
                case PREPARE -> ordersService.UpdateOrderStatus(orderId, OrderStatus.ALREADY);
                case ALREADY -> ordersService.UpdateOrderStatus(orderId, OrderStatus.DELIVERY);
                case DELIVERY -> ordersService.UpdateOrderStatus(orderId, OrderStatus.COMPLETE);
            }
            return new ModelAndView("forward:/admin/order", model);
        }
        return new ModelAndView("redirect:/admin/order", model);
    }
}
