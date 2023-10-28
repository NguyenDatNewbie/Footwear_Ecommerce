package com.reidshop.Controller.User;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.ICategoryService;
import com.reidshop.Service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping("shop")
public class ShopController {
    @Autowired
    IProductService productService;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    ImageRepository iImageService;
    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    ICategoryService categoryService;
    Locale locale = new Locale("vi","VN");
    List<Product> products = new ArrayList<>();
    List<Product> productsSelect = new ArrayList<>();
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);


    @GetMapping("/{brandId}")
    String Brand(ModelMap modelMap,@PathVariable Long brandId){
        products = productRepository.findAllByCategory(brandId);
        productsSelect = productService.selectTop(products,0,12);
        Category category = categoryRepository.findCategoriesById(brandId);
        List<Category> categories = categoryService.familyCategoryByChildren(category);
        modelMap.addAttribute("formatVND",formatVND);

        modelMap.addAttribute("currentCategory",category);
        modelMap.addAttribute("categories",categories);
        modelMap.addAttribute("categoryService",categoryService);
        modelMap.addAttribute("categoryRepository",categoryRepository);

        modelMap.addAttribute("products",productsSelect);
        modelMap.addAttribute("productRepository",productRepository);

        modelMap.addAttribute("sizes",productService.sizeProduct(products));
        return "user/shop";
    }

    @GetMapping({"/{categoryId}/sort/{option}"})
    ResponseEntity<List<Product>> getAllSort(@PathVariable Long categoryId,@PathVariable int option){
        if(option == 1) {
            products = productService.sortByProductSold(products);
        }
        else if(option==2)
            products = productService.sortByPriceDESC(products);
        else if(option==3)
            products = productService.sortByPriceASC(products);
        else if(option==4)
            products = productService.sortByNameAToZ(products);
        else
            products = productService.sortByNameZtoA(products);

        return new ResponseEntity<>(products,HttpStatus.OK);
    }

    @GetMapping({"/{categoryId}/filterPrice/{min}/{max}"})
    ResponseEntity<List<Product>> filterPrice(@PathVariable Long categoryId,@PathVariable double min,@PathVariable double max){
        products = productService.filterRange(categoryId,min,max);
        return new ResponseEntity<>(products,HttpStatus.OK);
    }



}
