package com.reidshop.Controller.Vendor;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Reponsitory.*;
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
    @Autowired
    StoreRepository storeRepository;
    @Autowired
    InventoryRepository inventoryRepository;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    @RequestMapping("")
    public String index(ModelMap modelMap, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);

        Store store = storeRepository.searchAllByAccountId(account.getId());
        //Store ID
        Long storeID = store.getId();

        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("ordersRepository", ordersRepository);

        AccountDetail accountDetail = accountDetailRepository.findAccountDetailByAccountId(account.getId());
        modelMap.addAttribute("accountDetail", accountDetail);

        //List All
        List<Orders> ordersAll = ordersRepository.findAllByStoreID(storeID);
        //List by status
        List<Orders> orderWAIT = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.WAIT, storeID);
        List<Orders> orderPREPARE = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.PREPARE, storeID);
        List<Orders> orderALREADY = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.ALREADY, storeID);
        List<Orders> orderDELIVERY = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.DELIVERY, storeID);
        List<Orders> orderCOMPLETE = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.COMPLETE, storeID);
        List<Orders> orderCANCEL = ordersRepository.findAllOrdersByStatusAndStoreId(OrderStatus.CANCEL, storeID);

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
        List<OrderItem> orderItemsByOrderID = orderItemRepository.findAllItemByOrderId(orderId);
        for (OrderItem orderItem : orderItemsByOrderID){
            Optional<Inventory> optionalInventory  = inventoryRepository.findById(orderItem.getInventory().getId()); //lấy invenroty theo oderitem
            if (optionalInventory.isPresent()){
                //Cộng thêm quantity vao Inventory
                Inventory inventory = optionalInventory.get();
                int quantityOrderItem = orderItem.getQuantity();
                int newQuantityInventory = quantityOrderItem + inventory.getQuantity();
                inventory.setQuantity(newQuantityInventory);
                inventoryRepository.save(inventory);    // cập nhật quantity
            }
        }
        ordersService.UpdateOrderStatus(orderId, OrderStatus.CANCEL);
        return new ModelAndView("redirect:/vendor/order", model);
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
