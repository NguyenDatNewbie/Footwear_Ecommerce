package com.reidshop.Service;

import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Model.Request.StoreValidRequest;
import com.reidshop.Model.Response.StoreValidResponse;

import java.util.List;

public interface IStoreService {
    List<StoreValidRequest> findAll();

    List<StoreValidResponse> findAllStoreIsStock(List<CartRequest> requestList, String city, String district, String ward, ReceiveType receiveType);

    List<Store> getAllStore();

    Long countStore();
}
