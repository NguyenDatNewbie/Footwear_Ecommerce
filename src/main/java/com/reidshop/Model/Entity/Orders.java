package com.reidshop.Model.Entity;

import com.reidshop.Model.Enum.OrderStatus;
import lombok.Data;

import jakarta.persistence.*;

import java.sql.Date;

@Table
@Entity
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
    OrderStatus status;

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
