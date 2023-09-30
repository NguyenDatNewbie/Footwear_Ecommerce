package com.reidshop.Reponsitory;

import com.reidshop.Entity.Evaluate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EvaluateRepository extends JpaRepository<Evaluate,Long> {
}
