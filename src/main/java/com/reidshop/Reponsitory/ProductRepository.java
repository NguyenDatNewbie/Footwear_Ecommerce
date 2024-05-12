package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Enum.GENDER;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Repository
public interface ProductRepository extends JpaRepository<Product,Long> {
    @Override
    @Query("select p from Product p where p.enable=true")
    List<Product> findAll();
    @Override
    @Query("select p from Product p where p.enable=true and p.id=?1")
    Optional<Product> findById(Long id);
    @Query("SELECT p from Product p where p.category.id=?1 and p.enable=true")
    List<Product> findAllByCategory(Long id);

    @Query("SELECT p from Product p where p.category.id=?1 or (p.category.parent IS NOT NULL AND p.category.parent = ?1)and p.enable=true")
    List<Product> findAllByCategoryAndIsParent(Long id);
    @Query("SELECT p from Product p where p.enable=true order by p.sold desc ")
    List<Product> findAllByProductSold();

    @Query("SELECT p from Product p where p.id=?1 and p.enable=true")
    Product findByProductId(Long productId);

    @Query("SELECT p FROM Product p " +
            "JOIN Size s ON p.id = s.product.id " +
            "WHERE p.enable=true " +
            "AND (?1=0 or p.category.id = ?1 or (p.category.parent IS NOT NULL AND p.category.parent = ?1))" +
            "AND   ('DUMMYVALUE' IN ?2 Or (s.size IN ?2))"+
            "AND   ((p.gender IN ?3) or p.gender = 'UNISEX')")
    List<Product> getProductsByMulti(Long categoryId, List<String> sizes, List<GENDER> genders);

    @Query("SELECT p FROM Product p " +
            "JOIN Size s ON p.id = s.product.id " +
            "WHERE p.enable=true " +
            "AND (?1=0 or p.category.id = ?1 or (p.category.parent IS NOT NULL AND p.category.parent = ?1))" +
            "AND   ('DUMMYVALUE' IN ?2 Or (s.size IN ?2))" +
            "AND ('DUMMYVALUE' IN ?2 Or (s.size IN ?2))")
    List<Product> getProductsByMulti(Long categoryId, List<String> sizes);

    @Query("SELECT p FROM Product p WHERE p.name LIKE CONCAT('%', ?1, '%') and p.enable=true")
    List<Product> searchProduct(String query);

}
