package com.reidshop.Service.Impl;

import com.reidshop.Entity.Account;
import com.reidshop.Entity.AccountDetail;
import com.reidshop.Model.AccountDetailDto;
import com.reidshop.Model.AccountDto;
import com.reidshop.Reponsitory.AccountDetailRepository;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Service.IAccountSevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AccountServiceImpl implements IAccountSevice {
    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    AccountDetailRepository accountDetailRepository;


    @Override
    public void save(AccountDto accountDto, AccountDetailDto accountDetailDto, byte role){
        Account account = new Account();
        account.setEmail(accountDto.getEmail());
        account.setPassword(passwordEncoder.encode(accountDto.getPassword()));
        account.setRole(role);


        try{
            accountRepository.save(account);
            AccountDetail accountDetail = new AccountDetail();
            if(isExistAccount(account.getId(),accountDetail,accountDetailDto))
                accountDetailRepository.save(accountDetail);
        }catch (Exception exception){
            System.out.println(exception);
        }
    }

    Boolean isExistAccount(Long id,AccountDetail accountDetail, AccountDetailDto dto){
        Account account = accountRepository.findByAccountId(id);
        if(account!=null){
            accountDetail.setAccount(account);
            accountDetail.setName(dto.getName());
            accountDetail.setPhone(dto.getPhone());
            accountDetail.setAddress(dto.getAddress());
            return true;
        }
        return false;
    }
}
