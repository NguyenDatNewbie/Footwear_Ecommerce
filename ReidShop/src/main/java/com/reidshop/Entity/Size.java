package com.reidshop.Entity;

import lombok.Data;
import org.hibernate.annotations.CollectionId;
import org.hibernate.annotations.LazyGroup;
import org.springframework.context.annotation.ComponentScan;

import javax.persistence.*;

@Entity
@Table
@Data
public class Size {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "size_id")
    Long id;

    @Column
    String size;

    @ManyToOne
    @JoinColumn(name = "product_id")
    Product product;
}
