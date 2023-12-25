package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Entity.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product,Long> {
    @Query("SELECT p from Product p where p.category.id=?1")
    List<Product> findAllByCategory(Long id);

    @Query("SELECT p from Product p where p.category.id=?1 or (p.category.parent IS NOT NULL AND p.category.parent = ?1)")
    List<Product> findAllByCategoryAndIsParent(Long id);
    @Query("SELECT p from Product p order by p.sold desc")
    List<Product> findAllByProductSold();

    @Query("SELECT p from Product p where p.id=?1")
    Product findByProductId(Long productId);

    @Query("SELECT p FROM Product p " +
            "JOIN Size s ON p.id = s.product.id " +
            "WHERE  (?1=0 or p.category.id = ?1 )" +
            "AND    ('DUMMYVALUE' IN ?2 Or (SUBSTRING_INDEX(p.name, ' ', -1) IN ?2))" +
            "AND   ('DUMMYVALUE' IN ?3 Or (s.size IN ?3))")
    List<Product> getProductsByMulti(Long categoryId,List<String> colors,List<String> sizes);

    @Query("SELECT p FROM Product p WHERE p.name LIKE CONCAT('%', ?1, '%')")
    List<Product> searchProduct(String query);
}
