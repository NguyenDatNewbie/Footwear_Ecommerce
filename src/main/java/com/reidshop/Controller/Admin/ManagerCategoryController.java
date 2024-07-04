package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Reponsitory.CategoryRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("admin/categories")
public class ManagerCategoryController {
    @Autowired
    CategoryRepository categoryRepository;
    @RequestMapping("")
    public String listProduct(ModelMap modelMap){
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.addAttribute("categories",categoryList);
        return "admin/categories";
    }

    @PostMapping("addNewCate")
    public ModelAndView addNewCate(ModelMap modelMap,
                                   @Valid @ModelAttribute("cate") Category category,
                                   BindingResult result){
        if(result.hasErrors()){
            System.out.println(result);
            return new ModelAndView("admin/categories");
        }
        categoryRepository.save(category);

        return new ModelAndView("redirect:/admin/categories", modelMap);
    }

    @PostMapping("updateCate")
    public ModelAndView updateCate(ModelMap modelMap,
                                   @Valid @ModelAttribute("cate") Category category,
                                   BindingResult result){
        if(result.hasErrors()){
            System.out.println(result);
            return new ModelAndView("admin/categories");
        }
        categoryRepository.save(category);

        return new ModelAndView("redirect:/admin/categories", modelMap);
    }
    @GetMapping("edit/{categoryId}")
    public ModelAndView edit(ModelMap model, @PathVariable("categoryId") Long categoryId){
        Optional<Category> opt = categoryRepository.findById(categoryId); //lấy đối tượng
        if (opt.isPresent()){
            Category category = opt.get();
            model.addAttribute("category", category);
            return new ModelAndView("admin/detailCategory", model);
        }

        return new ModelAndView("redirect:/admin/categories", model);
    }
}
