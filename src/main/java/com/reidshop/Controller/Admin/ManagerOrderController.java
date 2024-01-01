package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.AccountDetail;
import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.OrderItem;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.PaymentType;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Reponsitory.InventoryRepository;
import com.reidshop.Reponsitory.OrderItemRepository;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Reponsitory.ProductRepository;
import com.reidshop.Service.IOrderItemService;
import com.reidshop.Service.Impl.OrdersServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

@Controller
@RequestMapping("/admin/order")
public class ManagerOrderController {
    @Autowired
    OrdersRepository ordersRepository;

    @Autowired
    OrdersServiceImpl ordersService;
    @Autowired
    OrderItemRepository orderItemRepository;
    @Autowired
    IOrderItemService orderItemService;
    @Autowired
    InventoryRepository inventoryRepository;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String index(ModelMap modelMap){
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("ordersRepository", ordersRepository);
        List<Orders> orders = ordersRepository.findAll();
        modelMap.addAttribute("orders", orders);

        return "admin/order";
    }

    @GetMapping("{orderId}")
    public ModelAndView detail(ModelMap model, @PathVariable("orderId") Long orderId){
        Optional<Orders> opt = ordersRepository.findById(orderId);

        if(opt.isPresent()){
            Orders order = opt.get();
            model.addAttribute("order", order);
            model.addAttribute("formatVND",formatVND);
            return new ModelAndView("admin/orderDetail", model);
        }
        return new ModelAndView("redirect:/admin/order", model);
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
        return new ModelAndView("forward:/admin/order", model);
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
                        double totalPrice = order.getCostShip() + priceOfOrder;
                        order.setTotalPrice(totalPrice);
                        ordersRepository.save(order);
                    }
                }
            } else {
                switch (status) {
                    case WAIT -> ordersService.UpdateOrderStatus(orderId, OrderStatus.ALREADY);
                    case ALREADY -> ordersService.UpdateOrderStatus(orderId, OrderStatus.COMPLETE);
                }
            }
            model.addAttribute("btnUpdateDisabled",btnUpdateDisabled);
            return new ModelAndView("forward:/admin/order", model);
        }
        return new ModelAndView("redirect:/admin/order", model);
    }
}
