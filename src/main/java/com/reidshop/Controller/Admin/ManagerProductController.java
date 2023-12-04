package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Reponsitory.ProductRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

@Controller
@RequestMapping("admin/products")
public class ManagerProductController {
    @Autowired
    OrdersRepository ordersRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    CategoryRepository categoryRepository;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String listProduct(ModelMap modelMap){
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.addAttribute("categories",categoryList);
        modelMap.addAttribute("ordersRepository", ordersRepository);
        modelMap.addAttribute("productRepository", productRepository);
        modelMap.addAttribute("formatVND",formatVND);

        return "admin/products";
    }

    @PostMapping("addNewProduct")
    public ModelAndView addNewProduct(ModelMap model,
                                     @Valid @ModelAttribute("product") Product product, BindingResult result){
        if(result.hasErrors()){
            return new ModelAndView("admin/detailOrEdit");
        }
        productRepository.save(product);

        return new ModelAndView("redirect:/admin/products", model);
    }

    @PostMapping("updateProduct")
    public ModelAndView updateProduct(ModelMap model,
                                      @Valid @ModelAttribute("product") Product product, BindingResult result){
        if(result.hasErrors()){
            return new ModelAndView("admin/detailOrEdit");
        }
        productRepository.save(product);

        return new ModelAndView("redirect:/admin/products", model);
    }

    @GetMapping("edit/{productId}")
    public ModelAndView edit(ModelMap model, @PathVariable("productId") Long productId){
        Optional<Product> opt = productRepository.findById(productId); //lấy đối tượng
        if (opt.isPresent()){
            Product product = opt.get();
            model.addAttribute("product", product);
            return new ModelAndView("admin/detailOrEdit", model);
        }

        return new ModelAndView("redirect:/admin/products", model);
    }
}
