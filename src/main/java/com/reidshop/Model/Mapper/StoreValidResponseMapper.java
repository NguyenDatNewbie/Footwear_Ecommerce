package com.reidshop.Model.Mapper;

import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Response.StoreResponse;
import com.reidshop.Model.Response.StoreValidResponse;
import org.mapstruct.*;

import java.util.List;

@Mapper(componentModel = "spring",unmappedTargetPolicy = ReportingPolicy.IGNORE,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE,
        uses = {StoreMapper.class})
public interface StoreValidResponseMapper {

    @Mapping(target = "store",source = "store",qualifiedByName = "toResponse")
    @Mapping(target = "status",expression = "java(0)")
    @BeanMapping(ignoreByDefault = true)
    @Named("toResponse")
    StoreValidResponse toResponseOutOfStock(Store store);
    @IterableMapping(elementTargetType = StoreValidResponse.class, qualifiedByName = "toResponse")
    @BeanMapping(ignoreByDefault = true)
    List<StoreValidResponse> toListResponseOutOfStock(List<Store> stores);
}
