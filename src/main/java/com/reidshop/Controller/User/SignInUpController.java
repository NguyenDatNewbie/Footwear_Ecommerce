package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Request.RegisterRequest;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Service.IAccountService;
import com.reidshop.Service.IEmailService;
import com.reidshop.exception.ValidationHandle;
import com.reidshop.security.JwtService;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import com.reidshop.token.HandleToken;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
//import com.reidshop.Config.WebSecurityConfig;



@Controller
@RequestMapping("/sign-in-up")
public class SignInUpController {
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    IAccountService accountService;
    @Autowired
    HandleToken token;
    @Autowired
    AuthenticationManager authenticationManager;
    @Autowired
    JwtService jwtService;


    @RequestMapping("")
    public String index() {
        return "user/login";
    }


    @PostMapping("/register")
    public ModelAndView registration(@Valid @ModelAttribute("request") RegisterRequest request,
                              BindingResult result, ModelMap modelMap, HttpServletResponse response, HttpSession session) {
        if(accountRepository.findByEmail(request.getEmail()).isPresent()) {
            modelMap.addAttribute("exitsEmail","Email đã tồn tại");
            modelMap.addAttribute("isLogin",false);
            return new ModelAndView("user/login");
        }

        if (result.hasErrors()) {
            modelMap.addAttribute("errors", ValidationHandle.showAllError(result));
            modelMap.addAttribute("request",request);
            modelMap.addAttribute("isLogin",false);
            return new ModelAndView("user/login");
        }

        if(!request.getPassword().equals(request.getRePassword()))
        {
            modelMap.addAttribute("rePasswordEqual","Password không trùng khớp");
            modelMap.addAttribute("request",request);
            modelMap.addAttribute("isLogin",false);
            return new ModelAndView("user/login");
        }
        session.setAttribute("register",request);

        return new ModelAndView("redirect:/otp/register");
    }


    @PostMapping("/login")
    public ModelAndView login(@ModelAttribute("request") RegisterRequest request, ModelMap modelMap, HttpServletResponse response) {
        try {
            response.addCookie(CookieHandle.createCookie("token",token.generateToken(request.getEmail(),request.getPassword())));

            return new ModelAndView("redirect:/index");
        } catch (BadCredentialsException exception)
        {
            modelMap.addAttribute("loginError", "Email hoặc password không hợp lệ");
            modelMap.addAttribute("requestLogin", request);
            modelMap.addAttribute("isLogin", true);
            return new ModelAndView("user/login");
        }
    }
}
