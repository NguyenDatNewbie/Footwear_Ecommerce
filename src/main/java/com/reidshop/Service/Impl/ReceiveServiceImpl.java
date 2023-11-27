package com.reidshop.Service.Impl;

import com.reidshop.Model.Entity.Orders;
import com.reidshop.Model.Entity.ReceiveStore;
import com.reidshop.Model.Enum.ReceiveStatus;
import com.reidshop.Model.Request.CartRequest;
import com.reidshop.Reponsitory.InventoryRepository;
import com.reidshop.Reponsitory.ReceiveRepository;
import com.reidshop.Service.IReceiveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class ReceiveServiceImpl implements IReceiveService {
    @Autowired
    ReceiveRepository receiveRepository;
    @Autowired
    InventoryRepository inventoryRepository;

    @Override
    public void save(List<CartRequest> cartRequests, Long storeId, int type, Orders orders) {
        for (CartRequest cart : cartRequests) {
            ReceiveStore receiveStore = new ReceiveStore();
            receiveStore.setOrders(orders);
            receiveStore.setSize(cart.getSize());
            receiveStore.setQuantity(cart.getQuantity());
            receiveStore.setProductId(cart.getId());
            receiveStore.setCreatedAt(Date.valueOf(LocalDate.now()));
            receiveStore.setLimitReceiveAt(Date.valueOf(LocalDate.now().plusDays(1)));
            receiveStore.setStatus(ReceiveStatus.ALREADY);

            // type = 0 cửa hàng đó hết hàng
            if (type == 0 && inventoryRepository.findByStore(cart.getId(), cart.getSize(), cart.getQuantity(), storeId) == null) {
                receiveStore.setLimitReceiveAt(Date.valueOf(LocalDate.now().plusDays(7)));
                receiveStore.setStatus(ReceiveStatus.OUT_OF_STOCK);
            }

            receiveRepository.save(receiveStore);
        }

    }
}
