package com.reidshop.Service;

import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Model.Response.StoreValidResponse;

import java.util.List;

public interface IStoreService {
    List<StoreValidResponse> findAllStoreIsStock(List<CartRequest> requestList, String city, String district);
}
