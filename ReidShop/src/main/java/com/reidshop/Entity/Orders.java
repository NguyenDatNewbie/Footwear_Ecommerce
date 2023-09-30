package com.reidshop.Entity;

import lombok.Data;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Date;

@Table@Entity
@Data
public class Orders {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    Long id;

    @Column()
    String phone;

    @Column()
    String address;

    @Column
    double totalPrice;

    @Column
    Date createdAt;

    @Column
    Date updatedAt;

    @ManyToOne
    @JoinColumn(name = "account_id")
    Account account;

    @ManyToOne
    @JoinColumn(name="store_id")
    Store store;
}
