package com.reidshop.Model.Entity;

import com.reidshop.Model.Enum.ReceiveStatus;
import jakarta.persistence.*;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Date;

@Data
@Entity
@Table
public class ReceiveStore {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "receive_id")
    Long id;

    @Column
    Long productId;

    @Column
    String size;

    @Column
    int quantity;

    @Column
    @Enumerated(EnumType.STRING)
    ReceiveStatus status;

    @ManyToOne
    @JoinColumn(name = "order_id",referencedColumnName = "order_id")
    Orders orders;

    @Column
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "dd--MM--yyyy")
    Date createdAt;

    @Column
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "dd--MM--yyyy")
    Date limitReceiveAt;
}
