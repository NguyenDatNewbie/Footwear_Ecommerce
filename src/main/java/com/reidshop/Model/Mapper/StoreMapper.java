package com.reidshop.Model.Mapper;

import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Response.StoreResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface StoreMapper {
    @Mapping(target = "accountId",source = "store.account.id")
    StoreResponse toResponse(Store store);
}
