package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Entity.Stock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StockRepository extends JpaRepository<Stock,Long> {
}
