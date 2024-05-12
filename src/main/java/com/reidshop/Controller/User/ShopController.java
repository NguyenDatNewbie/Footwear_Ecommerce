package com.reidshop.Controller.User;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Image;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Enum.GENDER;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Reponsitory.ColorRepository;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.ICategoryService;
import com.reidshop.Service.IImageService;
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
@RequestMapping("/shop")
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
    @Autowired
    IImageService imageService;
    @Autowired
    ColorRepository colorRepository;
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
        modelMap.addAttribute("imageService",imageService);
        modelMap.addAttribute("colorRepository",colorRepository);

        return "user/shop";
    }

    @GetMapping("/search")
    String search(@RequestParam("query") String query,ModelMap modelMap){
        List<Product> products = productRepository.searchProduct(query);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("categoryService",categoryService);
        modelMap.addAttribute("categoryRepository",categoryRepository);
        modelMap.addAttribute("products",products);
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("imageService",imageService);
        modelMap.addAttribute("colorRepository",colorRepository);
        return "user/shop";
    }

    @GetMapping({"/filter"})
    @ResponseBody
    ResponseEntity<List<Product>> filter(@RequestParam(value = "categoryId",defaultValue = "0") long categoryId,
                                             @RequestParam(value = "sort",defaultValue = "0") int option,
                                             @RequestParam(value = "sizes",required = false) List<String> sizes,
                                             @RequestParam(value = "colors",required = false) List<String> colors,
                                         @RequestParam(value = "genders",required = false) List<GENDER> genders,
                                            @RequestParam("min") double min, @RequestParam("max") double max)
    {
        List<Product>  products = getNullableCoursesFiltered(categoryId,sizes,genders);
        products = productService.filterRange(products,min,max);
        if(colors!=null)
            products = productService.findProductsByColors(colors,products);
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

    public List<Product> getNullableCoursesFiltered(Long categoryId,List<String> sizes,List<GENDER> genders) {
        if(sizes == null) {
            sizes = Arrays.asList("DUMMYVALUE");
        }
        if(genders!=null)
            return productRepository.getProductsByMulti(categoryId, sizes,genders);
        return productRepository.getProductsByMulti(categoryId, sizes);
    }

    @GetMapping("/color")
    @ResponseBody
    public List<Image> findByProductAndColor(@RequestParam Long productId, @RequestParam Long colorId){
        return iImageService.findAllByProductAndColor(colorId,productId);
    }

    @GetMapping("/image/first/{productId}")
    @ResponseBody
    public List<Image> findImageByProduct(@PathVariable Long productId){
        return imageService.imageFirstOfColor(productId);
    }

    @PostMapping("/favorite")
    @ResponseBody
    public String showFavorite(@RequestBody List<Long> ids){
        String result = "";
        boolean isFirstElement = true;

        for(int i=ids.size()-1;i>=0 ;--i) {
            Long id = ids.get(i);
            Product product = productRepository.findByProductId(id);
            if (product != null) {
                if (isFirstElement) {
                    isFirstElement = false;
                    result += "<div class=\"cart_item top favorites-item\">\n" +
                            "                                        <div class=\"cart_img\">\n" +
                            "                                            <a href=\"/product?id=" +
                            id +
                            "\"><img src=\"" +
                            product.getImages().get(0).getImg() +
                            "\" alt=\"\"></a>\n" +
                            "                                        </div>\n" +
                            "                                        <div class=\"cart_info\">\n" +
                            "                                            <a href=\"/product?id=" +
                            id +
                            "\">" +
                            product.getName() +
                            "</a>\n" +
                            "                                            <span>" +
                            String.valueOf(product.getPrice()*(1-product.getPromotion()/100.0)) +
                            "</span>\n" +
                            "                                        </div>\n" +
                            "                                        <div class=\"cart_remove\">\n" +
                            "                                            <a href=\"#\" onclick=\"deleteItemFavorites(" +
                            id+
                            ")\"><i class=\"fas fa-trash\"></i></a>\n" +
                            "                                        </div>\n" +
                            "                                    </div>\n";
                }
                else
                    result += "<div class=\"cart_item bottom favorites-item\">\n" +
                            "                                        <div class=\"cart_img\">\n" +
                            "                                            <a href=\"/product?id=" +
                            id +
                            "\"><img src=\"" +
                            product.getImages().get(0).getImg() +
                            "\" alt=\"\"></a>\n" +
                            "                                        </div>\n" +
                            "                                        <div class=\"cart_info\">\n" +
                            "                                            <a href=\"/product?id=" +
                            id +
                            "\">" +
                            product.getName() +
                            "</a>\n" +
                            "                                            <span>" +
                            String.valueOf(product.getPrice()*(1-product.getPromotion()/100.0)) +
                            "</span>\n" +
                            "                                        </div>\n" +
                            "                                        <div class=\"cart_remove\">\n" +
                            "                                            <a href=\"#\" onclick=\"deleteItemFavorites(" +
                            id+
                            ")\"><i class=\"fas fa-trash\"></i></a>\n" +
                            "                                        </div>\n" +
                            "                                    </div>\n";
            }
        }
        return result;
    }
}
