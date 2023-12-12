package com.reidshop.Controller.User;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.ICategoryService;
import com.reidshop.Service.IProductService;
import jakarta.websocket.server.PathParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
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
//    List<Product> products = new ArrayList<>();
    List<Product> productsSelect = new ArrayList<>();
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);


//    @GetMapping("/{brandId}")
//    String Brand(ModelMap modelMap,@PathVariable Long brandId){
//        products = productRepository.findAllByCategory(brandId);
//        Category category = categoryRepository.findCategoriesById(brandId);
//        modelMap.addAttribute("formatVND",formatVND);
//
//        modelMap.addAttribute("currentCategory",category);
//        modelMap.addAttribute("categoryService",categoryService);
//        modelMap.addAttribute("categoryRepository",categoryRepository);
//        modelMap.addAttribute("products",products);
//        modelMap.addAttribute("productRepository",productRepository);
//        return "user/shop";
//    }

    @GetMapping("")
    String get(ModelMap modelMap){
        List<Product> products = productRepository.findAll();
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("categoryService",categoryService);
        modelMap.addAttribute("categoryRepository",categoryRepository);
        modelMap.addAttribute("products",products);
        modelMap.addAttribute("productRepository",productRepository);
        return "user/shop";
    }

    @GetMapping({"/filter"})
    @ResponseBody
    ResponseEntity<List<Product>> filter(@RequestParam(value = "categoryId",defaultValue = "0") long categoryId,
                                             @RequestParam(value = "sort",defaultValue = "0") int option,
                                             @RequestParam(value = "sizes",required = false) List<String> sizes,
                                             @RequestParam(value = "colors",required = false) List<String> colors,
                                            @RequestParam("min") double min, @RequestParam("max") double max)
    {
        List<Product>  products = getNullableCoursesFiltered(categoryId,colors,sizes);
        products = productService.filterRange(products,min,max);
        if(option!=0) {
            if (option == 1)
                products = productService.sortByProductSold(products);
            else if (option == 2)
                products = productService.sortByPriceDESC(products);
            else if (option == 3)
                products = productService.sortByPriceASC(products);
            else if (option == 4)
                products = productService.sortByNameAToZ(products);
            else
                products = productService.sortByNameZtoA(products);
        }

        return new ResponseEntity<>(products,HttpStatus.OK);
    }

    public List<Product> getNullableCoursesFiltered(Long categoryId,List<String> colors,List<String> sizes) {
        if(colors == null) {
            colors = Arrays.asList("DUMMYVALUE");
        }
        if(sizes == null) {
            sizes = Arrays.asList("DUMMYVALUE");
        }
        return productRepository.getProductsByMulti(categoryId, colors, sizes);
    }

}
