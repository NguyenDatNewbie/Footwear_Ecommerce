package com.reidshop.Model.Entity;

import lombok.Data;

import jakarta.persistence.*;

@Table
@Entity
@Data
public class Inventory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "inventory_id")
    Long id;

    @Column
    int quantity;

    @ManyToOne
    @JoinColumn(name = "size_id")
    Size size;

    @ManyToOne
    @JoinColumn(name = "store_id")
    Store store;

    @Column
    double importPrice;

    @ManyToOne
    @JoinColumn(name = "stock_id")
    Stock stock;
}
