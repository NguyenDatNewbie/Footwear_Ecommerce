package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.OrderItem;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Request.ContactRequest;
import com.reidshop.Reponsitory.OrderItemRepository;
import com.reidshop.Reponsitory.OrdersRepository;
import com.reidshop.Service.IEmailService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Random;
import java.util.Locale;
@Service
public class EmailServiceImpl implements IEmailService {
    @Autowired
    private JavaMailSender mailSender;
    @Autowired
    OrderItemRepository orderItemRepository;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    private String SENDER = "nguyenhuudat2710@gmail.com";
    public EmailServiceImpl(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    @Override
    public void sendCodeToEmail(String sendTo, String formattedNumber) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);

        helper.setFrom(SENDER);
        helper.setTo(sendTo);
        helper.setSubject("Reid Store");

        String htmlContent = "<html>\r\n"
                + "    <body>\r\n"
                + "    <div style='border-top: 4px solid transparent; border-image: linear-gradient(to right, blue, orangered, green) 1; border-image-slice: 1;'>\r\n"
                + "        <div>\r\n"
                + "            <img src='https://res.cloudinary.com/dfgichnzh/image/upload/v1701188615/ReidStore/logo_ssirms.png' alt='Logo' width='100px' height='40px'>\r\n"
                + "            <h2 style=\"margin: 5px 0px;\">Xác thực tài khoản</h2>\r\n"
                + "           \r\n"
                + "        </div>\r\n"
                + "        \r\n"
                + "         <p style=\"margin: 0;\">Mã xác thực của bạn là: <strong>" + formattedNumber + "</strong></p>\r\n"
                + "    </div>\r\n"
                + "    </body>\r\n"
                + "</html>";

        // Đặt nội dung email dưới dạng HTML
        helper.setText(htmlContent, true);

        mailSender.send(message);
    }
    @Override
    @Async("taskExecutor")
    public void sendForVendor(Orders orders) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        helper.setFrom(SENDER);
        helper.setTo(orders.getStore().getAccount().getEmail());
        helper.setSubject("[REID-STORE]"+" Vui lòng chuẩn bị cho đơn hàng "+orders.getId());
        //Lấy thông tin đơn hàng
        StringBuilder itemsHtml = new StringBuilder();
        int i = 1;
        List<OrderItem> orderItems = orderItemRepository.findAllItemByOrderId(orders.getId());
        for (OrderItem item : orderItems) {
            double sumPrice = item.getPrice() * item.getQuantity();

            itemsHtml.append("<tr>")
                    .append("<td style=\"font-weight: bold;\">").append(i + ". ").append(item.getInventory().getSize().getProduct().getName()).append("</td>")
                    .append("</tr>")
                    .append("<tr>")
                    .append("<td>Mã trong kho:</td>")
                    .append("<td>").append(item.getInventory().getId()).append("</td>")
                    .append("</tr>")
                    .append("<tr>")
                    .append("<td>Mẫu mã:</td>")
                    .append("<td>Kích thước: ").append(item.getInventory().getSize().getSize()).append("; Màu: ").append(item.getInventory().getColor().getColor_name()).append("</td>")
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
                    .append("<tr>")
                    .append("<td height=\"10\" style=\"font-size:1px;line-height:1px\"></td>")
                    .append("</tr>");
            i++;
        }
        String content = "<html>\n" +
                "<body>\n" +
                "    <div style=\"width: 100%; background-color: #f6f6f6\">\n" +
                "        <div style=\"margin: 0 30%; padding: 20px 0\">\n" +
                "            <div style=\"margin-bottom: 20px;text-align: center;\">\n" +
                "                <img src=\"https://res.cloudinary.com/dfgichnzh/image/upload/v1701188615/ReidStore/logo_ssirms.png\">\n" +
                "            </div>\n" +
                "            <div style=\"background-color: #fff; padding: 10px\" >\n" +
                "                <h4>Xin chào " + orders.getStore().getAccount().getAccountDetail().getName() +
                "</h4>\n" +
                "                <p>Đơn hàng #" + orders.getId()+
                " đã đủ hàng vui lòng chuẩn bị đơn cho khách và hoàn thành đơn hàng trước " +
                orders.getLimitReceiveAt() +
                " </p>\n"+
                        "<h4>THÔNG TIN ĐƠN HÀNG - DÀNH CHO NGƯỜI MUA</h4>"
                +       "<table width='100%' cellspacing='0' cellpadding='0' border='0' style=\"border-bottom: 1px solid #f2f2f2; padding-bottom: 10px\">"
                +        "<tbody>"
                +           "<tr>"
                +               "<td>Mã đơn hàng: </td>"
                +               "<td>#" + orders.getId() + "</td>"
                +           "</tr>"
                +           "<tr>"
                +               "<td>Ngày đặt hàng: </td>"
                +               "<td>" + orders.getCreatedAt() + "</td>"
                +           "</tr>"
                +        "</tbody>"
                +       "</table>"+
                       "<table width='100%' cellspacing='0' cellpadding='0' border='0' style=\"margin-top:15px\">"
                +        "<tbody>"
                +            itemsHtml.toString()
                +        "</tbody>"
                +       "</table>"+
                "            </div>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "</body>\n" +
                "</html>";

        helper.setText(content, true);
        mailSender.send(message);
    }

    @Override
    public void sendMessage(ContactRequest contactRequest) throws MessagingException{
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        helper.setFrom(contactRequest.getEmail());
        helper.setTo(SENDER);
        helper.setSubject("[REID] "+contactRequest.getSubject());
        String htmlContent = "<html>\r\n"
                + "    <body>\r\n"
                + "<div>\n"
                +        "    <p>Bạn: " +
                contactRequest.getName()
                +"</p>\n"
                +        "    <p>Bạn: " +
                contactRequest.getEmail()
                +"</p>\n"
                + "    <p>Nội dung" +
                "</p>\n"
                + "    <p>" +
                contactRequest.getMessage()+
                "</p>\n"
                + "</div>"
                + "    </body>\r\n"
                + "</html>";

        // Đặt nội dung email dưới dạng HTML
        helper.setText(htmlContent, true);
        mailSender.send(message);
    }

    @Override
    public void sendAnnouncementEmail(String recvEmail, String subject, String body) throws MessagingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
//        helper.setFrom(contactRequest.getEmail());
        helper.setTo(recvEmail);
        helper.setSubject("[REID] " + subject);
        String htmlContent = body;

        // Đặt nội dung email dưới dạng HTML
        helper.setText(htmlContent, true);
        mailSender.send(message);
    }


    @Override
    public String randomCode(){
        Random random = new Random();
        int randomNumber = random.nextInt(900000) + 100000;
        DecimalFormat decimalFormat = new DecimalFormat("000000");
        String formattedNumber = decimalFormat.format(randomNumber);
        return formattedNumber;
    }
}

