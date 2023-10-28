package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.AccountDetail;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountDetailRepository extends JpaRepository<AccountDetail,Long> {
}
