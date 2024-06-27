package com.reidshop.Service;

import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Request.ContactRequest;
import jakarta.mail.MessagingException;

public interface IEmailService {
    void sendCodeToEmail(String sendTo, String formattedNumber) throws MessagingException;

    void sendForVendor(Orders orders) throws MessagingException;

    void sendMessage(ContactRequest contactRequest) throws MessagingException;

    void sendAnnouncementEmail(String toEmail, String subject, String body) throws MessagingException;

    String randomCode();
}
