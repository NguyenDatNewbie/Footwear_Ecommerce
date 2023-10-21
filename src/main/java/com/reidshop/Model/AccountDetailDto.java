package com.reidshop.Model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AccountDetailDto {

    @NotEmpty(message = "Không được để trống")
    String name;

    @Size(min = 10 ,max = 12,message = "Vui lòng điền đúng định dạng số điện thoại")
    String phone;

    @NotEmpty(message = "Không được để trống")
    String address;
}
