package com.reidshop.Reponsitory;

import com.reidshop.Entity.Size;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SizeRepository extends JpaRepository<Size,Long> {
    @Query("select s from Size s where s.product.id=?1")
    List<Size> findAllByProductId(Long id);
}
