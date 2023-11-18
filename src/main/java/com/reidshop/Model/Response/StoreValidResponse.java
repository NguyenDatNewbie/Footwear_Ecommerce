package com.reidshop.Model.Response;

import com.reidshop.Model.Entity.Store;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StoreValidResponse {
    StoreResponse store;
    int status;
}
