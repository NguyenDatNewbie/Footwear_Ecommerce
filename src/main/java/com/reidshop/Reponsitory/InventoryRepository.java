package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InventoryRepository extends JpaRepository<Inventory,Long> {
    @Query("select i from Inventory i where i.size.product.id=?1 and i.size.size=?2 and i.quantity>=?3 and i.store.id=?4 order by i.stock.createdAt")
    Inventory findByStore(Long productId, String size, int quantity,Long storeId);

    @Query("select coalesce(sum(i.quantity),0)  from Inventory i where i.size.id=?1 and i.store.account.id=?2")
    int totalInventory(long sizeId,long accountId);

    @Query("select o from Inventory o where o.store.id = :storeId")
    List<Inventory> findAllInventoryByStoreID(@Param("storeId") Long storeId);
}
