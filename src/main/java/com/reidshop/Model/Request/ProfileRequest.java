package com.reidshop.Model.Request;

import jakarta.persistence.Column;
import lombok.Data;

@Data
public class ProfileRequest {
    String email;
    String name;
    String phone;
    String address;
}
