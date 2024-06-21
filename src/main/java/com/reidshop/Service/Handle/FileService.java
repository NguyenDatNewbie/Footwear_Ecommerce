package com.reidshop.Service.Handle;

import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Request.StockRequest;
import com.reidshop.Reponsitory.ColorRepository;
import com.reidshop.Reponsitory.SizeRepository;
import com.reidshop.Reponsitory.StockRepository;
import com.reidshop.Reponsitory.SupplierRepository;
import com.reidshop.Service.IProductOutOfStockService;
import com.reidshop.Service.Impl.StockServiceImpl;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Service
public class FileService {
    @Autowired
    SupplierRepository supplierRepository;
    @Autowired
    StockRepository stockRepository;
    @Autowired
    SizeRepository sizeRepository;
    @Autowired
    ColorRepository colorRepository;
    @Autowired
    StockServiceImpl stockService;

    public void handleImportFile(MultipartFile file, Store store) {

        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) {
            Sheet sheet = workbook.getSheetAt(0);

            Long supplierId = Long.valueOf(sheet.getRow(1).getCell(2).getStringCellValue());
            Supplier supplier = supplierRepository.findById(supplierId).orElseThrow(() -> new io.jsonwebtoken.io.IOException("Value not found"));
            List<StockRequest> stockRequests = new ArrayList<>();

            int COL_PRODUCT = 1,
                    COL_COLOR = 3,
                    COL_SIZE = 5,
                    COL_QUANTITY = 6,
                    COL_PRICE = 7,
                    COL_PRIORITY =8;

            System.out.println(sheet.getLastRowNum());
            // Bắt đầu đọc từ dòng 8
            for (int i = 8; i <= sheet.getLastRowNum(); i++) {
                Row currentRow = sheet.getRow(i);
                StockRequest s = new StockRequest();

                if (currentRow != null) {
                    if(currentRow.getCell(COL_PRODUCT).getStringCellValue().equals("")){
                        break;
                    }

                    Size size = sizeRepository.findAllByProductIdAndSize
                            (Long.valueOf(currentRow.getCell(COL_PRODUCT).getStringCellValue()),
                                    currentRow.getCell(COL_SIZE).getStringCellValue());
                    Color color = colorRepository.findById(Long.valueOf(currentRow.getCell(COL_COLOR).getStringCellValue()))
                            .orElseThrow(() -> new io.jsonwebtoken.io.IOException("Wrong format"));
                    StockRequest.PriorityOrder priorityOrder = new StockRequest.PriorityOrder();
                    Long priorityId = 0L;
                    if(!currentRow.getCell(COL_PRIORITY).getStringCellValue().equals(""))
                        priorityId = Long.valueOf(currentRow.getCell(COL_PRIORITY).getStringCellValue());
                    priorityOrder.setId(priorityId);
                    int quantity = Integer.valueOf(currentRow.getCell(COL_QUANTITY).getStringCellValue());
                    double price =  Double.valueOf(currentRow.getCell(COL_PRICE).getStringCellValue());

                    s.setSize(size);
                    s.setQuantity(quantity);
                    s.setColor(color);
                    s.setPrice(price);
                    s.setSupplier(supplier);
                    s.setPriorityOrder(priorityOrder);

                    stockRequests.add(s);
                }
            }

            stockService.save(store,stockRequests,supplier);
        } catch (IOException e) {
            e.printStackTrace();
            // Handle the exception
        }
    }


}
