package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.ProductOutOfStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductOutOfStockRepository extends JpaRepository<ProductOutOfStock,Long> {
    @Query("select p from ProductOutOfStock p where p.orders.store.id=?1")
    List<ProductOutOfStock> findAllByStoreId(long storeId);

    @Query("select p from ProductOutOfStock p where p.orders.id=?1")
    List<ProductOutOfStock> findByOrderId(long orderId);
}
