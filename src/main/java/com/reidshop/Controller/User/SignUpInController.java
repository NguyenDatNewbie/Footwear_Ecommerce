package com.reidshop.Controller.User;

import com.reidshop.Entity.Account;
import com.reidshop.Entity.AccountDetail;
import com.reidshop.Model.AccountDetailDto;
import com.reidshop.Model.AccountDto;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Service.IAccountSevice;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
//import com.reidshop.Config.WebSecurityConfig;


@Controller
@RequestMapping("/sign-in-up")
public class SignUpInController {
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    IAccountSevice accountSevice;
    @RequestMapping("")
    String index()
    {
        return "user/login";
    }
    @PostMapping("/save")
    String registration(@Valid @ModelAttribute("account") AccountDto account,
                        @Valid @ModelAttribute("accountDetail") AccountDetailDto accountDetail,
                        BindingResult result, ModelMap modelMap){
        if(result.hasErrors())
        {
            return "user/login";
        }
//        Account exist = accountRepository.findByEmail(account.getEmail());
//        if(exist!=null)
//        {
//            result.rejectValue("email", null, "Email đã tồn tại");
//        }
//        if(result.hasErrors()){
//            modelMap.addAttribute("account",account);
//            modelMap.addAttribute("accountDetail",accountDetail);
//            return "user/login";
//        }
//        accountSevice.save(account,accountDetail,(byte) 1);
        return "redirect:/index";
    }

}
