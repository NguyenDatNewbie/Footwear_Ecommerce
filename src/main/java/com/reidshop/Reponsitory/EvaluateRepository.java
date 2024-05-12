package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.Evaluate;
import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EvaluateRepository extends JpaRepository<Evaluate,Long> {
    @Query("select e from Evaluate e where e.product.id=?1")
    List<Evaluate> findAllByProductId(Long id);

    @Query("select count (e.rate) from Evaluate e where e.product.id=?1 and e.rate=?2")
    int countRate(Long id,int rate);

    @Query("select e from Evaluate e where e.orders=?1")
    List<Evaluate> checkExits(Orders orders);
    @Query("SELECT e.account.id, e.product.id, AVG(e.rate) FROM Evaluate e GROUP BY e.account.id, e.product.id")
    List<Object[]> findAllFollowUU();

    @Query("SELECT  e.product.id, e.account.id, AVG(e.rate) FROM Evaluate e GROUP BY e.account.id, e.product.id")
    List<Object[]> findAllFollowII();
    @Query("SELECT e.account.id, e.product.id, AVG(e.rate) FROM Evaluate e WHERE e.account != :account and e.product not in :purchased GROUP BY e.account.id, e.product.id")
    List<Object[]> findAverageRateByAccountIdAndProductIdNotEqual(@Param("account") Account account,@Param("purchased") List<Product> purchased);
    @Query("SELECT e.product.id FROM Evaluate e WHERE e.account != :account and e.product not in :purchased GROUP BY e.account.id, e.product.id")
    List<Long> findProductNotEvaluate(@Param("account") Account account,@Param("purchased") List<Product> purchased);
    @Query("select e.product.id from  Evaluate e where e.product!=?1 group by e.product.id")
    List<Long> findNotProductSelect(Product product);
    @Query("SELECT e.product FROM Evaluate e WHERE e.account = :account")
    List<Product> findAllProductByAccount(@Param("account") Account account);
}
