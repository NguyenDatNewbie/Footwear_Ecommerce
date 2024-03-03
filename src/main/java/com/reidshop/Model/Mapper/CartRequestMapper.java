package com.reidshop.Model.Mapper;

import com.reidshop.Model.Entity.OrderItem;
import com.reidshop.Model.Entity.ProductOutOfStock;
import com.reidshop.Model.Request.CartRequest;
import org.mapstruct.*;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface CartRequestMapper {
    @Mapping(target = "id",source = "orderItem.inventory.size.product.id")
    @Mapping(target = "size",source = "orderItem.inventory.size.size")
    @Mapping(target = "color",source = "orderItem.inventory.color.id")
    @Mapping(target = "quantity",source = "orderItem.quantity")
    @BeanMapping(ignoreByDefault = true)
    @Named("toCartRequest")
    CartRequest toCartRequest(OrderItem orderItem);

    @IterableMapping(elementTargetType = CartRequest.class, qualifiedByName = "toCartRequest")
    @BeanMapping(ignoreByDefault = true)
    List<CartRequest> toListCartRequest(List<OrderItem> orderItems);

    @Mapping(target = "id",source = "productOutOfStock.size.product.id")
    @Mapping(target = "size",source = "productOutOfStock.size.size")
    @Mapping(target = "color",source = "productOutOfStock.color.id")
    @Mapping(target = "quantity",source = "productOutOfStock.quantity")
    @BeanMapping(ignoreByDefault = true)
    @Named("toCartRequestOutStock")
    CartRequest toCartRequestOutStock(ProductOutOfStock productOutOfStock);

    @IterableMapping(elementTargetType = CartRequest.class, qualifiedByName = "toCartRequestOutStock")
    @BeanMapping(ignoreByDefault = true)
    List<CartRequest> toListCartRequestOutStock(List<ProductOutOfStock> ProductOutOfStock);
}
