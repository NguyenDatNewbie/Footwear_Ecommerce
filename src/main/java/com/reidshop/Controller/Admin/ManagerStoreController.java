package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.InventoryRepository;
import com.reidshop.Reponsitory.StockRepository;
import com.reidshop.Reponsitory.StoreRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/stores")
public class ManagerStoreController {
    @Autowired
    InventoryRepository inventoryRepository;

    @Autowired
    AccountRepository accountRepository;

    @Autowired
    StoreRepository storeRepository;

    @RequestMapping("")
    public String index(ModelMap modelMap){
        modelMap.addAttribute("accountRepository", accountRepository);
        modelMap.addAttribute("storeRepository", storeRepository);
        System.out.println(storeRepository.count());
        return "admin/store";
    }

    @RequestMapping("{accountId}")
    public ModelAndView showInventory(ModelMap modelMap,
                                      @PathVariable("accountId") Long accountID){
        Optional<Account> optAccount = accountRepository.findById(accountID);

        if (optAccount.isPresent()){
            Account account = optAccount.get();
            List<Inventory> inventoryList = inventoryRepository.findAllInventoryByStore(accountID);
            modelMap.addAttribute("account", account);
            modelMap.addAttribute("inventoryList", inventoryList);
            return new ModelAndView("admin/inventory", modelMap);
        }

        return new ModelAndView("redirect:/admin/stores");
    }
}
