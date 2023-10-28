package com.reidshop.Service;

import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.AccountDetail;
import com.reidshop.Model.Request.RegisterRequest;

public interface IAccountSevice {
    Boolean save(RegisterRequest register);
}
