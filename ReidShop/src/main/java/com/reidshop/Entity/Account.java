package com.reidshop.Entity;

import lombok.Data;

import javax.persistence.*;

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
    @Column
    String password;
    @Column
    byte role;
}
