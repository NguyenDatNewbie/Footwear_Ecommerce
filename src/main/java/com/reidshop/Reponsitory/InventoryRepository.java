package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.Stock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InventoryRepository extends JpaRepository<Inventory,Long> {
    @Query("select i from Inventory i where i.size.product.id=?1 and i.color.id=?5 and i.size.size=?2 and i.quantity>=?3 and i.store.id=?4 order by i.stock.createdAt ASC")
    List<Inventory> findByStore(Long productId, String size, int quantity,Long storeId, Long colorId);
    @Query("select i from Inventory i where i.store.id=?1 and i.size.id=?2 and i.color.id=?3")
    Inventory findForStock(Long storeId, Long size,Long color);

    @Query("select coalesce(sum(i.quantity),0) from Inventory i where i.size.id=?1 and i.color.id=?2 and i.store.account.id=?3")
    int totalInventory(long sizeId,long colorId,long accountId);

    @Query("select coalesce(sum(i.quantity),0)  from Inventory i where i.size.product.id=?1 and i.size.size=?2 and i.color.id=?3 and i.store.id=?4")
    int totalQuantity(Long product,String size,long colorId,long storeId);

    @Query("SELECT i from Inventory i where i.store.account.id=?1")
    List<Inventory> findAllInventoryByStore(long accountId);

    @Query("select o from Inventory o where o.store.id = :storeId")
    List<Inventory> findAllInventoryByStoreID(@Param("storeId") Long storeId);

    @Query("select coalesce(sum(o.quantity),0) from Inventory o where o.store.id = :storeId and o.size.id=:sizeId and o.color.id=:colorId")
    int getQuantityOfProduct(Long storeId, Long sizeId, Long colorId);

    @Query("select i from Inventory i where i.stock=?1 and i.size.id=?2 and i.color.id=?3 and i.quantity>0 ")
    List<Inventory> checkExistInStock(Stock stock,Long size,Long color);

    @Query("select i from Inventory i where i.stock!=?1 and i.size.id=?2 and i.color.id=?3 and i.quantity>0 and i.store.id=?4 order by i.stock.createdAt DESC")
    List<Inventory> findAllOutStock(Stock stock, Long size,Long color,Long storeId);

    @Query("select i from Inventory i where i.size.product.id=?1 and i.size.size=?2 and i.color.id=?3 and i.store.id=?4 order by i.stock.createdAt ASC ")
    List<Inventory> findAllInventoryValid(Long product,String size,long colorId,long storeId);

    List<Inventory> findAllByStockId(Long id);
}
