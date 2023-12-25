package com.reidshop.security;


import com.reidshop.Model.Entity.Account;
import com.reidshop.Reponsitory.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class UserServiceUserDetails implements UserDetailsService {
    @Autowired
    AccountRepository repository;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Account account = repository.findByEmail(username).orElseThrow(() -> new UsernameNotFoundException("User not found"));
        return org.springframework.security.core.userdetails.User
                .withUsername(account.getEmail())
                .password(account.getPassword())
                .roles(String.valueOf(account.getRole()))
                .build();
    }

}
