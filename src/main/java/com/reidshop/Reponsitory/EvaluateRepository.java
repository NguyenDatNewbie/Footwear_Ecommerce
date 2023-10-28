package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Evaluate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EvaluateRepository extends JpaRepository<Evaluate,Long> {
    @Query("select e from Evaluate e where e.product.id=?1")
    public List<Evaluate> findAllByProductId(Long id);

    @Query("select count (e.rate) from Evaluate e where e.product.id=?1 and e.rate=?2")
    public int countRate(Long id,int rate);
}
