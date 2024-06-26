package com.reidshop.Model.Entity;

import lombok.Data;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Table
@Entity
@Data
public class Store {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "store_id")
    Long id;

    @Column
    String department;

    @OneToOne
    @JoinColumn(name="manager_id")
    Account account;

}
