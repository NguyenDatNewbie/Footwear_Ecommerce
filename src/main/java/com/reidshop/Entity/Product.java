package com.reidshop.Entity;

import lombok.Data;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Table
@Entity
@Data
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    Long id;

    @Column
    String name;

    @Column
    String description;

    @Column
    double price;

    @Column
    int sold;

    @Column
    int promotion;

    @ManyToOne
    @JoinColumn(name = "category_id")
    Category category;

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY)
    List<Image> images = new ArrayList<>();

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY)
    List<Evaluate> evaluates = new ArrayList<>();

    @OneToMany(mappedBy = "product",fetch = FetchType.LAZY)
    List<Size> sizes = new ArrayList<>();
}
