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

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
@RequestMapping("/password")
public class PasswordController {
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
        if(accountRepository.findByEmail(request.getEmail()).orElse(null)==null)
            return new ModelAndView("redirect:/password/forgot?message=failed");
        session.setAttribute("register",request);
        return new ModelAndView("redirect:/otp/resetPassword");
    }

    @GetMapping("/resetPassword")
    public String resetPass(){
        return "user/resetPassword";
    }
    @PostMapping("/resetPassword")
    public ModelAndView resetPassword(@ModelAttribute("request") RegisterRequest request , HttpSession session, HttpServletResponse response) throws UnsupportedEncodingException {
        RegisterRequest sessionAttribute = (RegisterRequest) session.getAttribute("register");
        if(sessionAttribute!=null) {
            Account account = accountRepository.findByEmail(sessionAttribute.getEmail()).orElse(null);
            if (account != null) {
                account.setPassword(passwordEncoder.encode((request.getPassword())));
                System.out.println(account.getPassword());
                accountRepository.save(account);
                response.addCookie(CookieHandle.createCookie("token", jwtService.generateToken(request.getEmail())));
                session.removeAttribute("register");
                String message = URLEncoder.encode("Thay đổi mật khẩu thành công", "UTF-8");;
                return new ModelAndView("redirect:/sign-in-up?message="+ message);
            }
        }
        return new ModelAndView("redirect:/password/forgot");
    }
}
