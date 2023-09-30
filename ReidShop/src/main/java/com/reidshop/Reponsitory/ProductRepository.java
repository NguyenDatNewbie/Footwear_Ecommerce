package com.reidshop.Reponsitory;

import com.reidshop.Entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository

public interface ProductRepository extends JpaRepository<Product,Long> {
    @Query("SELECT p from Product p where p.category.id=?1")
    List<Product> findAllByCategory(Long id);

    @Query("SELECT p from Product p order by p.sold desc")
    List<Product> findAllByProductSold();


}
