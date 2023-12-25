package com.reidshop.Controller.Vendor;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.AccountDetail;
import com.reidshop.Model.Entity.OrderItem;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Reponsitory.AccountDetailRepository;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.OrderItemRepository;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.Impl.OrdersServiceImpl;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

@Controller
@RequestMapping("/vendor/order")
public class ManagerOrderVendor {
    @Autowired
    OrdersRepository ordersRepository;
    @Autowired
    OrdersServiceImpl ordersService;
    @Autowired
    OrderItemRepository orderItemRepository;
    @Autowired
    IOrderItemService orderItemService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    AccountDetailRepository accountDetailRepository;
    @Autowired
    JwtService jwtService;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    @RequestMapping("")
    public String index(ModelMap modelMap, HttpServletRequest request){
//        String token = CookieHandle.getCookieValue(request, "token");
//        String email = jwtService.extractUsername(token);
//        Account account = accountRepository.findByEmail(email).orElse(null);

        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("ordersRepository", ordersRepository);

        //List All
        List<Orders> ordersAll = ordersRepository.findAllByStoreID(1L);
        //List by status
        List<Orders> orderWAIT = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.WAIT, 1l);
        List<Orders> orderPREPARE = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.PREPARE, 1l);
        List<Orders> orderALREADY = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.ALREADY, 1l);
        List<Orders> orderDELIVERY = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.DELIVERY, 1l);
        List<Orders> orderCOMPLETE = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.COMPLETE, 1l);
        List<Orders> orderCANCEL = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.CANCEL, 1l);

        modelMap.addAttribute("ordersAll", ordersAll);
        modelMap.addAttribute("orderWAIT", orderWAIT);
        modelMap.addAttribute("orderPREPARE", orderPREPARE);
        modelMap.addAttribute("orderALREADY", orderALREADY);
        modelMap.addAttribute("orderDELIVERY", orderDELIVERY);
        modelMap.addAttribute("orderCOMPLETE", orderCOMPLETE);
        modelMap.addAttribute("orderCANCEL", orderCANCEL);

        return "vendor/orderVendor";
    }

    @GetMapping("{orderId}")
    public ModelAndView detail(ModelMap model, @PathVariable("orderId") Long orderId){
        Optional<Orders> opt = ordersRepository.findById(orderId);

        if(opt.isPresent()){
            Orders order = opt.get();
            model.addAttribute("order", order);
            model.addAttribute("formatVND",formatVND);
            return new ModelAndView("vendor/orderDetail", model);
        }
        return new ModelAndView("redirect:/vendor/order", model);
    }

    @GetMapping("cancelOrder/{orderId}")
    public ModelAndView cancelOrder(ModelMap model, @PathVariable("orderId") Long orderId) {
        ordersService.UpdateOrderStatus(orderId, OrderStatus.CANCEL);
        return new ModelAndView("forward:/vendor/order", model);
    }

    @GetMapping("updateStatus/{orderId}")
    public ModelAndView updateOrderStatus(ModelMap model, @PathVariable("orderId") Long orderId) {
        Optional<Orders> opt = ordersRepository.findById(orderId);
        double priceOfOrder = orderItemService.totalPriceOfOrderId(orderId);
        boolean btnUpdateDisabled = false;
        if (opt.isPresent()){
            Orders order = opt.get();
            OrderStatus status = order.getStatus();
            ReceiveType receiveType = order.getReceiveType();
            if (status == OrderStatus.CANCEL || status == OrderStatus.COMPLETE){
                btnUpdateDisabled = true;
            }
            if (receiveType == ReceiveType.DELIVERY){
                switch (status) {
                    case WAIT -> ordersService.UpdateOrderStatus(orderId, OrderStatus.PREPARE);
                    case PREPARE -> ordersService.UpdateOrderStatus(orderId, OrderStatus.DELIVERY);
                    case DELIVERY -> {
                        ordersService.UpdateOrderStatus(orderId, OrderStatus.COMPLETE);
//                        double totalPrice = order.getCostShip() + priceOfOrder;
//                        order.setTotalPrice(totalPrice);
//                        ordersRepository.save(order);
                    }
                }
            } else {
                switch (status) {
                    case WAIT -> ordersService.UpdateOrderStatus(orderId, OrderStatus.ALREADY);
                    case ALREADY -> ordersService.UpdateOrderStatus(orderId, OrderStatus.COMPLETE);
                }
            }
            model.addAttribute("btnUpdateDisabled",btnUpdateDisabled);
            return new ModelAndView("forward:/vendor/order", model);
        }
        return new ModelAndView("redirect:/vendor/order", model);
    }

    @GetMapping("{accountId}/{ordered}")
    public ModelAndView orderDetail(ModelMap model, @PathVariable("accountId") Long accountId, @PathVariable("ordered") Long orderedID){
        Optional<AccountDetail> opt = accountDetailRepository.findByAccountId(accountId);
        Optional<Account> optAccount = accountRepository.findById(accountId);
        Optional<Orders> optOrder = ordersRepository.findById(orderedID);
        List<OrderItem> items = orderItemRepository.findAllItemByOrderId(orderedID);

        if(opt.isPresent()){
            AccountDetail accountDetail = opt.get();
            Account account = optAccount.get();
            Orders order = optOrder.get();
            model.addAttribute("accountDetail", accountDetail);
            model.addAttribute("account", account);
            model.addAttribute("order", order);
            model.addAttribute("formatVND",formatVND);
            model.addAttribute("orderItem",items);
            return new ModelAndView("vendor/orderDetail", model);
        }
        return new ModelAndView("redirect:/vendor/order", model);
    }
}
