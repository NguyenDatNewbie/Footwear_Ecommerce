package com.reidshop.Model.Request;

import lombok.Data;

@Data
public class PasswordRequest {
    String email;
    String password;
    String rePassword;
    String currentPassword;
}
