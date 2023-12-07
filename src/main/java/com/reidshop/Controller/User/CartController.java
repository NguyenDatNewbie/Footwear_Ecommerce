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
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

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

    Locale locale = new Locale("vi","VN");

    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    @GetMapping("")
    String index(ModelMap modelMap) throws Exception {
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("imageRepository",imageRepository);
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
        return stores;
    }

    @PostMapping("/payment/{receiveType}/{payment}")
    @ResponseBody
    ResponseEntity<?> payment(@RequestBody OrderCombineRequest orderCombineRequest, HttpServletRequest request,@PathVariable ReceiveType receiveType,@PathVariable PaymentType payment){

        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        if(account==null)
            return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body("failed");

        if(receiveType==ReceiveType.DELIVERY) {
            List<StoreValidRequest> storeValidRequests = orderCombineRequest.getStoreValid();
            if(storeValidRequests.size()>0)
                storeValidRequests.add(distanceService.getStoreDistanceMin(storeValidRequests,orderCombineRequest.getOrders().getAddress(),1));
            else
                storeValidRequests.add(distanceService.getStoreDistanceMin(storeService.findAll(),orderCombineRequest.getOrders().getAddress(),1));

            orderCombineRequest.setStoreValid(storeValidRequests);
        }
        ordersService.savePaymentReceive(orderCombineRequest, receiveType,payment,request);
        return ResponseEntity.status(HttpStatus.OK).body("success");
    }
}
