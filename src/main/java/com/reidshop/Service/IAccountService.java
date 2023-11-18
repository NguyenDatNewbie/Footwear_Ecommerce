package com.reidshop.Service;

import com.reidshop.Model.Request.RegisterRequest;

public interface IAccountService {
    Boolean save(RegisterRequest register);
}
