package com.reidshop.Model.Request;

import lombok.Getter;
import lombok.Setter;

import java.util.List;
@Getter
@Setter
public class StoreRequest {
    List<CartRequest> carts;
    String city;
    String district;
}
