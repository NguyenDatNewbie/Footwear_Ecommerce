package com.reidshop.Model.Entity;

import com.nimbusds.openid.connect.sdk.assurance.evidences.Voucher;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Model.Enum.PaymentType;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Model.Enum.VoucherType;
import lombok.Data;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

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

    @OneToOne
    @JoinColumn(name = "info_delivery_id")
    Delivery delivery;

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
    @Enumerated(EnumType.STRING)
    VoucherType voucherType;

    @Column
    double voucherValue;

    @Column
    @DateTimeFormat(pattern = "hh:mm dd--MM--yyyy") // Định dạng ngày theo ý muốn
    Date createdAt;

    @Column
    @DateTimeFormat(pattern = "hh:mm dd--MM--yyyy") // Định dạng ngày theo ý muốn
    Date updatedAt;

    @Column
    @DateTimeFormat(pattern = "hh:mm dd--MM--yyyy")
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

    @ManyToOne
    @JoinColumn(name = "voucher_id")
    Vourcher vourcher;

    public List<OrderItem> getOrderItems() {
        List<OrderItem> result = new ArrayList<>();
        for(int i=0;i<orderItems.size();i++)
        {
            OrderItem current = orderItems.get(i);

            if(result.stream().filter(o -> o.getInventory().getSize().equals(current.getInventory().getSize())
                            && o.getInventory().getColor().equals(current.getInventory().getColor()))
                    .findFirst().isPresent())
                continue;

            List<OrderItem> exits = orderItems.stream()
                                    .filter(o -> o.getInventory().getSize().equals(current.getInventory().getSize())
                                    && o.getInventory().getColor().equals(current.getInventory().getColor()))
                                    .collect(Collectors.toList());
            int quantity = 0;
            for(OrderItem o: exits){
                quantity += o.getQuantity();
            }
            current.setQuantity(quantity);
            result.add(current);
        }
        return result;
    }

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

    public String getUpdatedAt() {
        if (updatedAt == null) {
            return ""; // Hoặc bạn có thể trả về null nếu không có giá trị
        }
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm dd-MM-yyyy");
        return formatter.format(updatedAt);
    }

    public void setUpdatedAt() {
        this.updatedAt = Calendar.getInstance().getTime();
    }

    public String getLimitReceiveAt() {
        if (limitReceiveAt == null) {
            return ""; // Hoặc bạn có thể trả về null nếu không có giá trị
        }
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm dd-MM-yyyy");
        return formatter.format(limitReceiveAt);
    }

    public void setLimitReceiveAt() {
        limitReceiveAt = Calendar.getInstance().getTime();
    }


}
