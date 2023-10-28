package com.reidshop.Model.Request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterRequest {
    @NotBlank(message = "Vui lòng nhập tên")
    String name;

    @NotBlank(message = "Vui lòng nhập email")
    @Email(message = "Phải đúng định dạng email @gmail.com")
    String email;

    @NotEmpty(message = "Vui lòng nhập password")
    @Size(min = 8,max = 16,message = "Password từ 8-16 ký tự")
    String password;

    @NotBlank(message = "Vui lòng nhập lại password")
    String rePassword;
}
