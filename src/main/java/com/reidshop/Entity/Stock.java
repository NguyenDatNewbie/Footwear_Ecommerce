package com.reidshop.Entity;

import lombok.Data;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Data
@Table
public class Stock {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "stock_id")
    Long id;

    @Column
    Date createdAt;

    @ManyToOne
    @JoinColumn(name = "store_id")
    Store store;

    @ManyToOne
    @JoinColumn(name = "supplier_id")
    Supplier supplier;
}
