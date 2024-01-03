package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AccountRepository extends JpaRepository<Account,Long> {
    Optional<Account> findByEmail(String email);

    @Query("select a from Account a where a.id=?1")
    Optional<Account> findByAccountId(Long id);

    @Query("select o from Account o where o.role = 'VENDOR'")
    List<Account> findAllStore();
}
