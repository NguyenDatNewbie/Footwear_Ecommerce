package com.reidshop.Entity;

import lombok.Data;

import javax.persistence.*;
import java.math.BigDecimal;

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
}
