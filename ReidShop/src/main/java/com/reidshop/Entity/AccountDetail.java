package com.reidshop.Entity;

import lombok.Data;
import org.springframework.stereotype.Controller;

import javax.persistence.*;

@Table
@Data
@Entity
public class AccountDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "accountDetail_id")
    Long id;

    @Column
    String name;
    @Column
    String phone;
    @Column
    String address;
    @Column
    String image;

    @OneToOne
    @JoinColumn(name = "account_id")
    Account account;
}
