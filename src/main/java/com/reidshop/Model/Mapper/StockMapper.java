package com.reidshop.Model.Mapper;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Stock;
import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Response.StockResponse;
import com.reidshop.Model.Response.StoreResponse;
import org.mapstruct.*;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface StockMapper {
    @Mapping(target = "id",source = "stock.id")
    @Mapping(target = "store",source = "stock.store")
    @Mapping(target = "supplier",source = "stock.supplier")
    @Mapping(target = "inventories",source = "stock.inventories")
    StockResponse toResponse(Stock stock);

    @IterableMapping(elementTargetType = StockResponse.class, qualifiedByName = "toResponse")
    @BeanMapping(ignoreByDefault = true)
    List<StockResponse> toListResponse(List<Stock> stocks);

    @Named("toResponse")
    default StockResponse setStock(Stock stock){
        StockResponse stockResponse = toResponse(stock);
        calTotal(stockResponse);
        return stockResponse;
    }
    default void calTotal(StockResponse stockResponse){
        int quantity = 0;
        double total = 0;
        List<Inventory> inventories = stockResponse.getInventories();
        for(Inventory inventory: inventories){
            if(inventory.getImportQuantity()==null)
                inventory.setImportQuantity(0);

            quantity += inventory.getImportQuantity();
            total += inventory.getImportQuantity()*inventory.getImportPrice();
        }
        stockResponse.setTotalPrice(total);
        stockResponse.setTotalQuantity(quantity);
    }

}
