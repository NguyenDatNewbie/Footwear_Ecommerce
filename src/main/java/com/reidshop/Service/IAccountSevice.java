package com.reidshop.Service;

import com.reidshop.Model.AccountDetailDto;
import com.reidshop.Model.AccountDto;

public interface IAccountSevice {
    void save(AccountDto accountDto, AccountDetailDto accountDetailDto, byte role);
}
