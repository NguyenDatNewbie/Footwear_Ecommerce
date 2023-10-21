package com.reidshop.Reponsitory;

import com.reidshop.Entity.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface OrdersRepository extends JpaRepository<Orders,Long> {
}
