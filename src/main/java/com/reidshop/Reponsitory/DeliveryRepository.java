package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Delivery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

@Repository
public interface DeliveryRepository extends JpaRepository<Delivery, Long> {
}
