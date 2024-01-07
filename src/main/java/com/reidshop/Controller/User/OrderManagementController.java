package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.Evaluate;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Request.EvaluateRequest;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.EvaluateRepository;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Service.IEvaluateServiceImpl;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.IOrdersService;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.sql.Date;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.util.List;
import java.util.Locale;

@RequestMapping("/orders")
@Controller
public class OrderManagementController {
    @Autowired
    IOrdersService ordersService;
    @Autowired
    OrdersRepository ordersRepository;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    IOrderItemService orderItemService;
    @Autowired
    EvaluateRepository evaluateRepository;
    @Autowired
    JwtService jwtService;
    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @GetMapping("")
    String index(HttpServletRequest request, ModelMap modelMap){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        modelMap.addAttribute("account",account);
        modelMap.addAttribute("orders",ordersRepository.findOrdersByAccount(account.getId()));
        modelMap.addAttribute("ordersRepository",ordersService);
        modelMap.addAttribute("ordersService",ordersRepository);
        modelMap.addAttribute("evaluateRepository",evaluateRepository);
        modelMap.addAttribute("formatVND",formatVND);
        return "user/order";
    }

    @GetMapping("/search")
    String search(HttpServletRequest request, ModelMap modelMap,
                  @RequestParam("keyword") String keyword){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        modelMap.addAttribute("orders",ordersService.findOrderByAccountQuery(account.getId(), keyword));
        modelMap.addAttribute("keyword",keyword);
        modelMap.addAttribute("account",account);
        modelMap.addAttribute("ordersRepository",ordersService);
        modelMap.addAttribute("ordersService",ordersRepository);
        modelMap.addAttribute("evaluateRepository",evaluateRepository);
        modelMap.addAttribute("formatVND",formatVND);
        return "user/order";
    }

    @PostMapping("/update/{id}")
    void cancel(@PathVariable long id){
        Orders orders = ordersRepository.findById(id).orElse(null);
        if(orders.getStatus()== OrderStatus.PREPARE || orders.getStatus() ==OrderStatus.WAIT
                || orders.getStatus() == OrderStatus.ALREADY){
            orders.setStatus(OrderStatus.CANCEL);
            ordersRepository.save(orders);
            orderItemService.reInventory(orders.getId());
        }
    }

    @PostMapping(value = "/evaluate/{id}",consumes = {"application/x-www-form-urlencoded"})
    ModelAndView evaluate(@ModelAttribute Evaluate evaluate, @PathVariable long id, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        evaluate.setAccount(account);
        evaluate.setCreatedAt(Date.valueOf(LocalDate.now()));
        ordersService.rateSave(evaluate, id);
        return new ModelAndView("redirect:/orders");
    }
}
