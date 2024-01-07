package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.AccountDetail;
import com.reidshop.Model.Enum.ROLE;
import com.reidshop.Model.Request.RegisterRequest;
import com.reidshop.Reponsitory.AccountDetailRepository;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Service.IAccountService;
import com.reidshop.dto.GoogleUserInfo;
import com.reidshop.security.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AccountServiceImpl implements IAccountService {
    @Autowired
    AuthenticationManager authenticationManager;
    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    JwtService jwtService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    AccountDetailRepository accountDetailRepository;

    @Override
    public Account loginWithGoogle(GoogleUserInfo googleUserInfo){
        Account account = accountRepository.findByEmail(googleUserInfo.getEmail()).orElse(new Account());
        if(account.getEmail()==null)
        {
            account.setEmail(googleUserInfo.getEmail());
            account.setPassword(passwordEncoder.encode("google"));
            account.setRole(ROLE.USER);
            accountRepository.save(account);
            AccountDetail accountDetail = new AccountDetail();
            accountDetail.setAccount(account);
            accountDetail.setName(googleUserInfo.getName());
            accountDetail.setImage(googleUserInfo.getPicture());
            accountDetailRepository.save(accountDetail);
        }
        return account;
    }

    @Override
    public Boolean save(RegisterRequest request){
        Account account = new Account();
        account.setEmail(request.getEmail());
        account.setPassword(passwordEncoder.encode(request.getPassword()));
        account.setRole(ROLE.USER);
        try{
            accountRepository.save(account);
            AccountDetail accountDetail = new AccountDetail();
            accountDetail.setAccount(account);
            accountDetail.setName(request.getName());

            accountDetailRepository.save(accountDetail);
            return true;
        }catch (Exception exception){
            System.out.println(exception);
            return false;
        }
    }
}
