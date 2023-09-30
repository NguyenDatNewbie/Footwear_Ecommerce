package com.reidshop.Entity;

import lombok.Data;

import javax.persistence.*;

@Table
@Entity
@Data
public class Store {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "store_id")
    Long id;

    @Column
    String department;

    @OneToOne
    @JoinColumn(name="manager_id")
    Account account;
}
