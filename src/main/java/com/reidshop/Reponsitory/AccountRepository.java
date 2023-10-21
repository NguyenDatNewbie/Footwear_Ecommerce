package com.reidshop.Reponsitory;

import com.reidshop.Entity.Account;
import com.reidshop.Entity.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepository extends JpaRepository<Account,Long> {
    Account findByEmail(String email);

    @Query("select a from Account a where a.id=?1")
    Account findByAccountId(Long id);
}
