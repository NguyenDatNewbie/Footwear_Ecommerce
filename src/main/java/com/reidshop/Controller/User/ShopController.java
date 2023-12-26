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
import java.util.*;

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
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
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

    @GetMapping("/search")
    String search(@RequestParam("query") String query,ModelMap modelMap){
        List<Product> products = productRepository.searchProduct(query);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("categoryService",categoryService);
        modelMap.addAttribute("categoryRepository",categoryRepository);
        modelMap.addAttribute("products",products);
        modelMap.addAttribute("productRepository",productRepository);
        return "user/shop";
    }

    @GetMapping("/searchList")
    @ResponseBody
    List<Map<String,String>> searchListName(@RequestParam("query") String query){
        List<Product> products = productRepository.searchProduct(query);
        List<Map<String,String>> maps = new ArrayList<>();
        for (Product product:products) {
            Map<String,String> map  = new HashMap<>();
            map.put("link","/product/"+ String.valueOf(product.getId()));
            map.put("img",product.getImages().get(0).getImg());
            map.put("name",product.getName());
            map.put("priceOrigin",String.valueOf(product.getPrice()));
            map.put("price", String.valueOf(product.getPrice()*(1-product.getPromotion()/100.0)));
            maps.add(map);
        }
        return maps;
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
