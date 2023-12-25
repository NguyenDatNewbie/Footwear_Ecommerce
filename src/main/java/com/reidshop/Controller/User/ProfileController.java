package com.reidshop.Controller.User;

//import com.jogamp.common.net.Uri;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Request.PasswordRequest;
import com.reidshop.Model.Request.ProfileRequest;
import com.reidshop.Model.Request.RegisterRequest;
import com.reidshop.Reponsitory.AccountDetailRepository;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.websocket.server.PathParam;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;
import java.util.Optional;

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
    @Autowired
    Cloudinary cloudinary;
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

    @PostMapping("update-img-profile")
    public ModelAndView addNewProduct(ModelMap model,
                                      @Valid @ModelAttribute("account") Account account,
                                      @RequestParam("accountid") Long accountid,
                                      @RequestParam("image-file") MultipartFile imageFile,
                                      BindingResult result) throws IOException {
        if(result.hasErrors()){
            System.out.println(result);
            return new ModelAndView("user/profile");
        }
        Account accountById = accountRepository.findById(accountid).orElse(new Account());
        try {
            if(account != null){
                AccountDetail accountDetail = accountById.getAccountDetail();
                Map r = this.cloudinary.uploader().upload(imageFile.getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                String imgPro = (String) r.get("secure_url");
                accountDetail.setImage(imgPro);
                accountDetailRepository.save(accountDetail);
            }
        } catch (IOException e){
            e.printStackTrace();

        }

        return new ModelAndView("redirect:/profile", model);
    }
}
