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
import com.reidshop.Service.IEmailService;
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
    @Autowired
    IEmailService emailService;

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
//                        double totalPrice = (order.getDelivery()==null ? 0 :order.getDelivery().getCost()) + priceOfOrder;
//                        order.setTotalPrice(totalPrice);
//                        ordersRepository.save(order);
                    }
                }
            } else {
                switch (status) {
                    case WAIT -> {
                        //Cập nhật order
                        ordersService.UpdateOrderStatus(orderId, OrderStatus.ALREADY);

                        //Gửi mail cho người dùng đến nhận
                        try {
                            //Email nhận
                            String recvEmail = order.getAccount().getEmail();
                            //Chủ đề
                            String subject = "Đơn hàng của quý khách đã hoàn tất và sẵn sàng để giao";

                            List<OrderItem> items = orderItemRepository.findAllItemByOrderId(order.getId());

                            //Lấy thông tin đơn hàng
                            StringBuilder itemsHtml = new StringBuilder();
                            int i = 1;
                            for (OrderItem item : items) {
                                double sumPrice = item.getPrice() * item.getQuantity();
                                itemsHtml.append("<tr>")
                                        .append("<td style='margin-top: 5px; margin-bottom: 5px'>").append("<img src=\"")
                                        .append(item.getInventory().getSize().getProduct().getImages().get(0).getImg())
                                        .append("\" alt=\"Hình ảnh sản phẩm\" style=\"width: 100px; height: 100px;\"></td>")
                                        .append("</tr>")
                                        .append("<tr>")
                                        .append("<td>").append(i + ". ").append(item.getInventory().getSize().getProduct().getName()).append("</td>")
                                        .append("</tr>")
                                        .append("<tr>")
                                        .append("<td>Mẫu mã:</td>")
                                        .append("<td>Size ").append(item.getInventory().getSize().getSize()).append("</td>")
                                        .append("</tr>")
                                        .append("<tr>")
                                        .append("<td>Số lượng:</td>")
                                        .append("<td>").append(item.getQuantity()).append("</td>")
                                        .append("</tr>")
                                        .append("<tr>")
                                        .append("<td>Giá:</td>")
                                        .append("<td>").append(formatVND.format(item.getPrice())).append("</td>")
                                        .append("</tr>")
                                        .append("<tr>")
                                        .append("<td>Thành tiền:</td>")
                                        .append("<td>").append(formatVND.format(sumPrice)).append("</td>")
                                        .append("</tr>")
                                        .append("<tr style='background-color: gray;'>")
                                        .append("<td height=\"1\" style=\"font-size:1px;line-height:1px\"></td>")
                                        .append("</tr>");
                                i++;
                            }
                            //Nội dung của email
                            String body = "<html>\r\n"
                                    + "<body>\r\n" +
                                    "<div style=\"justify-content: center; display:flex;\">\r\n" +
                                    "<div>\r\n"
                                    +        "<img src='https://res.cloudinary.com/dhmeeqkgr/image/upload/v1717684779/logo_a6zddc.png' alt='Logo' width='100px' height='40px' style='display: block; margin: auto'>\r\n"
                                    +        "<p>Xin chào " + order.getName() + ", </p>\n"
                                    +        "<p>Đơn hàng " + "<span> #" + order.getId() + "</span>" + " của bạn đã được chuẩn bị xong.</p>\n"
                                    +        "<p>Vui lòng đến của hàng của REID Shop tại " + order.getStore().getDepartment() +  " để thanh toán và nhận hàng.</p>\n"
                                    +        "<h4>THÔNG TIN ĐƠN HÀNG - DÀNH CHO NGƯỜI MUA</h4>"
                                    +       "<table width='500' cellspacing='0' cellpadding='0' border='0'>"
                                    +        "<tbody>"
                                    +           "<tr>"
                                    +               "<td>Mã đơn hàng: </td>"
                                    +               "<td>#" + order.getId() + "</td>"
                                    +           "</tr>"
                                    +           "<tr>"
                                    +               "<td>Ngày đặt hàng: </td>"
                                    +               "<td>" + order.getCreatedAt() + "</td>"
                                    +           "</tr>"
                                    +        "</tbody>"
                                    +       "</table>"
                                    +        "<p></p>\n"
                                    +       "<table width='500' cellspacing='0' cellpadding='0' border='0' style='  border-collapse: separate; border-spacing: 0 5px;'>"
                                    +        "<tbody>"
                                    +            itemsHtml.toString()
                                    +        "</tbody>"
                                    +       "</table>"
                                    +        "<p></p>\n"
                                    +       "<table width='500' cellspacing='0' cellpadding='0' border='0'>"
                                    +        "<tbody>"
                                    +           "<tr>"
                                    +               "<td>Tổng tiền: </td>"
                                    +               "<td>" + formatVND.format(order.getTotalPrice()) + "</td>"
                                    +           "</tr>"
                                    +           "<tr>"
                                    +               "<td>Ngày đặt hàng: </td>"
                                    +               "<td>" + order.getCreatedAt() + "</td>"
                                    +           "</tr>"
                                    +        "</tbody>"
                                    +       "</table>"
                                    +        "<p>Nếu bạn có điều gì không hài lòng, xin hãy liên hệ với chúng tôi!</p>\n"
                                    +        "<p>Chúc bạn luôn có những trải nghiệm tuyệt vời khi mua sắm tại REID Shop.</p>\n"
                                    +        "<p>Trân trọng,</p>\n"
                                    +        "<p>Đội ngủ REID Shop</p>\n"
                                    + "</div>"
                                    + "</div>"
                                    + "</body>\r\n"
                                    + "</html>";

                            //Gửi email để thông báo đến người nhận
                            emailService.sendAnnouncementEmail(recvEmail, subject, body);

                        }catch (Exception exception) {
                            return new ModelAndView("vendor/order");
                        }
                    }
                    case ALREADY -> ordersService.UpdateOrderStatus(orderId, OrderStatus.COMPLETE);
                }
            }
            model.addAttribute("btnUpdateDisabled",btnUpdateDisabled);
            return new ModelAndView("forward:/admin/order", model);
        }
        return new ModelAndView("redirect:/admin/order", model);
    }
}
