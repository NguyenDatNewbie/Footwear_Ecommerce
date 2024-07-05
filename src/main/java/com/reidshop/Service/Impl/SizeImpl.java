package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Size;
import com.reidshop.Reponsitory.SizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SizeImpl {
    @Autowired
    SizeRepository sizeRepository;
    List<Size> findAllByProductId(Long id){
        return sizeRepository.findAllByProductId(id);
    }

}
