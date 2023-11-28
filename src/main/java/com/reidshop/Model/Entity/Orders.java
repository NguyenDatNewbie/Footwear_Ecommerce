package com.reidshop.Model.Entity;

import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.TypeReceive;
import lombok.Data;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Date;

@Table
@Entity
@Data
public class Orders {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    Long id;

    @Column
    String phone;

    @Column
    String name;

    @Column
    String address;

    @Column
    double totalPrice;

    @Column
    @Enumerated(EnumType.STRING)
    OrderStatus status;

    @Column
    @Enumerated(EnumType.STRING)
    TypeReceive typeReceive;

    @Column
    @Temporal(TemporalType.DATE) // Chỉ lấy ngày, bỏ qua giờ và phút
    @DateTimeFormat(pattern = "dd--MM--yyyy") // Định dạng ngày theo ý muốn
    Date createdAt;

    @Column
    @Temporal(TemporalType.DATE) // Chỉ lấy ngày, bỏ qua giờ và phút
    @DateTimeFormat(pattern = "dd--MM--yyyy") // Định dạng ngày theo ý muốn
    Date updatedAt;

    @ManyToOne
    @JoinColumn(name = "account_id")
    Account account;

    @ManyToOne
    @JoinColumn(name="store_id")
    Store store;
}
