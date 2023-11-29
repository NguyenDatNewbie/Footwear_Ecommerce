package com.reidshop.Service;

import jakarta.mail.MessagingException;

public interface IEmailService {
    void sendCodeToEmail(String sendTo, String formattedNumber) throws MessagingException;

    String randomCode();
}
