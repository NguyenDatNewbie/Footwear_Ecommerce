package com.reidshop.Reponsitory;

import com.reidshop.Entity.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SizeRepository extends JpaRepository<Size,Long> {
}
