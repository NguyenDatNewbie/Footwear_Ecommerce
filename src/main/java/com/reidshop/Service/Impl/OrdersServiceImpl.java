package com.reidshop.Service.Impl;

import com.nimbusds.openid.connect.sdk.assurance.evidences.Voucher;
import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.PaymentType;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Model.Enum.VoucherType;
import com.reidshop.Model.Request.OrderCombineRequest;
import com.reidshop.Reponsitory.*;
import com.reidshop.Service.Handle.DistanceService;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.IOrdersService;
import com.reidshop.Service.IProductOutOfStockService;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.List;

@Service
public class OrdersServiceImpl implements IOrdersService {
    @Autowired
    OrdersRepository ordersRepository;

    @Autowired
    JwtService jwtService;

    @Autowired
    AccountRepository accountRepository;

    @Autowired
    IProductOutOfStockService productOutOfStockService;
    @Autowired
    ProductOutOfStockRepository productOutOfStockRepository;

    @Autowired
    IOrderItemService orderItemService;
    @Autowired
    DistanceService distanceService;
    @Autowired
    EvaluateRepository evaluateRepository;
    @Autowired
    VoucherRepository voucherRepository;
    @Autowired
    DeliveryRepository deliveryRepository;


    public OrdersServiceImpl(OrdersRepository ordersRepository) {
        this.ordersRepository = ordersRepository;
    }
    @Override
    public int countAllOrders() {
        return ordersRepository.countAllOrders();
    }

    @Override
    public Long countOrdersCreatedToday() {
        return ordersRepository.countOrdersCreatedToday();
    }

    @Override
    public Long countOrdersInCurrentMonth() {
        return ordersRepository.countOrdersInCurrentMonth();
    }

    @Override
    public Long countOrdersInCurrenYear() {
        return ordersRepository.countOrdersInCurrenYear();
    }

    @Override
    public double revenueAll() {
        return ordersRepository.revenueAll();
    }

    @Override
    public double totalSalesOfToday() {
        return ordersRepository.totalSalesOfToday();
    }

    @Override
    public double totalSalesOfThisMonth() {
        return ordersRepository.totalSalesOfThisMonth();
    }

    @Override
    public double totalSalesOfThisYear() {
        return ordersRepository.totalSalesOfThisYear();
    }

    @Override
    public Long countOrdersOfMonth(int year, int month) {
        return ordersRepository.countOrdersOfMonth(year, month);
    }

    @Override
    public Long countOrderByDate(Date date) {
        return ordersRepository.countOrderByDate(date);
    }

    @Override
    public List<Integer> findAllOrderToday() {
        List<Integer> orderIdList = ordersRepository.findAllOrderToday();
        return orderIdList;
    }

    @Override
    public List<Integer> findAllOrderOfThisWeek() {
        List<Integer> listIdOfWeek = ordersRepository.findAllOrderOfThisWeek();
        return listIdOfWeek;
    }

    @Override
    public double totalPriceOfThisWeek() {
        return ordersRepository.totalPriceOfThisWeek();
    }

    @Override
    public List<Integer> findAllOrderOfThisMonth() {
        List<Integer> listIdOfMonth = ordersRepository.findAllOrderOfThisMonth();
        return listIdOfMonth;
    }

    @Override
    public List<Double> listTotalPriceOfThisWeek() {
        List<Double> listTotalPriceThisWeek = ordersRepository.listTotalPriceOfThisWeek();
        return listTotalPriceThisWeek;
    }

    @Override
    public List<Object[]> findOrderIdsByWeek() {
        return ordersRepository.findOrderIdsByWeek();
    }

    @Override
    public void savePayment(OrderCombineRequest orderCombineRequest, ReceiveType receiveType, PaymentType paymentType, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Orders orders = orderCombineRequest.getOrders();
        Vourcher voucher = voucherRepository.findByVoucherCode(orderCombineRequest.getVoucher()).orElse(null);
        orders.setVourcher(voucher);

        Account account = accountRepository.findByEmail(email).orElse(null);
        orders.setAccount(account);
        Store store = new Store();
        store.setId(orderCombineRequest.getStoreValid().get(0).getStore().getId());
        double totalPrice = 0.0;
        Orders complete;
        // Nhận tại store hoặc sản phẩm hết hàng
        if (receiveType==ReceiveType.STORE || orderCombineRequest.getStoreValid().get(0).getStatus()==0)
        {
            orders.setStore(store);
            orders.setTotalPrice(0);
            orders.setStatus(OrderStatus.WAIT);
            orders.setReceiveType(receiveType);
            orders.setPaymentType(paymentType);
            orders.setDelivery(null);
            if(receiveType != ReceiveType.STORE) {
                Delivery delivery = deliveryRepository.save(orderCombineRequest.getOrders().getDelivery());
                orders.setDelivery(delivery);
            }
            orders.setCreatedAt();
            // Hết hàng status = 0 add 7 ngày còn hàng = 1
            orders.setLimitReceiveAt(java.sql.Timestamp.valueOf(LocalDateTime.now().plusDays(orderCombineRequest.getStoreValid().get(0).getStatus()==1 ? 1 : 7)));
            complete = ordersRepository.save(orders);
            totalPrice = productOutOfStockService.save(orderCombineRequest.getCarts(),store.getId(),orderCombineRequest.getStoreValid().get(0).getStatus(),complete);
            complete.setTotalPrice(totalPrice);
        }
        else{
            Delivery delivery = deliveryRepository.save(orderCombineRequest.getOrders().getDelivery());
            orders.setDelivery(delivery);
            orders.setStore(store);
            orders.setTotalPrice(0);
            orders.setStatus(OrderStatus.PREPARE);
            orders.setReceiveType(ReceiveType.DELIVERY);
            orders.setCreatedAt();
            complete = ordersRepository.save(orders);
            totalPrice = orderItemService.save(orderCombineRequest,orders);
            complete.setTotalPrice(totalPrice);
        }

        if(voucher==null)
            complete.setVoucherValue(0.0);
        else
        {
            if(receiveType==ReceiveType.STORE && voucher.getVoucherType().equals(VoucherType.FREE_SHIPPING))
                complete.setVoucherValue(0.0);
            else {
                complete.setVoucherValue(calVoucherValue(totalPrice,voucher));
                voucher.setQuantity(voucher.getQuantity()-1);
                voucherRepository.save(voucher);
            }
        }
        ordersRepository.save(complete);
    }

    double calVoucherValue(double priceOriginal, Vourcher voucher){
        if(voucher.getMinimumValue()>priceOriginal)
            return 0;
        if(voucher.getVoucherType().equals(VoucherType.DISCOUNT_PERCENT))
            return priceOriginal * voucher.getDiscountValue() / 100.0;
        else if(voucher.getVoucherType().equals(VoucherType.DISCOUNT_DIRECT))
            return voucher.getDiscountValue();
        return 0;
    }
    @Override
    public void rateSave(Evaluate evaluate, long orderId){
        Orders orders = ordersRepository.findById(orderId).orElse(null);
        if(orders!=null)
        {
            for (OrderItem item: orders.getOrderItems()) {
                Product product = item.getInventory().getSize().getProduct();
                Evaluate newEvaluate = new Evaluate();
                newEvaluate.setAccount(evaluate.getAccount());
                newEvaluate.setRate(evaluate.getRate());
                newEvaluate.setComment(evaluate.getComment());
                newEvaluate.setCreatedAt(Date.valueOf(LocalDate.now()));
                newEvaluate.setProduct(product);
                newEvaluate.setOrders(orders);
                evaluateRepository.save(newEvaluate);
            }
        }
    }
    @Override
    public void UpdateOrderStatus(Long orderId, OrderStatus newStatus) {
        Orders order = ordersRepository.findById(orderId).orElseThrow();
        order.setStatus(newStatus);
        ordersRepository.save(order);
    }

    @Override
    public double totalSalesOfTodayStore(Long storeId) {
        try {
            Long result = (long) ordersRepository.totalSalesOfTodayStore(1L);
            return result;
        } catch (Exception e) {
            // Xử lý exception nếu có
            e.printStackTrace(); // In ra stack trace để kiểm tra lỗi
            return 0;
        }
    }

    @Override
    public List<Orders> findOrdersByAccountAndStatus(Long id, String status){
        List<Orders> orders = ordersRepository.findOrdersByAccountAndStatus(id,OrderStatus.valueOf(status));
        return orders;
    }

    @Override
    public List<Orders> findOrderByAccountQuery(Long accountId, String keyword){
        List<Orders> orders = ordersRepository.findOrdersByAccount(accountId);
        List<Orders> result = ordersRepository.findBySearchQuery(keyword,accountId);
        for(Orders order: orders){
            if(result.contains(order))
                continue;
            boolean exist = false;
            for (OrderItem orderItem: order.getOrderItems()) {
                if(orderItem.getInventory().getSize().getProduct().getName().toLowerCase().contains(keyword.toLowerCase()))
                {
                    exist = true;
                    break;
                }
            }
            if(exist==false)
            {
                List<ProductOutOfStock> productOutOfStocks = productOutOfStockRepository.findByOrderId(order.getId());
                for (ProductOutOfStock p: productOutOfStocks)
                    if(p.getSize().getProduct().getName().toLowerCase().contains(keyword.toLowerCase()))
                    {
                        exist = true;
                        break;
                    }
            }
            if(exist)
                result.add(order);
        }
        return result;
    }
}
