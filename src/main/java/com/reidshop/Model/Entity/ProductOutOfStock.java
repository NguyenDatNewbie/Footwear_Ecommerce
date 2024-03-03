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

    @ManyToOne
    @JoinColumn(name = "size_id")
    Size size;

    @ManyToOne
    @JoinColumn(name ="color_id")
    Color color;

    @Column
    int quantity;

    @Column
    double price;

    @ManyToOne
    @JoinColumn(name = "order_id",referencedColumnName = "order_id")
    Orders orders;
}
