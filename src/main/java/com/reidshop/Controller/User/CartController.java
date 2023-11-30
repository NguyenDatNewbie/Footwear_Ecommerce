package com.reidshop.Controller.User;

import com.mservice.allinone.processor.allinone.CaptureMoMo;
import com.mservice.shared.sharedmodels.Environment;
import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.TypeReceive;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Model.Request.OrderCombineRequest;
import com.reidshop.Model.Request.RegisterRequest;
import com.reidshop.Model.Request.StoreRequest;
import com.reidshop.Model.Response.StoreValidResponse;
import com.reidshop.Reponsitory.*;
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

import java.sql.Date;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.util.List;
import java.util.Locale;

import static com.mservice.shared.sharedmodels.Environment.ProcessType.PAY_GATE;

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


    Locale locale = new Locale("vi","VN");

    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    @GetMapping("")
    String index(ModelMap modelMap) throws Exception {
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("imageRepository",imageRepository);
        modelMap.addAttribute("store",storeRepository.findAll());
//        String orderInfo = "Pay With MoMo";
//        String returnURL = "https://google.com.vn";
//        String notifyURL = "https://google.com.vn";
//        String requestId = String.valueOf(System.currentTimeMillis());
//        String orderId = String.valueOf(System.currentTimeMillis());
//        long amount = 50000;
//        Environment environment = Environment.selectEnv("dev", Environment.ProcessType.APP_IN_APP);
//        System.out.println(CaptureMoMo.process(environment,orderId,requestId,Long.toString(amount),orderInfo,returnURL,notifyURL,""));
        return "user/cart";
    }

    @PostMapping(value = "/getItem",consumes = MediaType.ALL_VALUE)
    @ResponseBody
    String getItem (@RequestBody List<CartRequest> data){
        return cartService.getItemCart(data);
    }
    @PostMapping(value = "/getStore",consumes = MediaType.ALL_VALUE)
    @ResponseBody
    List<StoreValidResponse> getStore (@RequestBody StoreRequest storeRequest){
        List<StoreValidResponse> stores =  storeService.findAllStoreIsStock(storeRequest.getCarts(),storeRequest.getCity(),storeRequest.getDistrict());
        return stores;
    }

    @PostMapping("/payment/receive/{storeId}/{type}")
    @ResponseBody
    ResponseEntity<?> payment(@RequestBody OrderCombineRequest orderCombineRequest, @PathVariable Long storeId, @PathVariable int type,
                                HttpServletRequest request){
        ordersService.savePaymentReceive(orderCombineRequest,storeId,type,request);

        return ResponseEntity.status(HttpStatus.OK).body("success");
    }

}
