package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.CollaborativeFiltering;
import com.reidshop.Service.IProductService;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.*;

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
    @Autowired
    CollaborativeFiltering collaborativeFiltering;
    @Autowired
    JwtService jwtService;
    @Autowired
    AccountRepository accountRepository;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String index(ModelMap modelMap, HttpServletRequest request){
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.addAttribute("categories",categoryList);
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("productService",productService);
        modelMap.addAttribute("iImageService",imageRepository);
        modelMap.addAttribute("formatVND",formatVND);

        modelMap.addAttribute("productSoldAll",quantityListEven(productRepository.findAllByProductSold()));
        modelMap.addAttribute("productSoldOfYear",quantityListEven(productRepository.findAllByProductSoldOfYear()));
        modelMap.addAttribute("productSoldOfMonth",quantityListEven(productRepository.findAllByProductSoldOfMonth()));

        // Lấy ngày hiện tại
        Calendar calendar = Calendar.getInstance();
        Date endOfWeek = calendar.getTime();
        calendar.setTime(new Date());

        // Thiết lập ngày bắt đầu của tuần
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        Date startOfWeek = calendar.getTime();

        // In ra ngày bắt đầu và kết thúc của tuần
        System.out.println("Start of week: " + startOfWeek);
        System.out.println("End of week: " + endOfWeek);
        List<Product> products = productRepository.findAllBySoldOfWeek(startOfWeek,endOfWeek);
        modelMap.addAttribute("productSoldOfWeek",quantityListEven(productRepository.findAllBySoldOfWeek(startOfWeek,endOfWeek)));

        List<Product> productRecommend = new ArrayList<>();
        try {
            String token = CookieHandle.getCookieValue(request, "token");
            String email = jwtService.extractUsername(token);
            Account account = accountRepository.findByEmail(email).orElse(null);
            if (account != null)
                productRecommend= collaborativeFiltering.collaborativeFilter(account,true,null);
        }
        catch (Exception e){
            System.out.println("User not logged in");
        }
        modelMap.addAttribute("productRecommend",productRecommend);
        return "user/index";
    }

    List<Product> quantityListEven(List<Product> products){
        if(products.size()%2==0)
            return products;
        products.remove(products.size()-1);
        return products;
    }
}
