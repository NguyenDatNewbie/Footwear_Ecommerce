package com.reidshop;//package com.reidshop;
//
//import com.reidshop.Model.Entity.Account;
//import com.reidshop.Reponsitory.AccountRepository;
//import com.reidshop.Reponsitory.EvaluateRepository;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.SpringApplication;
//import org.springframework.boot.autoconfigure.SpringBootApplication;
//
import com.reidshop.Model.Entity.Account;
import com.reidshop.ReidShopApplication;
import com.reidshop.Reponsitory.AccountRepository;
import com.reidshop.Reponsitory.EvaluateRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.*;

public class main2 {
    public static void main(String[] args) {
        // Giả sử có danh sách kết quả trả về từ truy vấn
        List<Object[]> resultFromQuery = new ArrayList<>();
        resultFromQuery.add(new Object[]{1L, 1L, 4.5});
        resultFromQuery.add(new Object[]{1L, 2L, 3.8});
        resultFromQuery.add(new Object[]{2L, 2L, 4.2});
        resultFromQuery.add(new Object[]{3L, 3L, 4.2});

        // Tạo ma trận
        Map<Long, Map<Long, Double>> matrix = buildMatrix(resultFromQuery);

        // In ma trận
        printMatrix(matrix);
    }

    public static Map<Long, Map<Long, Double>> buildMatrix(List<Object[]> result) {
        Map<Long, Map<Long, Double>> matrix = new HashMap<>();

        // Tạo một danh sách chứa tất cả các sản phẩm
        Set<Long> allProducts = new HashSet<>();
        for (Object[] row : result) {
            Long productId = (Long) row[1];
            allProducts.add(productId);
        }

        for (Object[] row : result) {
            Long accountId = (Long) row[0];
            Long productId = (Long) row[1];
            Double avgRate = (Double) row[2];
            if (!matrix.containsKey(accountId)) {
                matrix.put(accountId, new HashMap<>());
            }
            matrix.get(accountId).put(productId, avgRate);
        }

        // Đặt giá trị mặc định là 0 cho các sản phẩm mà không có đánh giá
        for (Long accountId : matrix.keySet()) {
            Map<Long, Double> productRatings = matrix.get(accountId);
            double sum = 0.0;
            for(Long productId : productRatings.keySet()){
                sum += productRatings.get(productId);
            }

            double avg = sum/productRatings.size();

            for(Long productId : productRatings.keySet()){
                productRatings.replace(productId,productRatings.get(productId) - avg);
            }
            for (Long productId : allProducts) {
                productRatings.putIfAbsent(productId, null);
            }
        }

        return matrix;
    }
    public static void printMatrix(Map<Long, Map<Long, Double>> matrix) {
        for (Map.Entry<Long, Map<Long, Double>> entry : matrix.entrySet()) {
            Long accountId = entry.getKey();
            Map<Long, Double> productRatings = entry.getValue();

            System.out.print(accountId + ": ");
            for (Map.Entry<Long, Double> productRatingEntry : productRatings.entrySet()) {
                Long productId = productRatingEntry.getKey();
                Double avgRate = productRatingEntry.getValue();

                System.out.print("(" + productId + ", " + avgRate + ") ");
            }
            System.out.println();
        }
    }

}
