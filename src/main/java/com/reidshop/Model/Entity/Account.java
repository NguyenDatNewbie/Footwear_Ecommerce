package com.reidshop.Model.Entity;

import lombok.Data;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Table
@Entity
@Data
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "account_id")
    Long id;

    @Column(unique = true,nullable = false)
    String email;

    @Column(nullable = false)
    String password;

    @Column
    String role;

    @OneToOne(mappedBy = "account")
    AccountDetail accountDetail;

    @OneToMany(mappedBy = "account")
    List<Orders> orders = new ArrayList<>();

    @OneToMany(mappedBy = "account")
    List<Evaluate> evaluates = new ArrayList<>();
}
