package com.reidshop.Reponsitory;

import com.reidshop.Entity.AccountDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountDetailRepository extends JpaRepository<AccountDetail,Long> {
    @Query("select a from AccountDetail a where a.account.id=?1")
    AccountDetail findByAccountId(Long id);
}
