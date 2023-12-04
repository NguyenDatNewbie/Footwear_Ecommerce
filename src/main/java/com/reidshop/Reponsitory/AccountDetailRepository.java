package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.AccountDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface AccountDetailRepository extends JpaRepository<AccountDetail,Long> {
    @Query("SELECT ad FROM AccountDetail ad WHERE ad.account.id = :accountId")
    Optional<AccountDetail> findByAccountId(@Param("accountId") Long accountId);
}
