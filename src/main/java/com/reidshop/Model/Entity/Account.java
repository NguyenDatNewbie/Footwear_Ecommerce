package com.reidshop.Model.Entity;

import com.reidshop.Model.Enum.ROLE;
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
    @Enumerated(EnumType.STRING)
    ROLE role;

    @OneToOne(mappedBy = "account")
    AccountDetail accountDetail;
}
