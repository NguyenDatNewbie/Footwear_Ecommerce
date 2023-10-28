package com.reidshop.Model.Entity;

import lombok.Data;

import jakarta.persistence.*;

@Entity
@Data
@Table
public class Supplier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "supplier_id")
    Long id;

    String name;
    String address;
    String phone;
}
