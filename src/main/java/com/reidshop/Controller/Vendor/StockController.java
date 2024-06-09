package com.reidshop.Controller.Vendor;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Request.StockRequest;
import com.reidshop.Model.Response.StockProductResponse;
import com.reidshop.Reponsitory.*;
import com.reidshop.Service.IProductOutOfStockService;
import com.reidshop.Service.Impl.StockServiceImpl;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
@RequestMapping("/vendor/stock")
public class StockController {
    @Autowired
    ProductRepository productRepository;
    @Autowired
    SizeRepository sizeRepository;
    @Autowired
    SupplierRepository supplierRepository;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    JwtService jwtService;
    @Autowired
    StoreRepository storeRepository;
    @Autowired
    StockServiceImpl stockService;
    @Autowired
    InventoryRepository inventoryRepository;
    @Autowired
    AccountDetailRepository accountDetailRepository;
    @Autowired
    ProductOutOfStockRepository productOutOfStockRepository;
    @Autowired
    IProductOutOfStockService ofStockService;

    @GetMapping("")
    String index(ModelMap modelMap, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(null);
        Store store = storeRepository.searchAllByAccountId(account.getId());
        Long storeID = store.getId();

        AccountDetail accountDetail = accountDetailRepository.findAccountDetailByAccountId(account.getId());
//        List<ProductOutOfStock> outOfStocks = productOutOfStockRepository.findAllByStoreId(storeID);
        List<ProductOutOfStock> importProduct = ofStockService.listProductBySize(storeID);


        modelMap.addAttribute("accountDetail", accountDetail);
        modelMap.addAttribute("supplierRepository", supplierRepository);
        modelMap.addAttribute("inventoryRepository", inventoryRepository);
        modelMap.addAttribute("importProduct", importProduct);
        modelMap.addAttribute("storeID", storeID);

        return "vendor/stock";
    }

    @GetMapping("/getProduct")
    @ResponseBody
    List<StockProductResponse> getProductByQuery(@RequestParam String query){
        List<StockProductResponse> result = new ArrayList<>();
        List<Product> products = productRepository.searchProduct(query);
        for (Product product: products) {
            StockProductResponse productResponse = new StockProductResponse();
            productResponse.setName(product.getNameAndId());
            productResponse.setSizes(sizeRepository.findAllByProductId(product.getId()));
            result.add(productResponse);
        }
        return result;
    }

    @PostMapping("/save/{supplierId}")
    @ResponseBody
    ResponseEntity<?> save(@PathVariable long supplierId, @RequestBody List<StockRequest> stockRequests, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(new Account());
        Store store = storeRepository.searchAllByAccountId(account.getId());
        Supplier supplier = supplierRepository.findById(supplierId).orElse(null);
        String message = stockService.save(store,stockRequests,supplier);
        if(message.equals("success"))
            return ResponseEntity.status(HttpStatus.OK).body(message);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(message);
    }

    @GetMapping("/check/inventory")
    @ResponseBody
    Map<String,String> check(@RequestParam("id") long sizeId, HttpServletRequest request){
        String token = CookieHandle.getCookieValue(request, "token");
        String email = jwtService.extractUsername(token);
        Account account = accountRepository.findByEmail(email).orElse(new Account());
        int totalQuantity = inventoryRepository.totalInventory(sizeId,account.getId());
        Size size = sizeRepository.findById(sizeId).orElse(null);
        Map<String,String> result = new HashMap<>();
        result.put("quantity",String.valueOf(totalQuantity));
        result.put("size",size.getSize());
        result.put("product",size.getProduct().getName());
        return result;
    }
}
