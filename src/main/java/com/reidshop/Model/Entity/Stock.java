package com.reidshop.Model.Entity;

import lombok.Data;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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


    @Column
    @DateTimeFormat(pattern = "hh:mm dd--MM--yyyy")
    Date createdAt;

    @ManyToOne
    @JoinColumn(name = "store_id")
    Store store;

    @ManyToOne
    @JoinColumn(name = "supplier_id")
    Supplier supplier;

    public void setCreatedAt() {
        createdAt = Calendar.getInstance().getTime();
    }
    public String getCreatedAt() {
        if (createdAt == null) {
            return ""; // Hoặc bạn có thể trả về null nếu không có giá trị
        }
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm dd-MM-yyyy");
        return formatter.format(createdAt);
    }

}
