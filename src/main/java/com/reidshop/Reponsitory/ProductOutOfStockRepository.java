package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.ProductOutOfStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductOutOfStockRepository extends JpaRepository<ProductOutOfStock,Long> {

}
