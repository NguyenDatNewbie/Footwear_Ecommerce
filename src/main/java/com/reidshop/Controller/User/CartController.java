package com.reidshop.Controller.User;

import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Model.Request.StoreRequest;
import com.reidshop.Model.Response.StoreValidResponse;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Reponsitory.StoreRepository;
import com.reidshop.Service.ICartService;
import com.reidshop.Service.IStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.text.DecimalFormat;
import java.text.NumberFormat;
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
    Locale locale = new Locale("vi","VN");

    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    @GetMapping("")
    String index(ModelMap modelMap){
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
    @PostMapping(value = "/getStore",consumes = MediaType.ALL_VALUE)
    @ResponseBody
    List<StoreValidResponse> getStore (@RequestBody StoreRequest storeRequest){
        List<StoreValidResponse> stores =  storeService.findAllStoreIsStock(storeRequest.getCarts(),storeRequest.getCity(),storeRequest.getDistrict());
        return stores;
    }
}
