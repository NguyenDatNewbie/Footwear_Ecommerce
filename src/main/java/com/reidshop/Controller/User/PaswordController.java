package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Request.RegisterRequest;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Service.IAccountService;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/password")
public class PaswordController {
    @Autowired
    IAccountService accountService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    JwtService jwtService;
    @Autowired
    PasswordEncoder passwordEncoder;
    @GetMapping("/forgot")
    public String forgotPassword(){
        return "user/confirm-email";
    }

    @PostMapping("/forgot")
    public ModelAndView toOtp(@ModelAttribute("request") RegisterRequest request , HttpSession session){
        session.setAttribute("register",request);
        return new ModelAndView("redirect:/otp/resetPassword");
    }

    @GetMapping("/resetPassword")
    public String resetPass(){
        return "user/resetPassword";
    }
    @PostMapping("/resetPassword")
    public ModelAndView resetPassword(@ModelAttribute("request") RegisterRequest request , HttpSession session, HttpServletResponse response){
        RegisterRequest sessionAttribute = (RegisterRequest) session.getAttribute("register");
        if(sessionAttribute!=null) {
            Account account = accountRepository.findByEmail(sessionAttribute.getEmail()).orElse(null);
            if (account != null) {
                account.setPassword(passwordEncoder.encode((request.getPassword())));
                accountRepository.save(account);
                response.addCookie(CookieHandle.createCookie("token", jwtService.generateToken(request.getEmail())));
                session.removeAttribute("register");
                return new ModelAndView("user/login");
            }
        }
        return new ModelAndView("redirect:/password/forgot");
    }
}
