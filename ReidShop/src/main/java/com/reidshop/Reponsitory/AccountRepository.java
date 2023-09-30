package com.reidshop.Reponsitory;

import com.reidshop.Entity.Account;
import com.reidshop.Entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepository extends JpaRepository<Account,Long> {
}
