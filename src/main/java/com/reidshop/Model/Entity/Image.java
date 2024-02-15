package com.reidshop.Model.Entity;

import lombok.Data;

import jakarta.persistence.*;

@Table
@Entity
@Data
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "img_id")
    Long id;

    @Column
    String img;

    @ManyToOne
    @JoinColumn(name = "color_id",nullable = false)
    Color color;

    @ManyToOne
    @JoinColumn(name = "product_id",nullable = false)
    Product product;

    public Long getProduct() {
        return product.id;
    }
}
