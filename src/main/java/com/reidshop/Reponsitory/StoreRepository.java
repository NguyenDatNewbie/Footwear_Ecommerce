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

    Store findByAccountId(Long accountId);

    @Query("SELECT DISTINCT  SUBSTRING_INDEX(department, ',', -1) FROM Store")
    List<String> findOneColumnCity();

    @Query("SELECT DISTINCT  SUBSTRING_INDEX(SUBSTRING_INDEX(s.department, ',', -2), ',', 1)" +
            "FROM Store s WHERE s.department LIKE CONCAT('%', ?1, '%')")
    List<String> findOneColDistrictByCity(String city);
}
