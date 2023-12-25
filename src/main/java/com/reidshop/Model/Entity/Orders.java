package com.reidshop.Model.Entity;

import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.PaymentType;
import com.reidshop.Model.Enum.ReceiveType;
import lombok.Data;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

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
    double costShip;

    @Column
    @Enumerated(EnumType.STRING)
    OrderStatus status;

    @Column
    @Enumerated(EnumType.STRING)
    ReceiveType receiveType;

    @Column
    @Enumerated(EnumType.STRING)
    PaymentType paymentType;

    @Column
    @Temporal(TemporalType.DATE) // Chỉ lấy ngày, bỏ qua giờ và phút
    @DateTimeFormat(pattern = "dd--MM--yyyy") // Định dạng ngày theo ý muốn
    Date createdAt;

    @Column
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "dd--MM--yyyy")
    Date limitReceiveAt; // Thời gian hạn nhận khi order tại cửa hàng

    @ManyToOne
    @JoinColumn(name = "account_id")
    Account account;

    @ManyToOne
    @JoinColumn(name="store_id")
    Store store;

    @OneToMany(mappedBy = "order")
    List<OrderItem> orderItems;

    @OneToMany(mappedBy = "orders")
    List<ProductOutOfStock> productOutOfStocks;
}
