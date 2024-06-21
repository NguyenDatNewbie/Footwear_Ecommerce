package com.reidshop.Controller.Vendor;

import com.reidshop.Model.Cookie.CookieHandle;
import com.reidshop.Model.Entity.Account;
import com.reidshop.Model.Entity.ProductOutOfStock;
import com.reidshop.Model.Entity.Store;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.InventoryRepository;
import com.reidshop.Reponsitory.ProductOutOfStockRepository;
import com.reidshop.Reponsitory.StoreRepository;
import com.reidshop.Service.Handle.FileService;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.awt.print.Book;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.ByteArrayOutputStream;
import java.util.List;

@Controller
@RequestMapping("/excel")
public class ExcelController {
    @Autowired
    ProductOutOfStockRepository productOutOfStockRepository;
    @Autowired
    InventoryRepository inventoryRepository;
    @Autowired
    FileService fileService;
    @Autowired
    JwtService jwtService;
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    StoreRepository storeRepository;
    @GetMapping("/import")
    String index(){
        return "vendor/importFile";
    }
    @GetMapping("/download/sample")
    @ResponseBody
    ResponseEntity<FileSystemResource> downloadSample(){
        // Đường dẫn tới tệp Excel trên máy chủ
        File file = new File("src/main/webapp/common/sampleStock.xlsx");

        // Kiểm tra xem tệp có tồn tại không
        if (!file.exists()) {
            return ResponseEntity.notFound().build();
        }

        FileSystemResource resource = new FileSystemResource(file);

        // Xác định header để trình duyệt biết cách xử lý tệp
        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=sampleStock.xlsx");

        return ResponseEntity.ok()
                .headers(headers)
                .contentLength(file.length())
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(resource);
    }

    @PostMapping("/import/stock")
    String importFile(@RequestParam("file") MultipartFile file, HttpServletRequest request){
        try {
            String token = CookieHandle.getCookieValue(request, "token");
            String email = jwtService.extractUsername(token);
            Account account = accountRepository.findByEmail(email).orElse(null);
            Store store = storeRepository.findByAccountId(account.getId());
            fileService.handleImportFile(file,store);
             return "redirect:/excel/import?message=success";
        }
        catch (Exception exception)
        {
            return "redirect:/excel/import?message="+exception.getMessage();

        }
    }

    static CellStyle setStyleBolderCol(CellStyle style){
        style.setBorderTop(BorderStyle.THIN);
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        return style;
    }

    // Hàm để thiết lập màu xen kẻ cho từng cột (column stripe)
    private static void setColumnStripeColor(Sheet sheet, IndexedColors color1, IndexedColors color2) {
        int lastRowNum = sheet.getLastRowNum();
        if (lastRowNum > 0) {
            int numColumns = sheet.getRow(0).getLastCellNum();
            for (int col = 0; col < numColumns; col++) {
                for (int row = 0; row < lastRowNum; row++) {
                    CellStyle style = sheet.getRow(row).getCell(col).getCellStyle();
                    style = setStyleBolderCol(style);
                    if (row % 2 == 0) {
                        style.setFillForegroundColor(color1.getIndex());
                    } else {
                        style.setFillForegroundColor(color2.getIndex());
                    }
                    style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
                    sheet.getRow(row).getCell(col).setCellStyle(style);
                }
            }
        }
    }
    @GetMapping("/download")
    ResponseEntity<byte[]> exportExcelProductOutOfStock(@RequestParam("store") Long store){
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Data");

            List<ProductOutOfStock> productOutOfStocks = productOutOfStockRepository.findAllByStoreId(store);
            // Thiết lập định dạng cho header row
            CellStyle headerCellStyle = workbook.createCellStyle();
            headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
            headerCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.BLACK.getIndex());
            headerCellStyle.setFont(headerFont);

            String[][] data = new String[productOutOfStocks.size() + 1][10];
            Row headerRow = sheet.createRow(0);
            data[0] = new String[]{"ProductID", "ProductName", "OrderId","ColorId"
                    ,"ColorName","SizeId","Size","Quantity","Inventory","ReStock"};
            for (int i = 0; i < data[0].length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(data[0][i]);
                cell.setCellStyle(headerCellStyle);
            }

            for (int i = 0; i < productOutOfStocks.size(); i++) {
                ProductOutOfStock p = productOutOfStocks.get(i);
                data[i][0] = String.valueOf(p.getSize().getProduct().getId());
                data[i][1] = p.getSize().getProduct().getName();
                data[i][2] = String.valueOf(p.getOrders().getId());
                data[i][3] = String.valueOf(p.getColor().getId());
                data[i][4] = p.getColor().getColor_name();
                data[i][5] = String.valueOf(p.getSize().getId());
                data[i][6] = String.valueOf(p.getSize().getSize());
                data[i][7] = String.valueOf(p.getQuantity());
                int inventory = inventoryRepository.getQuantityOfProduct(store,p.getSize().getId(),p.getColor().getId());
                data[i][8] = String.valueOf(inventory);
                data[i][9] = String.valueOf(Math.abs(inventory-p.getQuantity()));

            }



            // Tạo các dòng và cột
            int rowCount = 1;
            sheet.autoSizeColumn(0);
            for (Object[] aP : data) {
                Row row = sheet.createRow(rowCount++);

                int columnCount = 0;

                for (Object field : aP) {
                    Cell cell = row.createCell(columnCount++);
                    if (field instanceof String) {
                        cell.setCellValue((String) field);
                    } else if (field instanceof Integer) {
                        cell.setCellValue((Integer) field);
                    }
                    cell.setCellStyle(workbook.createCellStyle());
                }
                sheet.autoSizeColumn(rowCount-1);
            }

            // Tự động điều chỉnh kích thước của cột để phù hợp với nội dung
            setColumnStripeColor(sheet, IndexedColors.LIGHT_GREEN, IndexedColors.WHITE);
            // Ghi dữ liệu vào output stream
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            workbook.write(out);
            ByteArrayInputStream in = new ByteArrayInputStream(out.toByteArray());

            // Đặt headers
            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Disposition", "attachment; filename=Data.xlsx");

            // Trả về file dưới dạng byte array
            return new ResponseEntity<>(in.readAllBytes(), headers, HttpStatus.OK);

        } catch (IOException e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
