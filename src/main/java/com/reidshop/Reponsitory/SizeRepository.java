package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SizeRepository extends JpaRepository<Size,Long> {
    @Query("select s from Size s where s.product.id=?1")
    List<Size> findAllByProductId(Long id);

    @Query("select s from Size s where s.product.id=?1 and s.size=?2")
    Size findAllByProductIdAndSize(Long id,String size);
}
