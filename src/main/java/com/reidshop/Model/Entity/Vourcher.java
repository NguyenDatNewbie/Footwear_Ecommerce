package com.reidshop.Model.Entity;

import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Model.Enum.VoucherType;
import jakarta.persistence.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Date;

@Entity
@Data
@Table
public class Vourcher {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "vourcher_id")
    Long id;

    @Column(name = "voucher_code", nullable = false)
    String voucherCode;

    @Column(name = "discount_value", nullable = false)
    Double discountValue;

    @Column(name = "max_discount")
    Double maxDiscount;

    @Column(name = "minimum_value")
    Double minimumValue;

    @Column(name = "quantity", nullable = false)
    Integer quantity;

    @Column(name = "title")
    String title;

    @Column(name = "voucher_type", nullable = false)
    @Enumerated(EnumType.STRING)
    VoucherType voucherType;

    @Column(name = "description")
    String description;

    @Column(name = "expiration_date", nullable = false)
    @Temporal(TemporalType.DATE) // Chỉ lấy ngày, bỏ qua giờ và phút
    @DateTimeFormat(pattern = "dd--MM--yyyy") // Định dạng ngày theo ý muốn
    Date expirationDate;

    @Column(name = "created_at")
    @Temporal(TemporalType.DATE) // Chỉ lấy ngày, bỏ qua giờ và phút
    @DateTimeFormat(pattern = "dd--MM--yyyy") // Định dạng ngày theo ý muốn
    Date createdAt;
}
