package com.reidshop.Controller.Vendor;

import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.IOrdersService;
import com.reidshop.Service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.*;

@Controller
@RequestMapping("/vendor/home")
public class VendorHomeController {
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
    @Autowired
    IOrdersService iOrdersService;
    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String index(ModelMap modelMap){
        List<Category> categoryList = categoryRepository.findAll();
        List<Orders> ordersAll = ordersRepository.findAllByStoreID(1L);
        modelMap.addAttribute("ordersAll", ordersAll);


        modelMap.addAttribute("orderToday", ordersRepository.countTodayOrdersForStore(1l)); //Count Order Today
        modelMap.addAttribute("saleToday", ordersRepository.totalSalesOfTodayStore(1l));
        modelMap.addAttribute("listTotalPriceOfThisWeekStore", ordersRepository.listTotalPriceOfThisWeekStore(1l));
        modelMap.addAttribute("revenueToday", getRevenueTodayStore());
        modelMap.addAttribute("categories",categoryList);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("imageRepository",imageRepository);
        modelMap.addAttribute("ordersService", ordersService);
        modelMap.addAttribute("orderItemService", orderItemService);
        modelMap.addAttribute("ordersRepository", ordersRepository);
        return "vendor/home";
    }
    @RequestMapping("/getTotalOrderStore")
    @ResponseBody
    public int countOrderVendor(){
        int result = ordersRepository.countAllOrdersForStore(1l);
        return result;
    }

    @RequestMapping("/getTodayOrderStore")
    @ResponseBody
    public int countTodayOrder(){
        int result = ordersRepository.countTodayOrdersForStore(1l);
        return result;
    }

    @RequestMapping("/getMonthOrderStore")
    @ResponseBody
    public int countMonthOrder(){
        int result = ordersRepository.countMonthOrdersForStore(1l);
        return result;
    }

    //Sales
    @GetMapping("/getTotalSalesStore")
    @ResponseBody
    public Optional<Double> getTotalSalesStore() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        Optional<Double> result = Optional.of(ordersRepository.saleAllByStoreId(1l));

        if (!result.isPresent()) {
            // Trả về giá trị mặc định
            return Optional.of(0.0);
        }
        return result;
    }

    @GetMapping("/getTodaySalesStore")
    @ResponseBody
    public Optional<Double> getTodaySalesStore() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        Optional<Double> result = Optional.of(ordersRepository.totalSalesOfTodayStore(1l));

        if (!result.isPresent()) {
            // Trả về giá trị mặc định
            return Optional.of(0.0);
        }
        return result;
    }

    @GetMapping("/getMonthSalesStore")
    @ResponseBody
    public Optional<Double> getMonthSalesStore() {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        Optional<Double> result = Optional.of(ordersRepository.totalSalesOfMonthStore(1l));

        if (!result.isPresent()) {
            // Trả về giá trị mặc định
            return Optional.of(0.0);
        }
        return result;
    }

    //Revenue
    @GetMapping("/getRevenueTodayStore")
    @ResponseBody
    public Double getRevenueTodayStore(){
        List<Integer> orderIdList = ordersRepository.findAllOrderTodayStore(1l);
        if (orderIdList == null || orderIdList.isEmpty()) {
            return 0.0; // Return 0 if no orders found
        }
        double salesToday = ordersRepository.totalSalesOfTodayStore(1l);
        double originalPrice = 0;
        for (int i = 0; i < orderIdList.size(); i++){
            Integer orderId =orderIdList.get(i);
            originalPrice += orderItemService.totalPriceOriginalOrders(orderId);
        }
        double revenueToday = salesToday - originalPrice;
        return revenueToday;
    }

    @GetMapping("/getRevenueWeekStore")
    @ResponseBody
    public Double getRevenueWeekStore(){
        List<Integer> orderIdList = ordersRepository.findAllOrderMonthStore(1l);
        if (orderIdList == null || orderIdList.isEmpty()) {
            return 0.0; // Return 0 if no orders found
        }
        double salesWeek = ordersRepository.totalPriceOfThisWeekStore(1l);
        double originalPrice = 0;
        for (int i = 0; i < orderIdList.size(); i++){
            Integer orderId =orderIdList.get(i);
            originalPrice += orderItemService.totalPriceOriginalOrders(orderId);
        }
        double revenueWeek = salesWeek - originalPrice;
        return revenueWeek;
    }

    @GetMapping("/getRevenueMonthStore")
    @ResponseBody
    public Double getRevenueMonthStore(){
        List<Integer> orderIdList = ordersRepository.findAllOrderMonthStore(1l);
        if (orderIdList == null || orderIdList.isEmpty()) {
            return 0.0; // Return 0 if no orders found
        }
        double salesMonth = ordersRepository.totalSalesOfMonthStore(1l);
        double originalPrice = 0;
        for (int i = 0; i < orderIdList.size(); i++){
            Integer orderId =orderIdList.get(i);
            originalPrice += orderItemService.totalPriceOriginalOrders(orderId);
        }
        double revenueMonth = salesMonth - originalPrice;
        return revenueMonth;
    }

    public List<Double> listRevenueOfThisWeek(){
        List<Object[]> result = ordersService.findOrderIdsByWeek();
        List<Double> salesData = ordersService.listTotalPriceOfThisWeek();
        Collections.reverse(salesData);
        List<Double> listRevenueThisWeek = new ArrayList<>();
        for (Object[] row : result) {
            String orderIds = (String) row[1];

            Optional<Orders> order =ordersRepository.findById(Long.valueOf(orderIds));

            String[] orderIdArray = orderIds.split(",");


            double totalOriginalOfDay = calculateTotalPrice(Arrays.asList(orderIdArray));
            double revenue = order.get().getTotalPrice() - (order.get().getCostShip() + totalOriginalOfDay);

            listRevenueThisWeek.add(revenue);
        }

        return listRevenueThisWeek;
    }

    public double calculateTotalPrice(List<String> orderIds) {
        double originalPrice = 0.0;
        for (String orderId : orderIds) {
            originalPrice += orderItemService.totalPriceOriginalOrders(Integer.parseInt(orderId));
        }
        return originalPrice;
    }
}
