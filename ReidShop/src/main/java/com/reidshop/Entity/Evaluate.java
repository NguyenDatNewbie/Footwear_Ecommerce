package com.reidshop.Entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Table
@Entity
public class Evaluate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "evaluate_id")
    Long id;

    @Column
    int rate;

    @Column
    String comment;

    @ManyToOne
    @JoinColumn(name = "product_id")
    Product product;

    @ManyToOne
    @JoinColumn(name="account_id")
    Account account;
}
