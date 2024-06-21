package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.ProductOutOfStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Objects;

@Repository
public interface ProductOutOfStockRepository extends JpaRepository<ProductOutOfStock,Long> {
    @Query("select p from ProductOutOfStock p where p.orders.store.id=?1 order by p.orders.createdAt")
    List<ProductOutOfStock> findAllByStoreId(long storeId);

    List<ProductOutOfStock> findAllByOrders(Orders orders);

    @Query("select p from ProductOutOfStock p where p.orders.id=?1")
    List<ProductOutOfStock> findByOrderId(long orderId);

    @Query("SELECT p.size.id, p.color.id, SUM(p.quantity),p.orders.id AS totalQuantity " +
            "FROM ProductOutOfStock p " +
            "where p.orders.store.id=?1 " +
            "GROUP BY p.size.id, p.color.id, p.orders.id")
    List<Object[]> listProductImport(long storeId);


}
