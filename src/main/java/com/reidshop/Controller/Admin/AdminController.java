package com.reidshop.Controller.Admin;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.PaymentType;
import com.reidshop.Reponsitory.CategoryRepository;
import com.reidshop.Reponsitory.ImageRepository;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.IOrdersService;
import com.reidshop.Service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.Console;
import java.sql.Date;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.Month;
import java.time.format.DateTimeFormatter;
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
    public String index(ModelMap modelMap) throws JsonProcessingException {
        List<Integer> listMonthRecently = getList5MonthRecently(4);
        List<String> listMonthNames = convertToMonthNames(listMonthRecently);

        modelMap.addAttribute("listMonth", listMonthNames);

        // Chuyển đổi danh sách thành chuỗi JSON
        ObjectMapper objectMapper = new ObjectMapper();
        String labelsJson = objectMapper.writeValueAsString(listMonthNames);

        modelMap.addAttribute("labels", labelsJson);
        modelMap.addAttribute("listRevenue", listRevenue5Month());
        modelMap.addAttribute("numRecv", ordersRepository.countOrdersByPaymentType(PaymentType.RECEIVE));
        modelMap.addAttribute("numPayPal", ordersRepository.countOrdersByPaymentType(PaymentType.PAYPAL));
        modelMap.addAttribute("numMOMO", ordersRepository.countOrdersByPaymentType(PaymentType.MOMO));
        modelMap.addAttribute("numVNpay", ordersRepository.countOrdersByPaymentType(PaymentType.VNPAY));
        modelMap.addAttribute("waitOrders", ordersRepository.countOrdersByStatus(OrderStatus.WAIT));
        modelMap.addAttribute("preOrders", ordersRepository.countOrdersByStatus(OrderStatus.PREPARE));
        modelMap.addAttribute("readyOrders", ordersRepository.countOrdersByStatus(OrderStatus.ALREADY));
        modelMap.addAttribute("deliOrders", ordersRepository.countOrdersByStatus(OrderStatus.DELIVERY));
        modelMap.addAttribute("completeOrders", ordersRepository.countOrdersByStatus(OrderStatus.COMPLETE));
        modelMap.addAttribute("cancelOrders", ordersRepository.countOrdersByStatus(OrderStatus.CANCEL));
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
            Integer orderId = orderIdList.get(i);
            Optional<Orders> order = ordersRepository.findById(Long.valueOf(orderId));
            originalPrice += (orderItemService.totalPriceOriginalOrders(orderId) + order.get().getVoucherValue());
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
            Optional<Orders> order = ordersRepository.findById(Long.valueOf(orderId));
            originalPrice += (orderItemService.totalPriceOriginalOrders(orderId) + order.get().getVoucherValue());
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
            Optional<Orders> order = ordersRepository.findById(Long.valueOf(orderId));
            originalPrice += (orderItemService.totalPriceOriginalOrders(orderId) + order.get().getVoucherValue());
        }
        double revenueThisMonth = salesThisMonth - originalPrice;
        return revenueThisMonth;
    }

    public List<Double> listRevenue5Month() {
        List<Double> List_Revenue = new ArrayList<>();  //danh sách 5 tháng gần đây

        List<Integer> listMonthRecently = getList5MonthRecently(4);  //Hàm lấy 5 tháng gần nhất

        for (Integer month : listMonthRecently){
            List_Revenue.add(getRevenueOfMonth(month));
        }

        return List_Revenue;
    }

    //Funtion tính lợi nhuận theo tháng
    public Double getRevenueOfMonth(int month){
        //List order of this month
        List<Integer> listId = ordersRepository.findOrdersByMonth(month);

        if (listId == null || listId.isEmpty())
            return 0.0;

        //Doanh số của 1 tháng
        double salesOfMonth = ordersRepository.totalSalesOfMonth(month);

        double originalPrice = 0;

        //Tính số tiền vốn của các hóa đơn bán ra trong 1 tuần
        for (int i = 0; i < listId.size(); i++){
            Integer orderId = listId.get(i);
            Optional<Orders> order = ordersRepository.findById(Long.valueOf(orderId));
            originalPrice += (orderItemService.totalPriceOriginalOrders(orderId) + order.get().getVoucherValue());
        }
        double revenueThisMonth = salesOfMonth - originalPrice;
        return revenueThisMonth;
    }

    //Hàm trả về danh sách 5 tháng gần nhất
    List<Integer> getList5MonthRecently(int n){
        //Lấy danh sách 5 tháng gần đây
        LocalDate currentDate = LocalDate.now();
        int currentMonth = currentDate.getMonthValue();
        List<Integer> List_5_Months = new ArrayList<>();  //danh sách 5 tháng gần đây

        for (int i = n; i >= 1; i--) {
            // Tính toán tháng trước đó
            int previousMonth = currentMonth - i;
            if (previousMonth <= 0) {
                previousMonth += 12;
            }
            List_5_Months.add(previousMonth); // Thêm vào danh sách
        }
        List_5_Months.add(currentMonth);
        //Kết thúc việc lấy 5 tháng --> List_5_Months
        return List_5_Months;
    }

    List<String> convertToMonthNames(List<Integer> months) {
        List<String> monthNames = new ArrayList<>();
        for (int month : months) {
            monthNames.add(Month.of(month).name());
        }
        System.out.println(monthNames);
        return monthNames;
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
                Optional<Orders> order = ordersRepository.findById(Long.valueOf(orderId));
                System.out.println(orderId);
                double totalOriginalOfOrder = orderItemService.totalPriceOriginalOrders(Integer.parseInt(orderId));
                System.out.println(totalOriginalOfOrder);

                revenue += (order.get().getTotalPrice() - ((order.get().getDelivery()==null ? 0 :order.get().getDelivery().getCost()) + totalOriginalOfOrder));
            }
            listRevenueThisWeek.add(revenue);
        }

        return listRevenueThisWeek;
    }

}
