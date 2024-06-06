package com.reidshop.Service.Impl;

import com.reidshop.Model.Request.ContactRequest;
import com.reidshop.Service.IEmailService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.util.Random;

@Service
public class EmailServiceImpl implements IEmailService {
    @Autowired
    private JavaMailSender mailSender;

    private String SENDER = "dang01635441895@gmail.com";
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

