package com.reidshop.Service;

import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Request.RegisterRequest;
import com.reidshop.dto.GoogleUserInfo;

public interface IAccountService {
    Account loginWithGoogle(GoogleUserInfo googleUserInfo);

    Boolean save(RegisterRequest register);
}
