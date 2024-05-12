package com.reidshop.Model.Entity;

import lombok.Data;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

@Entity
@Data
@Table
public class Stock {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "stock_id")
    Long id;

    @Temporal(TemporalType.DATE) // Chỉ lấy ngày, bỏ qua giờ và phút
    @DateTimeFormat(pattern = "dd--MM--yyyy") // Định dạng ngày theo ý muốn
    @Column
    Date createdAt;

    @ManyToOne
    @JoinColumn(name = "store_id")
    Store store;

    @ManyToOne
    @JoinColumn(name = "supplier_id")
    Supplier supplier;

}
