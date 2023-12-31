package com.reidshop.Controller.Vendor;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.*;
import com.reidshop.Reponsitory.*;
import com.reidshop.security.JwtService;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/vendor/listStock")
public class InventoryController {

    @Autowired
    InventoryRepository inventoryRepository;
    @Autowired
    JwtService jwtService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    StoreRepository storeRepository;
    @Autowired
    ProductOutOfStockRepository outOfStockRepository;
    @Autowired
    AccountDetailRepository accountDetailRepository;

    @GetMapping("")
    String index(ModelMap modelMap, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);

        Store store = storeRepository.searchAllByAccountId(account.getId());
        AccountDetail accountDetail = accountDetailRepository.findAccountDetailByAccountId(account.getId());
        modelMap.addAttribute("accountDetail", accountDetail);
        //Store ID
        Long storeID = store.getId();


        List<Inventory> inventoryList = inventoryRepository.findAllInventoryByStoreID(storeID);
        List<ProductOutOfStock> outOfStocks = outOfStockRepository.findAllByStoreId(storeID);

        modelMap.addAttribute("inventoryList",inventoryList);
        modelMap.addAttribute("outOfStocks",outOfStocks);

        return "vendor/inventory";
    }
}
