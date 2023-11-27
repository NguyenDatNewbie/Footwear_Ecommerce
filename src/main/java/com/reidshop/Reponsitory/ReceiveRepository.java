package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.ReceiveStore;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReceiveRepository extends JpaRepository<ReceiveStore,Long> {

}
