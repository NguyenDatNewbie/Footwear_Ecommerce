package com.reidshop.Model.Mapper;

import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Response.StoreResponse;
import com.reidshop.Model.Response.StoreValidResponse;
import org.mapstruct.*;

import java.util.List;

@Mapper(componentModel = "spring",unmappedTargetPolicy = ReportingPolicy.IGNORE,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface StoreMapper {
    @Mapping(target = "accountId",source = "store.account.id")
    @Mapping(target = "id",source = "store.id")
    @Mapping(target = "department",source = "store.department")
    @Named("toResponse")
    StoreResponse toResponse(Store store);

    @IterableMapping(elementTargetType = StoreResponse.class, qualifiedByName = "toResponse")
    @BeanMapping(ignoreByDefault = true)
    List<StoreResponse> toListResponse(List<Store> stores);
}
