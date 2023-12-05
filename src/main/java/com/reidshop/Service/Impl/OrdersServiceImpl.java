package com.reidshop.Service.Impl;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.PaymentType;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Model.Request.OrderCombineRequest;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.IOrdersService;
import com.reidshop.Service.IProductOutOfStockService;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
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
    IOrderItemService orderItemService;


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
    public void savePaymentReceive(OrderCombineRequest orderCombineRequest, ReceiveType receiveType, PaymentType paymentType, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);

        Orders orders = orderCombineRequest.getOrders();
        Account account = accountRepository.findByEmail(email).orElse(null);
        orders.setAccount(account);
        Store store = new Store();
        store.setId(orderCombineRequest.getStoreValid().get(0).getStore().getId());
        // Nhận tại store hoặc sản phẩm hết hàng
        if (receiveType==ReceiveType.STORE || orderCombineRequest.getStoreValid().get(0).getStatus()==0)
        {
            orders.setStore(store);
            orders.setTotalPrice(0);
            orders.setStatus(OrderStatus.WAIT);
            orders.setReceiveType(receiveType);
            orders.setPaymentType(paymentType);
            orders.setCreatedAt(Date.valueOf(LocalDate.now()));
            // Hết hàng status = 0 add 7 ngày còn hàng = 1
            orders.setLimitReceiveAt(Date.valueOf(LocalDate.now().plusDays(orderCombineRequest.getStoreValid().get(0).getStatus()==1 ? 1 : 7)));
            Orders complete = ordersRepository.save(orders);
            productOutOfStockService.save(orderCombineRequest.getCarts(),store.getId(),orderCombineRequest.getStoreValid().get(0).getStatus(),complete);
        }
        else{
            orders.setStore(store);
            orders.setTotalPrice(0);
            orders.setStatus(OrderStatus.PREPARE);
            orders.setReceiveType(ReceiveType.DELIVERY);
            orders.setCreatedAt(Date.valueOf(LocalDate.now()));
            Orders complete = ordersRepository.save(orders);
            complete.setTotalPrice(orderItemService.save(orderCombineRequest,orders));
            ordersRepository.save(complete);
        }

    }


}
