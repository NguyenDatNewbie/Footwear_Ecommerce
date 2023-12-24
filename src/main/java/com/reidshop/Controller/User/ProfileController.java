package com.reidshop.Controller.User;

import com.jogamp.common.net.Uri;
import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.AccountDetail;
import com.reidshop.Model.Request.PasswordRequest;
import com.reidshop.Model.Request.ProfileRequest;
import com.reidshop.Model.Request.RegisterRequest;
import com.reidshop.Reponsitory.AccountDetailRepository;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.websocket.server.PathParam;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfileController {
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    AccountDetailRepository accountDetailRepository;

    @Autowired
    PasswordEncoder passwordEncoder;
    final JwtService jwtService;
    @GetMapping("")
    String getProfile(@RequestParam(value = "status",required = false) String status,
                      @RequestParam(value = "message",required = false) String message,
                      ModelMap modelMap, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);


        Account account = accountRepository.findByEmail(email).orElse(new Account());
        modelMap.addAttribute("info",account);
        return "user/profile";
    }

    @GetMapping("/update/{id}")
    String editProfile(@PathVariable Long id, ModelMap modelMap){
        Account account = accountRepository.findById(id).orElse(new Account());
        modelMap.addAttribute("info",account);
        return "user/edit-profile";
    }

    @PostMapping(value = "/update",consumes = {"application/x-www-form-urlencoded"})
    ModelAndView update(@ModelAttribute ProfileRequest profileRequest){
        Account account = accountRepository.findByEmail(profileRequest.getEmail()).orElse(new Account());
        if(account!=null) {
            AccountDetail accountDetail = account.getAccountDetail();
            accountDetail.setName(profileRequest.getName());
            accountDetail.setPhone(profileRequest.getPhone());
            accountDetail.setAddress(profileRequest.getAddress());
            accountDetailRepository.save(accountDetail);
        }
        return new ModelAndView("redirect:/profile");
    }

    @PostMapping("/change-pass-word")
    ModelAndView changePassword(@ModelAttribute PasswordRequest request) throws UnsupportedEncodingException {
        Account account = accountRepository.findByEmail(request.getEmail()).orElse(null);
        if(account==null)
        {
            return new ModelAndView("redirect:/sign-in-up");
        }
//        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(request.getEmail(), request.getCurrentPassword()));
        Boolean checkPassword = passwordEncoder.matches(request.getCurrentPassword(),account.getPassword());
        if(!checkPassword)
        {
            return new ModelAndView("redirect:/profile"+"?status=failed&message="+ URLEncoder.encode("Mật khẩu không chính xác","UTF-8"));
        }
        if(!request.getPassword().equals(request.getRePassword()))
        {
            return new ModelAndView("redirect:/profile"+"?status=failed&message="+ URLEncoder.encode("Mật khẩu không trùng","UTF-8"));
        }
        account.setPassword(passwordEncoder.encode(request.getPassword()));
        accountRepository.save(account);
        return new ModelAndView("redirect:/profile"+"?status=success&message="+ URLEncoder.encode("Thây đổi mật khẩu thành công","UTF-8"));
    }
}
