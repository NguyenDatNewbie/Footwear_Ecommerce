package com.reidshop.Entity;

import lombok.Data;

import javax.persistence.*;

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

//    @ManyToOne(fetch = FetchType.EAGER)
    @ManyToOne
    @JoinColumn(name = "product_id",nullable = false)
    Product product;

    public Long getProduct() {
        return product.id;
    }

}
