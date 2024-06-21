package com.reidshop.Model.Mapper;

import com.reidshop.Model.Entity.ProductOutOfStock;
import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Response.ExcelReStockResponse;
import com.reidshop.Model.Response.StoreValidResponse;
import com.reidshop.Reponsitory.InventoryRepository;
import org.mapstruct.*;
import org.mapstruct.factory.Mappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.util.List;

@Mapper(componentModel = "spring",unmappedTargetPolicy = ReportingPolicy.IGNORE,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface ReStockMapper {
    ReStockMapper INSTANCE = Mappers.getMapper(ReStockMapper.class);

    @Mapping(target = "productId",source = "p.size.product.id")
    @Mapping(target = "productName",source = "p.size.product.name")
    @Mapping(target = "orderId",source = "p.orders.id")
    @Mapping(target = "colorId",source = "p.color.id")
    @Mapping(target = "colorName",source = "p.color.color_name")
    @Mapping(target = "sizeId",source = "p.size.id")
    @Mapping(target = "size",source = "p.size.size")
    @Mapping(target = "quantity",source = "p.quantity")
    @Mapping(target = "inventory",source = "inventory")
    @Mapping(target = "restock", expression = "java(Math.abs(p.getQuantity() - inventory))")
    @Named("toResponse")
    ExcelReStockResponse toExcelResponse(ProductOutOfStock p, int inventory);


}
