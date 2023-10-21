package com.reidshop.Entity;

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

    @OneToMany(mappedBy = "store")
    List<Inventory> inventories = new ArrayList<>();

    @OneToMany(mappedBy = "store")
    List<Orders> orders = new ArrayList<>();
}
