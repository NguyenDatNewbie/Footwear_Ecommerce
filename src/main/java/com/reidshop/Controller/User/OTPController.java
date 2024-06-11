package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Request.RegisterRequest;
import com.reidshop.Service.IAccountService;
import com.reidshop.Service.IEmailService;
import com.reidshop.security.JwtService;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping("/otp")
public class OTPController {
    @Autowired
    IEmailService emailService;
    @Autowired
    IAccountService accountService;
    @Autowired
    JwtService jwtService;
    @GetMapping("/{type}")
    String index(HttpSession session,@PathVariable String type,ModelMap modelMap) throws MessagingException {
        String code = emailService.randomCode();
        RegisterRequest request = (RegisterRequest) session.getAttribute("register");
        if(request==null)
            return "user/login";
        emailService.sendCodeToEmail(request.getEmail(), code);

        modelMap.addAttribute("type",type);
        session.setAttribute("otp", code);
        session.setAttribute("creationTime",System.currentTimeMillis());
        session.setMaxInactiveInterval(60*24); // 1 ngày
        return "user/otp";
    }

    @PostMapping("/confirm/{type}")
    ModelAndView confirm(@PathVariable String type, @ModelAttribute("otpValue") String otpValue
            , HttpSession session, HttpServletResponse response,ModelMap modelMap ) {
        String otpTrue = (String) session.getAttribute("otp");
        Long creationTime = (Long)  session.getAttribute("creationTime");
        long currentTime = System.currentTimeMillis();
        // > 1 phút
        if(currentTime-creationTime>60*1000){
            modelMap.addAttribute("message","Error: Mã OTP của bạn đã hết hạn");
            return new ModelAndView("user/otp");
        }
        if (otpTrue.equals(otpValue)) {
            if (type.equals("register")) {
                RegisterRequest request = (RegisterRequest) session.getAttribute("register");
                accountService.save(request);
                response.addCookie(CookieHandle.createCookie("token",jwtService.generateToken(request.getEmail())));
                response.addCookie(CookieHandle.createCookieNotAuthentication("isLogin","true"));
                session.removeAttribute("otp");
                session.removeAttribute("register");
                return new ModelAndView("redirect:/");
            }
            else if(type.equals("resetPassword")){
                session.removeAttribute("otp");
                return new ModelAndView("redirect:/password/resetPassword");
            }
        }
        else {
            modelMap.addAttribute("message","Error: Mã OTP không hợp lệ");
            return new ModelAndView("user/otp");
        }
        return new ModelAndView("redirect:/otp/register");
    }
}
