package com.reidshop.Reponsitory;

import com.reidshop.Model.Entity.OrderItem;
import com.reidshop.Model.Entity.Vourcher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface VoucherRepository extends JpaRepository<Vourcher,Long> {

    Optional<Vourcher> findByVoucherCode(String voucherCode);
    @Query("SELECT o FROM Vourcher o WHERE o.expirationDate >= :currentDate and o.quantity > 0 ORDER BY o.discountValue DESC")
    List<Vourcher> findAllVourcherNotExpired(Date currentDate);

    @Query("SELECT o FROM Vourcher o WHERE o.expirationDate > :currentDate")
    List<Vourcher> findVouchersInForce(Date currentDate);

    @Query("SELECT o FROM Vourcher o WHERE o.expirationDate < :currentDate")
    List<Vourcher> findVouchersExpiration(Date currentDate);


}
