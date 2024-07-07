package com.reidshop.Model.Entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.Data;

import jakarta.persistence.*;

import java.util.ArrayList;

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
    @JoinColumn(name = "color_id")
    Color color;

    @ManyToOne
    @JoinColumn(name = "store_id")
    Store store;

    @Column
    double importPrice;

    @Column
    Integer importQuantity;

    @ManyToOne()
    @JoinColumn(name = "stock_id")
    Stock stock;

}
