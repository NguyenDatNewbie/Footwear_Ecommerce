package com.reidshop.Controller.User;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping("/")
public class IndexController {
    @Autowired
    ProductRepository productRepository;
    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    ImageRepository imageRepository;
    @Autowired
    IProductService productService;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String index(ModelMap modelMap){
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.addAttribute("categories",categoryList);
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("productService",productService);
        modelMap.addAttribute("iImageService",imageRepository);
        modelMap.addAttribute("formatVND",formatVND);
        return "user/index";
    }
}
