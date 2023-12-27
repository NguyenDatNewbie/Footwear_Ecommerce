package com.reidshop.Service;

import com.reidshop.Model.Request.ContactRequest;
import jakarta.mail.MessagingException;

public interface IEmailService {
    void sendCodeToEmail(String sendTo, String formattedNumber) throws MessagingException;

    void sendMessage(ContactRequest contactRequest) throws MessagingException;

    String randomCode();
}
