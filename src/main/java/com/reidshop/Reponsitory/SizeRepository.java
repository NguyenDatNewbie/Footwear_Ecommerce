package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SizeRepository extends JpaRepository<Size,Long> {
    @Query("select s from Size s where s.product.id=?1")
    List<Size> findAllByProductId(Long id);

    @Query("select s from Size s where s.product.id=?1 and s.size=?2")
    Size findAllByProductIdAndSize(Long id,String size);

    //kiểm tra sự tồn tại của size - productID
    @Query("SELECT COUNT(s) FROM Size s WHERE s.size = :size AND s.product.id = :productId")
    Long countBySizeAndProductId(@Param("size") String size, @Param("productId") Long productId);

    //Xóa hết các size của product
    @Modifying
    @Query("DELETE FROM Size s WHERE s.product.id = :productId")
    void deleteByProductId(@Param("productId") Long productId);
}
