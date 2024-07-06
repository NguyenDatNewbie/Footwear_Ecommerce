package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.InventoryRepository;
import com.reidshop.Reponsitory.StockRepository;
import com.reidshop.Reponsitory.StoreRepository;
import com.reidshop.Service.IOrdersService;
import com.reidshop.Service.IStoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
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

    @Autowired
    IStoreService storeService;
    @Autowired
    IOrdersService ordersService;
    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    @RequestMapping("")
    public String index(ModelMap modelMap){
        modelMap.addAttribute("storeRepository", storeRepository);
        modelMap.addAttribute("storeService", storeService);
        return "admin/store";
    }

    @RequestMapping("inventory/{accountId}")
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

    @RequestMapping("orders/{accountId}")
    public ModelAndView showOrderOfStore(ModelMap modelMap,
                                         @PathVariable("accountId") Long accountID){
        Optional<Account> optAccount = accountRepository.findById(accountID);

        if (optAccount.isPresent()){
            Account account = optAccount.get();
            List<Orders> orders = ordersService.findAllOrderByStore(accountID);
            modelMap.addAttribute("account", account);
            modelMap.addAttribute("orders", orders);
            modelMap.addAttribute("orderWAIT", ordersService.findAllOrderOfStoreByStatus(accountID, OrderStatus.WAIT));
            modelMap.addAttribute("orderPREPARE", ordersService.findAllOrderOfStoreByStatus(accountID, OrderStatus.PREPARE));
            modelMap.addAttribute("orderALREADY", ordersService.findAllOrderOfStoreByStatus(accountID, OrderStatus.ALREADY));
            modelMap.addAttribute("orderDELIVERY", ordersService.findAllOrderOfStoreByStatus(accountID, OrderStatus.DELIVERY));
            modelMap.addAttribute("orderCOMPLETE", ordersService.findAllOrderOfStoreByStatus(accountID, OrderStatus.COMPLETE));
            modelMap.addAttribute("orderCANCEL", ordersService.findAllOrderOfStoreByStatus(accountID, OrderStatus.CANCEL));
            modelMap.addAttribute("formatVND",formatVND);
            return new ModelAndView("admin/orderOfStore", modelMap);
        }

        return new ModelAndView("redirect:admin/orderOfStore");
    }
}
