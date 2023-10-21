package com.reidshop.Entity;

import lombok.Data;

import jakarta.persistence.*;

@Data
@Entity
@Table
public class StockItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "stockItem_id")
    Long id;

    @ManyToOne
    @JoinColumn(name = "size_id")
    Size size;

    @Column
    int quantity;

    @Column
    double importPrice;

    @ManyToOne
    @JoinColumn(name = "stock_id")
    Stock stock;
}
