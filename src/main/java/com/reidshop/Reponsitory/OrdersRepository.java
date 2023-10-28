package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface OrdersRepository extends JpaRepository<Orders,Long> {
}
