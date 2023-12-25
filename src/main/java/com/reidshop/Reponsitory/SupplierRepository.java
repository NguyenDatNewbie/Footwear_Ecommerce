package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Entity.Supplier;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SupplierRepository extends JpaRepository<Supplier,Long> {
}
