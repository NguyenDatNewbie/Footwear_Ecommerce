package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.AccountDetail;
import com.reidshop.Reponsitory.AccountDetailRepository;
import com.reidshop.Reponsitory.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;
import java.util.Optional;

@Controller
@RequestMapping("/admin/account")
public class ManagerAccountController {
    @Autowired
    AccountRepository accountRepository;

    @Autowired
    AccountDetailRepository accountDetailRepository;
    Locale locale = new Locale("vi","VN");
    @RequestMapping("")
    public String listAccount(ModelMap modelMap){

        modelMap.addAttribute("accountRepository", accountRepository);
        modelMap.addAttribute("accountDetailRepository", accountDetailRepository);
        return "admin/account";
    }
    @GetMapping("{accountId}")
    public ModelAndView detail(ModelMap model, @PathVariable("accountId") Long accountId){
        Optional<AccountDetail> opt = accountDetailRepository.findByAccountId(accountId);
        if(opt.isPresent()){
            AccountDetail accountDetail = opt.get();
            model.addAttribute("accountDetail", accountDetail);
            System.out.println(accountDetail);
            return new ModelAndView("admin/accountDetail", model);
        }
        return new ModelAndView("redirect:/admin/account", model);
    }
}
