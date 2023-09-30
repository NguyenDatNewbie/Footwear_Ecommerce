package com.reidshop.Entity;

import lombok.Data;

import javax.persistence.*;

@Table
@Entity
@Data
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id")
    Long id;
    @Column
    String name;
    @Column
    Long parent;
}
