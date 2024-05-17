package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Mapper.CartRequestMapper;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Model.Request.EvaluateRequest;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.EvaluateRepository;
import com.reidshop.Reponsitory.ImageRepository;
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
import java.util.ArrayList;
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
    ImageRepository imageRepository;
    @Autowired
    JwtService jwtService;
    @Autowired
    CartRequestMapper cartRequestMapper;
    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @GetMapping("")
    String index(HttpServletRequest request, ModelMap modelMap){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        List<Orders> ordersTabPrepare = ordersRepository.findOrdersByAccountAndStatus(account.getId(),OrderStatus.WAIT);
        ordersTabPrepare.addAll(ordersRepository.findOrdersByAccountAndStatus(account.getId(),OrderStatus.PREPARE));
        modelMap.addAttribute("ordersTabPrepare",ordersTabPrepare);
        modelMap.addAttribute("account",account);
        modelMap.addAttribute("orders",ordersRepository.findOrdersByAccount(account.getId()));
        modelMap.addAttribute("ordersRepository",ordersService);
        modelMap.addAttribute("ordersService",ordersRepository);
        modelMap.addAttribute("evaluateRepository",evaluateRepository);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("imageRepository",imageRepository);
        return "user/order";
    }

    @GetMapping("/search")
    String search(HttpServletRequest request, ModelMap modelMap,
                  @RequestParam("keyword") String keyword){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        List<Orders> ordersTabPrepare = ordersRepository.findOrdersByAccountAndStatus(account.getId(),OrderStatus.WAIT);
        ordersTabPrepare.addAll(ordersRepository.findOrdersByAccountAndStatus(account.getId(),OrderStatus.PREPARE));
        modelMap.addAttribute("ordersTabPrepare",ordersTabPrepare);
        modelMap.addAttribute("orders",ordersService.findOrderByAccountQuery(account.getId(), keyword));
        modelMap.addAttribute("keyword",keyword);
        modelMap.addAttribute("account",account);
        modelMap.addAttribute("ordersRepository",ordersService);
        modelMap.addAttribute("ordersService",ordersRepository);
        modelMap.addAttribute("evaluateRepository",evaluateRepository);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("imageRepository",imageRepository);
        return "user/order";
    }

    @PostMapping("/update/{id}")
    @ResponseBody
    String cancel(@PathVariable long id){
        Orders orders = ordersRepository.findById(id).orElse(null);
        if(orders.getStatus()== OrderStatus.PREPARE || orders.getStatus() ==OrderStatus.WAIT
                || orders.getStatus() == OrderStatus.ALREADY){
            orders.setStatus(OrderStatus.CANCEL);
            ordersRepository.save(orders);
            orderItemService.reInventory(orders.getId());
        }
        return "success";
    }
    @GetMapping("/repurchase/{id}")
    @ResponseBody
    List<CartRequest> repurchase(@PathVariable Long id){
        Orders orders = ordersRepository.findById(id).orElse(null);
        List<CartRequest> cartRequestList = new ArrayList<>();
        if(orders!=null){
            List<OrderItem> orderItems = orders.getOrderItems();
            cartRequestList = cartRequestMapper.toListCartRequest(orderItems);
            cartRequestList.addAll(cartRequestMapper.toListCartRequestOutStock(orders.getProductOutOfStocks()));
        }
        return cartRequestList;
    }
    @PostMapping(value = "/evaluate/{id}",consumes = {"application/x-www-form-urlencoded"})
    ModelAndView evaluate(@ModelAttribute Evaluate evaluate, @PathVariable long id, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        evaluate.setOrders(ordersRepository.findById(id).orElse(null));
        evaluate.setAccount(account);
        evaluate.setCreatedAt(Date.valueOf(LocalDate.now()));
        ordersService.rateSave(evaluate, id);
        return new ModelAndView("redirect:/orders");
    }

    @GetMapping("/{id}")
    String detail(@PathVariable Long id,ModelMap modelMap,HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        modelMap.addAttribute("account",account);
        modelMap.addAttribute("ordersRepository",ordersService);
        modelMap.addAttribute("ordersService",ordersRepository);
        modelMap.addAttribute("evaluateRepository",evaluateRepository);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("imageRepository",imageRepository);
        modelMap.addAttribute("order",ordersRepository.findById(id).orElse(null));
        return "user/order-detail";
    }


}
