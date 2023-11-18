package com.reidshop.Service;

import com.reidshop.Model.Request.CartRequest;

import java.util.List;

public interface ICartService {
    String getItemCart(List<CartRequest> requestList);
}
