package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Entity.Stock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StockRepository extends JpaRepository<Stock,Long> {
    @Query("select s from Stock s where s.store.id = ?1 order by s.createdAt desc ")
    List<Stock> findAllByStoreId(Long id);
}
