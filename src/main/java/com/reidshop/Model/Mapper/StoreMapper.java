package com.reidshop.Model.Mapper;

import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Response.StoreResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface StoreMapper {
    @Mapping(target = "accountId",source = "store.account.id")
    StoreResponse toResponse(Store store);

    @Mapping(target = "accountId",source = "store.account.id")
    List<StoreResponse> toListResponse(List<Store> stores);
}
