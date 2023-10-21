package com.reidshop.Model;

import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AccountDto {

    @NotEmpty(message = "Không được để trống")
    @Email(message = "Phải đúng định dạng email")
    String email;

    @Size(min = 8, max = 16,message = "Password phải từ 8-16 ký tự")
    String password;
}
