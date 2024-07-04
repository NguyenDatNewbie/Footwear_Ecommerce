package com.reidshop.Service;

import com.reidshop.Model.Entity.Vourcher;

import java.util.List;

public interface IVoucherService {
    List<Vourcher> findAllVourcherNotExpired();

    List<Vourcher> findVouchersInForce();

    List<Vourcher> findVouchersExpiration();

    List<Vourcher> getAllVoucher();
}
