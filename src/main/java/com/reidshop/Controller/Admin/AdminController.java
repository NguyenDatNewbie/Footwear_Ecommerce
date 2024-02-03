package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.IOrdersService;
import com.reidshop.Service.IProductService;
import com.reidshop.Service.Impl.OrdersServiceImpl;
import com.reidshop.dto.DailyTotalDTO;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import java.util.*;

@Controller
@RequestMapping("/admin/home")
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
    @Autowired
    IOrderItemService orderItemService;
    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String index(ModelMap modelMap){
        List<Category> categoryList = categoryRepository.findAll();
        List<Double> listRevenue = listRevenueOfThisWeek();
        modelMap.addAttribute("categories",categoryList);
        modelMap.addAttribute("listRevenue",listRevenue);
        modelMap.addAttribute("productService",productService);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("imageRepository",imageRepository);
        modelMap.addAttribute("ordersService", ordersService);
        modelMap.addAttribute("orderItemService", orderItemService);
        modelMap.addAttribute("ordersRepository", ordersRepository);

        return "admin/admin";
    }

    //Orders
    @GetMapping("/getTotalOrderToday")
    @ResponseBody
    public Long getTotalOrders() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        long result = ordersService.countOrdersCreatedToday();

        return result;
    }
    @GetMapping("/getTotalOrderThisMonth")
    @ResponseBody
    public Long getTotalOrdersOfThisMonth() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        long result = ordersService.countOrdersInCurrentMonth();

        return result;
    }
    @GetMapping("/getTotalOrderThisYear")
    @ResponseBody
    public Long getTotalOrdersOfThisYear() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        long result = ordersService.countOrdersInCurrenYear();

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

    //Sales
    @GetMapping("/getTotalSalesToday")
    @ResponseBody
    public Optional<Double> getTotalSalesToday() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        Optional<Double> result = Optional.of(ordersService.totalSalesOfToday());

        if (!result.isPresent()) {
            // Trả về giá trị mặc định
            return Optional.of(0.0);
        }
        return result;
    }
    @GetMapping("/getTotalSalesThisMonth")
    @ResponseBody
    public  Optional<Double> getTotalSalesThisMonth() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        Optional<Double> result = Optional.of(ordersService.totalSalesOfThisMonth());
        if (!result.isPresent()) {
            // Trả về giá trị mặc định
            return Optional.of(0.0);
        }
        return result;
    }
    @GetMapping("/getTotalSalesThisYear")
    @ResponseBody
    public Double getTotalSalesThisYear() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        double result = ordersService.totalSalesOfThisYear();

        return result;
    }

    //Revenue
    @GetMapping("/getRevenueToday")
    @ResponseBody
    public Double getRevenueToday(){
        List<Integer> orderIdList = ordersService.findAllOrderToday();
        if (orderIdList == null || orderIdList.isEmpty()) {
            return 0.0; // Return 0 if no orders found
        }
        double salesToday = ordersService.totalSalesOfToday();
        double originalPrice = 0;
        for (int i = 0; i < orderIdList.size(); i++){
            Integer orderId =orderIdList.get(i);
            originalPrice += orderItemService.totalPriceOriginalOrders(orderId);
        }
        double revenueToday = salesToday - originalPrice;
        return revenueToday;
    }
    @GetMapping("/getRevenueThisWeek")
    @ResponseBody
    public Double getRevenueThisWeek(){
        //List order of this week
        List<Integer> listId = ordersService.findAllOrderOfThisWeek();
        if (listId == null || listId.isEmpty()) {
            return 0.0; // Return 0 if no orders found
        }
        //Doanh số thu được trong 1 tuần
        double salesThisWeek = ordersService.totalPriceOfThisWeek();

        double originalPrice = 0;
        //Tính số tiền vốn của các hóa đơn bán ra trong 1 tuần
        for (int i = 0; i < listId.size(); i++){
            Integer orderId =listId.get(i);
            originalPrice += orderItemService.totalPriceOriginalOrders(orderId);
        }
        double revenueThisWeek = salesThisWeek - originalPrice;
        return revenueThisWeek;
    }

    @GetMapping("/getRevenueThisMonth")
    @ResponseBody
    public Double getRevenueThisMonth(){
        //List order of this month
        List<Integer> listId = ordersService.findAllOrderOfThisMonth();
        if (listId == null || listId.isEmpty()) {
            return 0.0; // Return 0 if no orders found
        }
        //Doanh số thu được trong 1 month
        double salesThisMonth = ordersService.totalSalesOfThisMonth();

        double originalPrice = 0;
        //Tính số tiền vốn của các hóa đơn bán ra trong 1 tuần
        for (int i = 0; i < listId.size(); i++){
            Integer orderId =listId.get(i);
            originalPrice += orderItemService.totalPriceOriginalOrders(orderId);
        }
        double revenueThisMonth = salesThisMonth - originalPrice;
        return revenueThisMonth;
    }

    @GetMapping("/salesThisWeek")
    @ResponseBody
    public ResponseEntity<List<Double>> getSalesData() {
        List<Double> salesData = ordersService.listTotalPriceOfThisWeek();
        return ResponseEntity.ok(salesData);
    }

    public List<Double> listRevenueOfThisWeek(){
        List<Object[]> result = ordersService.findOrderIdsByWeek();

        for (Object[] row : result) {
            for (Object column : row) {
                System.out.print(column + "\t");
            }
            System.out.println();
        }

        List<Double> listRevenueThisWeek = new ArrayList<>();
        for (Object[] row : result) {
            double revenue = 0;
            String orderIds = (String) row[1];

            String[] orderIdArray = orderIds.split(",");

            for (String orderId : orderIdArray) {
                Optional<Orders> order =ordersRepository.findById(Long.valueOf(orderId));
                System.out.println(orderId);
                double totalOriginalOfOrder = orderItemService.totalPriceOriginalOrders(Integer.parseInt(orderId));
                System.out.println(totalOriginalOfOrder);
                revenue += (order.get().getTotalPrice() - (order.get().getCostShip() + totalOriginalOfOrder));
            }
            listRevenueThisWeek.add(revenue);
        }

        return listRevenueThisWeek;
    }

}
