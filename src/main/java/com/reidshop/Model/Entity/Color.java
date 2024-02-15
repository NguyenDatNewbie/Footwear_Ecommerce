package com.reidshop.Model.Entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table
@Data
public class Color {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "color_id")
    Long id;
    String color_name;
    String color_code;
}
