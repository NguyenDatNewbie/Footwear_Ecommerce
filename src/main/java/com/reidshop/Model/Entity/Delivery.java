package com.reidshop.Model.Entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Data
public class Delivery {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "delivery_id")
    Long id;
    String name;
    String code;
    double cost;
    @Column(name = "intent_time")
    Date intentTime;
}
