package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StoreRepository extends JpaRepository<Store,Long> {
    @Query("SELECT s FROM Store s WHERE s.department LIKE CONCAT('%', :department, '%') OR :department IS NULL OR :department = ''")
    List<Store> searchAllByDepartment(@Param("department") String department);
    @Query("SELECT s FROM Store s WHERE s.account.id=?1")
    Store searchAllByAccountId(long accountId);
}
