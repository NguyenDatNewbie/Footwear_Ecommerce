package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.EvaluateRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.Handle.CollaborativeFiltering;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;

@RestController
@RequestMapping("/api/product/recommend")
public class ProductRecommendation {
    @Autowired
    JwtService jwtService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    EvaluateRepository evaluateRepository;
    @Autowired
    CollaborativeFiltering collaborativeFiltering;

    @GetMapping("")
    List<Product> collaborativeFilter(HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        List<Product> products = collaborativeFiltering.collaborativeFilter(account,true,null);
        return products;
    }


}
