package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Enum.PaymentType;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Model.Request.OrderCombineRequest;
import com.reidshop.Model.Request.StoreValidRequest;
import com.reidshop.Model.Response.StoreValidResponse;
import com.reidshop.Reponsitory.*;
import com.reidshop.Service.Handle.DistanceService;
import com.reidshop.Service.ICartService;
import com.reidshop.Service.IOrdersService;
import com.reidshop.Service.IStoreService;
import com.reidshop.Service.IVoucherService;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/cart")
public class CartController {
    @Autowired
    ProductRepository productRepository;
    @Autowired
    ImageRepository imageRepository;
    @Autowired
    ICartService cartService;
    @Autowired
    StoreRepository storeRepository;
    @Autowired
    IStoreService storeService;
    @Autowired
    IOrdersService ordersService;
    @Autowired
    DistanceService distanceService;
    @Autowired
    JwtService jwtService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    IVoucherService voucherService;

    Locale locale = new Locale("vi","VN");

    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy", locale);

    NumberFormat formatterDecimal = new DecimalFormat("#0");

    @GetMapping("")
    String index(ModelMap modelMap) throws Exception {
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("formatterDecimal",formatterDecimal);
        modelMap.addAttribute("dateFormat",dateFormat);
        modelMap.addAttribute("imageRepository",imageRepository);
        modelMap.addAttribute("vourcher_sv", voucherService);
        modelMap.addAttribute("store",storeRepository.findAll());
        return "user/cart";
    }

    @PostMapping(value = "/getItem",consumes = MediaType.ALL_VALUE)
    @ResponseBody
    String getItem (@RequestBody List<CartRequest> data){
        return cartService.getItemCart(data);
    }
    @PostMapping(value = "/getStore/{receiveType}",consumes = MediaType.ALL_VALUE)
    @ResponseBody
    List<StoreValidResponse> getStore (@RequestBody OrderCombineRequest orderCombineRequest,@PathVariable ReceiveType receiveType){
        List<StoreValidResponse> stores =  storeService.findAllStoreIsStock(orderCombineRequest.getCarts(),orderCombineRequest.getCity(),orderCombineRequest.getDistrict(),orderCombineRequest.getWard(), receiveType);
        System.out.println(stores.size());
        return stores;
    }

    @PostMapping("/payment/{receiveType}/{payment}")
    @ResponseBody
    ResponseEntity<?> payment(@RequestBody OrderCombineRequest orderCombineRequest, HttpServletRequest request, @PathVariable ReceiveType receiveType, @PathVariable PaymentType payment, HttpSession session){
        Map<String, String> responseData = new HashMap<>();
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        if (receiveType == ReceiveType.DELIVERY) {
            List<StoreValidRequest> storeValidRequests = orderCombineRequest.getStoreValid();
            if (storeValidRequests.size() > 0)
                storeValidRequests.add(distanceService.getStoreDistanceMin(storeValidRequests, orderCombineRequest.getOrders().getAddress(), 1));
            else
                storeValidRequests.add(distanceService.getStoreDistanceMin(storeService.findAll(), orderCombineRequest.getOrders().getAddress(), 1));

            orderCombineRequest.setStoreValid(storeValidRequests);
        }

        if(payment==PaymentType.RECEIVE) {
            if (account == null)
                return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body("failed");
            ordersService.savePayment(orderCombineRequest, receiveType, payment, request);
            responseData.put("url", "/cart?message=success");
            responseData.put("status", "success");
        }
        else if(payment==PaymentType.VNPAY){
            // Luu do thong tin order vao session
            session.setAttribute("orderCombine",orderCombineRequest);
//            session.setMaxInactiveInterval(20); // 20 phut
            OrderCombineRequest orderCombineRequest1 = (OrderCombineRequest) session.getAttribute("orderCombine");
            responseData.put("url", "/payment/vnpay?receive="+receiveType+"&price=1200000");
            responseData.put("status", "wait");
        }
        return ResponseEntity.status(HttpStatus.OK).body(responseData);
    }
}
