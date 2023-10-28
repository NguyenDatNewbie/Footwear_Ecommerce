package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository

public interface ImageRepository extends JpaRepository<Image,Long> {
    @Query("select i from Image i where i.product.id=?1")
    List<Image> findAllByProduct(Long id);

}
