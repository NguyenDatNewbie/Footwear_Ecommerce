package com.reidshop.Controller.Vendor;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.*;
import com.reidshop.Reponsitory.*;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.IOrdersService;
import com.reidshop.Service.IProductService;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
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
    @Autowired
    JwtService jwtService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    StoreRepository storeRepository;
    @Autowired
    AccountDetailRepository accountDetailRepository;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String index(ModelMap modelMap, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);

        AccountDetail accountDetail = accountDetailRepository.findAccountDetailByAccountId(account.getId());
        modelMap.addAttribute("accountDetail", accountDetail);

        Store store = storeRepository.searchAllByAccountId(account.getId());
        //Store ID
        Long storeID = store.getId();

        List<Category> categoryList = categoryRepository.findAll();
        List<Orders> ordersAll = ordersRepository.findAllByStoreID(storeID);
        modelMap.addAttribute("ordersAll", ordersAll);

        List<Double> listRevenue = listRevenueOfThisWeekByStore(storeID);

        modelMap.addAttribute("orderToday", ordersRepository.countTodayOrdersForStore(storeID)); //Count Order Today
        modelMap.addAttribute("saleToday", ordersRepository.totalSalesOfTodayStore(storeID));
        modelMap.addAttribute("listTotalPriceOfThisWeekStore", ordersRepository.listTotalPriceOfThisWeekStore(storeID));
        modelMap.addAttribute("accountDetail", accountDetail);
        modelMap.addAttribute("listRevenue", listRevenue);
        modelMap.addAttribute("revenueToday", getRevenueTodayStore(request));
        modelMap.addAttribute("categories",categoryList);
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("imageRepository",imageRepository);
        modelMap.addAttribute("ordersService", ordersService);
        modelMap.addAttribute("orderItemService", orderItemService);
        modelMap.addAttribute("ordersRepository", ordersRepository);
        return "vendor/home";
    }

    Long getStoreIDByRequest(HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);

        Store store = storeRepository.searchAllByAccountId(account.getId());
        //Store ID
        Long storeID = store.getId();
        return storeID;
    }

    @RequestMapping("/getTotalOrderStore")
    @ResponseBody
    public int countOrderVendor(HttpServletRequest request){
        int result = ordersRepository.countAllOrdersForStore(getStoreIDByRequest(request));
        return result;
    }

    @RequestMapping("/getTodayOrderStore")
    @ResponseBody
    public int countTodayOrder(HttpServletRequest request){
        int result = ordersRepository.countTodayOrdersForStore(getStoreIDByRequest(request));
        return result;
    }

    @RequestMapping("/getMonthOrderStore")
    @ResponseBody
    public int countMonthOrder(HttpServletRequest request){
        int result = ordersRepository.countMonthOrdersForStore(getStoreIDByRequest(request));
        return result;
    }

    //Sales
    @GetMapping("/getTotalSalesStore")
    @ResponseBody
    public Optional<Double> getTotalSalesStore(HttpServletRequest request) {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        Optional<Double> result = Optional.of(ordersRepository.saleAllByStoreId(getStoreIDByRequest(request)));

        if (!result.isPresent()) {
            // Trả về giá trị mặc định
            return Optional.of(0.0);
        }
        return result;
    }

    @GetMapping("/getTodaySalesStore")
    @ResponseBody
    public Optional<Double> getTodaySalesStore(HttpServletRequest request) {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        Optional<Double> result = Optional.of(ordersRepository.totalSalesOfTodayStore(getStoreIDByRequest(request)));

        if (!result.isPresent()) {
            // Trả về giá trị mặc định
            return Optional.of(0.0);
        }
        return result;
    }

    @GetMapping("/getMonthSalesStore")
    @ResponseBody
    public Optional<Double> getMonthSalesStore(HttpServletRequest request) {
        // Thực hiện logic để lấy giá trị mới từ dịch vụ hoặc địa điểm bạn muốn
        Optional<Double> result = Optional.of(ordersRepository.totalSalesOfMonthStore(getStoreIDByRequest(request)));

        if (!result.isPresent()) {
            // Trả về giá trị mặc định
            return Optional.of(0.0);
        }
        return result;
    }

    //Revenue
    @GetMapping("/getRevenueTodayStore")
    @ResponseBody
    public Double getRevenueTodayStore(HttpServletRequest request){
        List<Integer> orderIdList = ordersRepository.findAllOrderTodayStore(getStoreIDByRequest(request));
        if (orderIdList == null || orderIdList.isEmpty()) {
            return 0.0; // Return 0 if no orders found
        }
        double salesToday = ordersRepository.totalSalesOfTodayStore(getStoreIDByRequest(request));
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
    public Double getRevenueWeekStore(HttpServletRequest request){
        List<Integer> orderIdList = ordersRepository.findAllOrderMonthStore(getStoreIDByRequest(request));
        if (orderIdList == null || orderIdList.isEmpty()) {
            return 0.0; // Return 0 if no orders found
        }
        double salesWeek = ordersRepository.totalPriceOfThisWeekStore(getStoreIDByRequest(request));
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
    public Double getRevenueMonthStore(HttpServletRequest request){
        List<Integer> orderIdList = ordersRepository.findAllOrderMonthStore(getStoreIDByRequest(request));
        if (orderIdList == null || orderIdList.isEmpty()) {
            return 0.0; // Return 0 if no orders found
        }
        double salesMonth = ordersRepository.totalSalesOfMonthStore(getStoreIDByRequest(request));
        double originalPrice = 0;
        for (int i = 0; i < orderIdList.size(); i++){
            Integer orderId =orderIdList.get(i);
            originalPrice += orderItemService.totalPriceOriginalOrders(orderId);
        }
        double revenueMonth = salesMonth - originalPrice;
        return revenueMonth;
    }

    public double calculateTotalPrice(List<String> orderIds) {
        double originalPrice = 0.0;
        for (String orderId : orderIds) {
            originalPrice += orderItemService.totalPriceOriginalOrders(Integer.parseInt(orderId));
        }
        return originalPrice;
    }
    public List<Double> listRevenueOfThisWeekByStore(Long storeId){
        List<Object[]> listOrderID = ordersRepository.findOrderIdsByWeekOfStore(storeId);
        List<Double> listRevenueThisWeekOfStore = new ArrayList<>();
        for (Object[] row : listOrderID) {
            String orderIds = (String) row[1];

            Optional<Orders> order =ordersRepository.findById(Long.valueOf(orderIds));

            String[] orderIdArray = orderIds.split(",");
            System.out.println(orderIdArray);

            double totalOriginalOfDay = calculateTotalPrice(Arrays.asList(orderIdArray));
            double revenue = order.get().getTotalPrice() - (order.get().getCostShip() + totalOriginalOfDay);

            listRevenueThisWeekOfStore.add(revenue);
        }
        return listRevenueThisWeekOfStore;
    }
}
