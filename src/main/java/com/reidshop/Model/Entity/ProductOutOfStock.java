package com.reidshop.Model.Entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table
public class ProductOutOfStock {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "wait_import_id")
    Long id;

    @Column
    Long productId;

    @Column
    String size;

    @Column
    int quantity;

    @Column
    double price;

    @ManyToOne
    @JoinColumn(name = "order_id",referencedColumnName = "order_id")
    Orders orders;
}
