package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Inventory;
import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Enum.ReceiveType;
import com.reidshop.Model.Mapper.StoreMapper;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Model.Request.StoreValidRequest;
import com.reidshop.Model.Response.StoreValidResponse;
import com.reidshop.Reponsitory.SizeRepository;
import com.reidshop.Reponsitory.StoreRepository;
import com.reidshop.Service.IStoreService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class StoreServiceImpl implements IStoreService {
    @Autowired
    StoreRepository storeRepository;
    @Autowired
    SizeRepository sizeRepository;
    final StoreMapper storeMapper;

    @Override
    public List<StoreValidRequest> findAll(){
        List<Store> stores = storeRepository.findAll();
        List<StoreValidRequest> storeValidRequests = new ArrayList<>();
        for(int i=0;i<stores.size();i++){
            StoreValidRequest storeValidRequest = new StoreValidRequest();
            storeValidRequest.setStatus(0);
            storeValidRequest.setStore(storeMapper.toResponse(stores.get(i)));
            storeValidRequests.add(storeValidRequest);
        }
        return storeValidRequests;
    }

    @Override
    public List<StoreValidResponse> findAllStoreIsStock(List<CartRequest> requestList, String city, String district, String ward, ReceiveType receiveType) {
        String search = "";
        if(city!=null && !city.isEmpty()) {
            search = city;
            if(district!=null && !district.isEmpty()) {
                search = district + ", " + city;
                if(ward!=null && !ward.isEmpty())
                    search = ward+", " + district + ", " + city;
            }
        }
        List<Store> stores = storeRepository.searchAllByDepartment(search);
        List<StoreValidResponse> storeValid = new ArrayList<>();
        List<StoreValidResponse> indexValid;

        for (int index = 0; index < requestList.size(); index++) {
            CartRequest cart = requestList.get(index);
            indexValid = new ArrayList<>();
            int storeSize = stores.size();

            for (int i = 0; i < storeSize; i++) {
                Store store = stores.get(i);
                if (index > 0) {
                    if (storeValid.size() == i)
                        break;
                    store = storeRepository.findById(storeValid.get(i).getStore().getId()).orElse(new Store());
                }

                List<Inventory> inventories = store.getInventories();
                if (index > 0 || inventories.size() > 0) { // inventories.size() > 0 Nếu như store đầu tiên chưa có tạo kho còn bắt lỗi được
                    for (int j = 0; j < inventories.size(); j++) {
                        if (store.getInventories().get(j).getSize() == sizeRepository.findAllByProductIdAndSize(cart.getId(), cart.getSize())
                                && store.getInventories().get(j).getQuantity() >= cart.getQuantity()) {
                            StoreValidResponse storeResponse = new StoreValidResponse();
                            storeResponse.setStatus(1);
                            storeResponse.setStore(storeMapper.toResponse(store));
                            indexValid.add(storeResponse);
                        }
                    }
                }
            }
            storeValid = indexValid;
        }
        if(receiveType==ReceiveType.STORE)
            return showAllStore(storeValid, stores);
        else
        {
            if(storeValid.size()>0)
                return storeValid;
            else {
                // Đệ quy tìm kiếm
                if(ward!=null && !ward.isEmpty())
                    return findAllStoreIsStock(requestList,city,district,"",ReceiveType.DELIVERY);
                if(district!=null && !district.isEmpty())
                    return findAllStoreIsStock(requestList,city,"","",ReceiveType.DELIVERY);
                if(city!=null && !city.isEmpty())
                    return findAllStoreIsStock(requestList,"","","",ReceiveType.DELIVERY);
            }
            return storeValid; // Không tìm thấy store nào còn hàng
        }
    }

    List<StoreValidResponse> showAllStore(List<StoreValidResponse> storeValid, List<Store> allStore) {
        List<StoreValidResponse> result = new ArrayList<>();
        result.addAll(storeValid);
        for (int i = 0; i < allStore.size(); i++) {
            boolean isExist = false;
            for (int j = 0; j < storeValid.size(); j++) {
                if (storeValid.get(j).getStore().getId() == allStore.get(i).getId()) {
                    isExist = true;
                    break;
                }
            }

            if (!isExist) {
                StoreValidResponse outOfStore = new StoreValidResponse();
                outOfStore.setStatus(0);
                outOfStore.setStore(storeMapper.toResponse(allStore.get(i)));
                result.add(outOfStore);
            }
        }
        return result;
    }

}
