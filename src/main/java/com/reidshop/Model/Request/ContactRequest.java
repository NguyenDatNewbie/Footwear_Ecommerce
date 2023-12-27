package com.reidshop.Model.Request;

import lombok.Data;

@Data
public class ContactRequest {
    String email;
    String name;
    String subject;
    String message;
}
