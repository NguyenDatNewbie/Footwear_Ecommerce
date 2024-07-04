package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Vourcher;
import com.reidshop.Reponsitory.VoucherRepository;
import com.reidshop.Service.IVoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class VoucherServiceImpl implements IVoucherService {

    @Autowired
    VoucherRepository voucherRepository;
    @Override
    public List<Vourcher> findAllVourcherNotExpired() {
        Date currentDate = new Date();

        List<Vourcher> vouchersNotExpire = voucherRepository.findAllVourcherNotExpired(currentDate);

        return vouchersNotExpire;
    }

    @Override
    public List<Vourcher> findVouchersInForce() {
        Date currentDate = new Date();

        List<Vourcher> vouchersNotExpire = voucherRepository.findVouchersInForce(currentDate);

        return vouchersNotExpire;
    }

    @Override
    public List<Vourcher> findVouchersExpiration() {
        Date currentDate = new Date();

        List<Vourcher> vouchersExpire = voucherRepository.findVouchersExpiration(currentDate);

        return vouchersExpire;
    }

    @Override
    public List<Vourcher> getAllVoucher() {
        return voucherRepository.findAll();
    }
}
