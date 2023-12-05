package com.reidshop.Model.Request;

import com.reidshop.Model.Response.StoreResponse;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StoreValidRequest {
    StoreResponse store;
    int status;
}
