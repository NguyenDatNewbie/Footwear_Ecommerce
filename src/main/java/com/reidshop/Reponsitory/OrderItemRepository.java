package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository

public interface OrderItemRepository extends JpaRepository<OrderItem,Long> {
    @Query("SELECT SUM(oi.quantity * i.importPrice) FROM OrderItem oi, Inventory i WHERE oi.inventory.id = i.id AND oi.order.id = ?1")
    double totalPriceOriginalOrders(int orderId);

}
