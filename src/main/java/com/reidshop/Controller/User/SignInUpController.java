package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Enum.ROLE;
import com.reidshop.Model.Request.RegisterRequest;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Service.IAccountService;
import com.reidshop.dto.GoogleAccessTokenResponse;
import com.reidshop.dto.GoogleUserInfo;
import com.reidshop.exception.ValidationHandle;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import com.reidshop.token.HandleToken;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.*;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
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
    private final RestTemplate restTemplate;

    public SignInUpController(RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder.build();
    }

    @RequestMapping("")
    public String index() {
        return "user/login";
    }

    @GetMapping("/logout")
    public ModelAndView logout(@RequestParam("back") String urlBack, HttpServletResponse response, HttpServletRequest request){
        CookieHandle.RemoveCookies(request,response);
        return new ModelAndView("redirect:/"+urlBack);
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
            Account account= accountRepository.findByEmail(request.getEmail()).orElse(null);
            if(account==null){
                modelMap.addAttribute("loginError", "Email chưa được đăng ký");
                modelMap.addAttribute("requestLogin", request);
                modelMap.addAttribute("isLogin", true);
                return new ModelAndView("user/login");
            }
            response.addCookie(CookieHandle.createCookie("token",token.generateToken(request.getEmail(),request.getPassword())));
            response.addCookie(CookieHandle.createCookieNotAuthentication("isLogin","true"));
            if(account.getRole()== ROLE.ADMIN )
                return new ModelAndView("redirect:/admin/home");
            else if(account.getRole() == ROLE.VENDOR)
                return new ModelAndView("redirect:/vendor/home");
            return new ModelAndView("redirect:/");
        } catch (BadCredentialsException exception)
        {
            modelMap.addAttribute("loginError", "Email hoặc password không hợp lệ");
            modelMap.addAttribute("requestLogin", request);
            modelMap.addAttribute("isLogin", true);
            return new ModelAndView("user/login");
        }
    }

    @GetMapping("/login/google/success")
    public ModelAndView loginWithGG(@RequestParam("code") String authorizationCode, HttpServletResponse response){
        // Lấy Access Token từ Mã Xác Thực
        String accessTokenUri = "https://oauth2.googleapis.com/token";
        String redirectUri = "/sign-in-up/login/google/success";
        String clientId = "47551941690-h1bot25tietr34kbcmp0sh13n0lid1mu.apps.googleusercontent.com";
        String clientSecret = "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";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        HttpEntity<String> request = new HttpEntity<>("code=" + authorizationCode +
                "&client_id=" + clientId +
                "&client_secret=" + clientSecret +
                "&redirect_uri=" + redirectUri +
                "&grant_type=authorization_code", headers);

        ResponseEntity<GoogleAccessTokenResponse> responseEntity = restTemplate.postForEntity(accessTokenUri, request, GoogleAccessTokenResponse.class);
        GoogleAccessTokenResponse accessTokenResponse = responseEntity.getBody();

        String userInfoUri = "https://www.googleapis.com/oauth2/v2/userinfo";
        HttpHeaders userInfoHeaders = new HttpHeaders();
        userInfoHeaders.setBearerAuth(accessTokenResponse.getAccess_token());
        HttpEntity<String> userInfoRequest = new HttpEntity<>(userInfoHeaders);
        GoogleUserInfo googleUserInfo = restTemplate.exchange(userInfoUri,HttpMethod.GET, userInfoRequest, GoogleUserInfo.class).getBody();
        Account account = accountService.loginWithGoogle(googleUserInfo);
        response.addCookie(CookieHandle.createCookie("token",jwtService.generateToken(account.getEmail())));
        response.addCookie(CookieHandle.createCookieNotAuthentication("isLogin","true"));
        return new ModelAndView("redirect:/");
    }
}
