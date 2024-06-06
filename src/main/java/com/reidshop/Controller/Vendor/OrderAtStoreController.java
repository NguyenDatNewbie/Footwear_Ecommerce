package com.reidshop.Controller.Vendor;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Reponsitory.*;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.Impl.OrdersServiceImpl;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

@Controller
@RequestMapping("/vendor/orderRcvStore")
public class OrderAtStoreController {
    @Autowired
    OrdersRepository ordersRepository;
    @Autowired
    OrdersServiceImpl ordersService;
    @Autowired
    OrderItemRepository orderItemRepository;
    @Autowired
    IOrderItemService orderItemService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    AccountDetailRepository accountDetailRepository;
    @Autowired
    JwtService jwtService;
    @Autowired
    StoreRepository storeRepository;
    @Autowired
    InventoryRepository inventoryRepository;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    @RequestMapping("")
    public String index(ModelMap modelMap, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);

        Store store = storeRepository.searchAllByAccountId(account.getId());
        //Store ID
        Long storeID = store.getId();

        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("ordersRepository", ordersRepository);

        AccountDetail accountDetail = accountDetailRepository.findAccountDetailByAccountId(account.getId());
        modelMap.addAttribute("accountDetail", accountDetail);

        //List Orders of Store and have Receive Type at Store
        List<Orders> ordersRecvAtStore = ordersRepository.findAllOrdersByRecvAndStoreId(OrderStatus.WAIT, ReceiveType.STORE, storeID);

        modelMap.addAttribute("ordersRecvAtStore", ordersRecvAtStore);

        return "vendor/orderStore";
    }
}