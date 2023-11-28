package com.reidshop.Model.Entity;

import lombok.Data;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Table
@Entity
@Data
public class Evaluate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "evaluate_id")
    Long id;

    @Column
    int rate;

    @Column
    String comment;

    @Column
    String img;

    @Column
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "dd--MM--yyyy")
    Date createdAt;

    @ManyToOne
    @JoinColumn(name = "product_id",nullable = false,referencedColumnName = "product_id")
    Product product;

    @ManyToOne
    @JoinColumn(name="account_id",nullable = false,referencedColumnName = "account_id")
    Account account;
}
