package com.reidshop.Controller.User;

import com.reidshop.Model.Entity.Posts;
import com.reidshop.Model.Enum.PostType;
import com.reidshop.Reponsitory.PostsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/blogs")
public class BlogController {
    @Autowired
    PostsRepository postsRepository;
    @GetMapping("")
    String blogs(@RequestParam("type") PostType postType,ModelMap modelMap){
        List<Posts> posts = postsRepository.findAllByPostType(postType);
        modelMap.addAttribute("posts",posts);
        modelMap.addAttribute("news",postsRepository.findNews(PageRequest.of(0, 3)));
        return "user/blog";
    }

    @GetMapping("/size/detail/{blogId}")
    String sizeDetail(ModelMap modelMap, @PathVariable Long blogId){
        Posts posts = postsRepository.findById(blogId).orElse(null);
        modelMap.addAttribute("post",posts);
        return "user/blog-details";
    }

}
