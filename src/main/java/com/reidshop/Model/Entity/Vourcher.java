package com.reidshop.Model.Entity;

import jakarta.persistence.*;
import lombok.Data;

import java.sql.Date;

@Entity
@Data
@Table
public class Vourcher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "vourcher_id")
    Long id;

    @Column(name = "voucher_code", unique = true)
    String voucherCode;

    @Column(name = "discount_value", precision = 10, scale = 3, nullable = false)
    Double discountValue;

    @Column(name = "giatritoithieu")
    Double minimumValue;

    @Column(name = "quantity")
    Integer quantity;

    @Column(name = "title")
    String title;

    @Column(name = "description", columnDefinition = "TEXT")
    String description;

    @Column(name = "expiration_date", nullable = false)
    Date expirationDate;

    @Column(name = "created_at")
    Date createdAt;
}
