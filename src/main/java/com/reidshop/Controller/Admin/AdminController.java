package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.IOrdersService;
import com.reidshop.Service.IProductService;
import com.reidshop.Service.Impl.OrdersServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.Console;
import java.sql.Date;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    IOrdersService ordersService;
    @Autowired
    OrdersRepository ordersRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    IProductService productService;
    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    ImageRepository imageRepository;
    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String index(ModelMap modelMap){
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.addAttribute("categories",categoryList);
        modelMap.addAttribute("productService",productService);
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("imageRepository",imageRepository);
        modelMap.addAttribute("ordersService", ordersService);
        modelMap.addAttribute("ordersRepository", ordersRepository);

        return "admin/admin";
    }
//    @GetMapping("/getTotalRevenue")
//    @ResponseBody
//    public Map<String, Long> getTotalRevenue() {
//        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
//        long result = ordersService.countOrdersCreatedToday();
//
//        // Tạo một đối tượng Map để lưu trữ giá trị theo tên thuộc tính
//        Map<String, Long> responseData = new HashMap<>();
//        responseData.put("totalRevenue", result);
//
//        return responseData;
//    }

    @GetMapping("/getTotalSaleToday")
    @ResponseBody
    public Long getTotalSales() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        long result = ordersService.countOrdersCreatedToday();

        return result;
    }
    @GetMapping("/getTotalSaleThisMonth")
    @ResponseBody
    public Long getTotalSalesOfThisMonth() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        long result = ordersService.countOrdersInCurrentMonth();

        return result;
    }
    @GetMapping("/getTotalSaleThisYear")
    @ResponseBody
    public Long getTotalSalesOfThisYear() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        long result = ordersService.countOrdersInCurrenYear();

        return result;
    }
    @GetMapping("/getTotalRevenueToday")
    @ResponseBody
    public Double getTotalRevenueToday() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        double result = ordersService.totalRevenueOfToday();

        return result;
    }
    @GetMapping("/getTotalRevenueThisMonth")
    @ResponseBody
    public Double getTotalRevenueThisMonth() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        double result = ordersService.totalRevenueOfThisMonth();

        return result;
    }
    @GetMapping("/getTotalRevenueThisYear")
    @ResponseBody
    public Double getTotalRevenueThisYear() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        double result = ordersService.totalRevenueOfThisYear();

        return result;
    }
    @GetMapping("/getOrderIncreaseLastMonth")
    @ResponseBody
    public String getPercentOrderIncreaseLastMonth(){
        LocalDate currentDate = LocalDate.now();
        //Lấy tháng trước
        LocalDate lastMonthDate = currentDate.minusMonths(1);
        int month = lastMonthDate.getMonthValue();
        int year = lastMonthDate.getYear();

        long thisMonth = ordersService.countOrdersInCurrentMonth();
        long lastMonth = ordersService.countOrdersOfMonth(year, month);
        double result = ((double) (thisMonth - lastMonth) / lastMonth) * 100.0;

        //lấy 2 số thập phân
        DecimalFormat decimalFormat = new DecimalFormat("#.##");
        return decimalFormat.format(result);
    }

    @GetMapping("/getOrderIncreaseLastDate")
    @ResponseBody
    public String getPercentCountOrderLastDate(){
        LocalDate today = LocalDate.now();
        LocalDate yesterday = today.minusDays(1);

        long todayOrder = ordersService.countOrdersCreatedToday();
        long yerterdayOrder = ordersService.countOrderByDate(Date.valueOf(yesterday));

        double result = ((double) (todayOrder - yerterdayOrder) / yerterdayOrder) * 100.0;

        DecimalFormat decimalFormat = new DecimalFormat("#.##");

        return decimalFormat.format(result);
    }
}
