package com.reidshop.Model.Entity;

import lombok.Data;

import jakarta.persistence.*;

@Entity
@Table
@Data
public class Size {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "size_id")
    Long id;

    @Column
    String size;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    Product product;
}
