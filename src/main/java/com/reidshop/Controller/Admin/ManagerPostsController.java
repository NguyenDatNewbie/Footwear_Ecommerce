package com.reidshop.Controller.Admin;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Image;
import com.reidshop.Model.Entity.Posts;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.PostsRepository;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("/admin/posts")
public class ManagerPostsController {
    @Autowired
    PostsRepository postsRepository;
    @Autowired
    JwtService jwtService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    Cloudinary cloudinary;
    @GetMapping("/new")
    String get(){
        return "admin/createOrEditPost";
    }
    @GetMapping("/{id}")
    String getById(@PathVariable Long id, ModelMap modelMap){
        modelMap.addAttribute("post",postsRepository.findById(id).orElse(null));
        return "admin/createOrEditPost";
    }
    @GetMapping("")
    String getAll(ModelMap modelMap){
        modelMap.addAttribute("posts",postsRepository.findAll());
        return "admin/posts";
    }

    @PostMapping("/save")
    String save(@ModelAttribute Posts posts
            , @RequestParam("image-file") MultipartFile imageFiles, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        if(account!=null) {
            try {
                Map r = this.cloudinary.uploader().upload(imageFiles.getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                String img = (String) r.get("secure_url");
                posts.setImage(img);

            }catch (IOException e){
                e.printStackTrace();
            }

            posts.setAccount(account);
            if(posts.getId()==null) {
                posts.setCreatedAt(new Date());
                posts.setUpdateAt(new Date());
            }
            else
                posts.setUpdateAt(new Date());


            postsRepository.save(posts);

        }
        return "admin/createOrEditPost";
    }

}
