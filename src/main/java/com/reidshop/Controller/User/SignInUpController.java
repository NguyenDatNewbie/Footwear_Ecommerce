package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.SetCookie;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Request.RegisterRequest;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Service.IAccountSevice;
import com.reidshop.exception.ValidationHandle;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;

import com.reidshop.token.HandleToken;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
//import com.reidshop.Config.WebSecurityConfig;



@Controller
@RequestMapping("/sign-in-up")
public class SignInUpController {
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    IAccountSevice accountSevice;
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

    @PostMapping("/save")
    public ModelAndView registration(@Valid @ModelAttribute("request") RegisterRequest request,
                              BindingResult result, ModelMap modelMap) {
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

        accountSevice.save(request);
        System.out.println(token.generateToken(request.getEmail(), request.getPassword()));
        return new ModelAndView("user/index");
    }


    @PostMapping("/sign-in")
    public ModelAndView login(@ModelAttribute("request") RegisterRequest request, ModelMap modelMap, HttpServletResponse response) {
        try {
            Authentication authentication =  authenticationManager.authenticate((new UsernamePasswordAuthenticationToken
                    (request.getEmail(), request.getPassword())));
            SecurityContextHolder.getContext().setAuthentication(authentication);


            response.addCookie(SetCookie.createCookie("token",jwtService.generateToken(request.getEmail())));
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
