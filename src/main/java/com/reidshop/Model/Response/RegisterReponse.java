package com.reidshop.Model.Response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RegisterReponse {
    String name;
    String email;
    String password;
    String rePassword;
}
