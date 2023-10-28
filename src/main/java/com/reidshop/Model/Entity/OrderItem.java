package com.reidshop.Model.Entity;

import lombok.Data;

import jakarta.persistence.*;

@Table
@Entity
@Data
public class OrderItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "orderItem_id")
    Long id;

    @ManyToOne
    @JoinColumn(name = "order_id")
    Orders order;

    @ManyToOne
    @JoinColumn(name = "inventory_id")
    Inventory inventory;

    @Column
    int quantity;

    @Column
    double price;

    @ManyToOne
    @JoinColumn(name = "stock_id")
    Stock stock;
}
