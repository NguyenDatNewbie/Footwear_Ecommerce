package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.AccountDetail;
import com.reidshop.Model.Entity.OrderItem;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Reponsitory.AccountDetailRepository;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.OrderItemRepository;
import com.reidshop.Reponsitory.OrdersRepository;
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
@RequestMapping("/admin/account")
public class ManagerAccountController {
    @Autowired
    AccountRepository accountRepository;

    @Autowired
    AccountDetailRepository accountDetailRepository;
    @Autowired
    OrdersRepository ordersRepository;
    @Autowired
    OrderItemRepository orderItemRepository;
    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String listAccount(ModelMap modelMap){
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("accountRepository", accountRepository);
        modelMap.addAttribute("accountDetailRepository", accountDetailRepository);
        return "admin/account";
    }
    @GetMapping("{accountId}")
    public ModelAndView detail(ModelMap model, @PathVariable("accountId") Long accountId){
        Optional<AccountDetail> opt = accountDetailRepository.findByAccountId(accountId);
        Optional<Account> optAccount = accountRepository.findById(accountId);
        List<Orders> ordersByAcc = ordersRepository.findAllOrderByAccountId(accountId);

        if(opt.isPresent()){
            AccountDetail accountDetail = opt.get();
            Account account = optAccount.get();
            model.addAttribute("accountDetail", accountDetail);
            model.addAttribute("account", account);
            model.addAttribute("ordersByAcc", ordersByAcc);
            model.addAttribute("formatVND",formatVND);
            return new ModelAndView("admin/accountDetail", model);
        }
        return new ModelAndView("redirect:/admin/account", model);
    }

    @GetMapping("{accountId}/{ordered}")
    public ModelAndView orderDetail(ModelMap model, @PathVariable("accountId") Long accountId, @PathVariable("ordered") Long orderedID){
        Optional<AccountDetail> opt = accountDetailRepository.findByAccountId(accountId);
        Optional<Account> optAccount = accountRepository.findById(accountId);
        Optional<Orders> optOrder = ordersRepository.findById(orderedID);
        List<OrderItem> items = orderItemRepository.findAllItemByOrderId(orderedID);

        if(opt.isPresent()){
            AccountDetail accountDetail = opt.get();
            Account account = optAccount.get();
            Orders order = optOrder.get();
            model.addAttribute("accountDetail", accountDetail);
            model.addAttribute("account", account);
            model.addAttribute("order", order);
            model.addAttribute("formatVND",formatVND);
            model.addAttribute("orderItem",items);
            return new ModelAndView("admin/orderDetail", model);
        }
        return new ModelAndView("redirect:/admin/account", model);
    }
}
