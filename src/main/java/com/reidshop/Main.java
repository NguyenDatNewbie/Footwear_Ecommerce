package com.reidshop;

import java.util.*;
public class Main {
    public static void main(String[] args) {
        List<Object[]> resultFromQuery = new ArrayList<>();
        resultFromQuery.add(new Object[]{0L, 0L, 5.0});
        resultFromQuery.add(new Object[]{0L, 1L, 4.0});
        resultFromQuery.add(new Object[]{0L, 3L, 2.0});
        resultFromQuery.add(new Object[]{0L, 4L, 2.0});

        resultFromQuery.add(new Object[]{1L, 0L, 5.0});
        resultFromQuery.add(new Object[]{1L, 2L, 4.0});
        resultFromQuery.add(new Object[]{1L, 3L, 2.0});
        resultFromQuery.add(new Object[]{1L, 4L, 0.0});

        resultFromQuery.add(new Object[]{2L, 0L, 2.0});
        resultFromQuery.add(new Object[]{2L, 2L, 1.0});
        resultFromQuery.add(new Object[]{2L, 3L, 3.0});
        resultFromQuery.add(new Object[]{2L, 4L, 4.0});

        resultFromQuery.add(new Object[]{3L, 0L, 0.0});
        resultFromQuery.add(new Object[]{3L, 1L, 0.0});
        resultFromQuery.add(new Object[]{3L, 3L, 4.0});

        resultFromQuery.add(new Object[]{4L, 0L, 0.0});
        resultFromQuery.add(new Object[]{4L, 3L, 4.0});

        resultFromQuery.add(new Object[]{5L, 1L, 2.0});
        resultFromQuery.add(new Object[]{5L, 2L, 1.0});

        resultFromQuery.add(new Object[]{6L, 2L, 1.0});
        resultFromQuery.add(new Object[]{6L, 3L, 4.0});
        resultFromQuery.add(new Object[]{6L, 4L, 5.0});


        Map<Long, Map<Long, Double>> matrix = buildMatrix(resultFromQuery);
        printMatrix(matrix);

        // Tạo ma trận similarity từ ma trận rating
        Map<Long, Map<Long, Double>> similarityMatrix = createSimilarityMatrix(matrix);
        printMatrix(similarityMatrix);
        System.out.println("Result");
        printMatrix(calculatorNormalizedRatingsNull(matrix,similarityMatrix));
    }
    public static Map<Long, Map<Long, Double>> calculatorNormalizedRatingsNull(Map<Long, Map<Long, Double>> matrix,
                                                                               Map<Long, Map<Long, Double>> similarityMatrix){
        for (Long accountId : matrix.keySet()) {
            Map<Long, Double> productRatings = matrix.get(accountId);
            for(Long productId : productRatings.keySet()){
                Double valueRate = productRatings.get(productId);
                if(valueRate==null)
                {
                    Map<Long, Map<Double, Double>> ratedProduct = new HashMap<>();
                    for (Long accountId2 : matrix.keySet()){
                        Map<Long, Double> productRatings2 = matrix.get(accountId2);
                        if(productRatings2.get(productId)!=null){
                            Map<Double,Double> value = new HashMap<>();
                            value.put(productRatings2.get(productId),similarityMatrix.get(accountId).get(accountId2));
                            ratedProduct.put(accountId2,value);
                        }
                    }
                    Map<Long, Map<Double, Double>> sortedRatedProduct = sortByValue(ratedProduct);
                    Double calculator = calculatorNormalizedRatings(sortedRatedProduct);
                    matrix.get(accountId).replace(productId,calculator);
                }
            }
        }
        return matrix;
    }

    public static <K, V extends Comparable<? super V>> Map<K, Map<Double, Double>> sortByValue(Map<K, Map<Double, Double>> map) {
        List<Map.Entry<K, Map<Double, Double>>> list = new LinkedList<>(map.entrySet());

        // Sử dụng Comparator để so sánh các giá trị double
        Comparator<Map.Entry<K, Map<Double, Double>>> valueComparator = new Comparator<Map.Entry<K, Map<Double, Double>>>() {
            @Override
            public int compare(Map.Entry<K, Map<Double, Double>> o1, Map.Entry<K, Map<Double, Double>> o2) {
                Double value1 = o1.getValue().values().stream().findFirst().orElse(0.0);
                Double value2 = o2.getValue().values().stream().findFirst().orElse(0.0);
                return value2.compareTo(value1); // Sắp xếp giảm dần
            }
        };

        // Sắp xếp danh sách các cặp key-value dựa trên giá trị double cuối cùng
        Collections.sort(list, valueComparator);

        // Tạo một LinkedHashMap mới để lưu trữ các cặp key-value đã được sắp xếp
        Map<K, Map<Double, Double>> sortedMap = new LinkedHashMap<>();
        for (Map.Entry<K, Map<Double, Double>> entry : list) {
            sortedMap.put(entry.getKey(), entry.getValue());
        }

        return sortedMap;
    }
    public static Double calculatorNormalizedRatings(Map<Long, Map<Double, Double>> sortedRatedProduct){
        int i=0;
        double tu = 0;
        double mau = 0;
        for (Long accountId : sortedRatedProduct.keySet()){
            if(i==2)
                break;
            Map<Double, Double> value = sortedRatedProduct.get(accountId);
            for (Double normalized : value.keySet()) {
                tu += normalized*value.get(normalized);
                mau += Math.abs(value.get(normalized));
            }
            i++;
        }
        double epsilon = 1e-10; // Ngưỡng cho số cực nhỏ gần = 0
        if (Math.abs(mau) < epsilon) {
            mau = epsilon;
        }
        return tu / mau;
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
    private static Map<Long, Map<Long, Double>> createSimilarityMatrix(Map<Long, Map<Long, Double>> matrix) {
        Map<Long, Map<Long, Double>> similarityMatrix = new HashMap<>();
        for (Map.Entry<Long, Map<Long, Double>> rowEntry : matrix.entrySet()) {
            Long accountId1 = rowEntry.getKey();
            Map<Long, Double> ratings1 = rowEntry.getValue();

            similarityMatrix.put(accountId1, new HashMap<>());
            for (Map.Entry<Long, Map<Long, Double>> colEntry : matrix.entrySet()) {
                Long accountId2 = colEntry.getKey();
                Map<Long, Double> ratings2 = colEntry.getValue();

                Double similarity = cosineSimilarity(ratings1, ratings2);
                similarityMatrix.get(accountId1).put(accountId2, similarity);
            }
        }
        return similarityMatrix;
    }
    private static Double cosineSimilarity(Map<Long, Double> v1, Map<Long, Double> v2) {
        // Xác định các sản phẩm được cả hai người dùng đánh giá
        Set<Long> commonItems = new HashSet<>(v1.keySet());
        commonItems.retainAll(v2.keySet());

        // Nếu không có sản phẩm chung, trả về 0
        if (commonItems.isEmpty()) {
            return 0.0;
        }

        Double dotProduct = 0.0;
        Double normV1 = 0.0;
        Double normV2 = 0.0;

        for (Long item : commonItems) {
            Double rating1 = v1.get(item);
            Double rating2 = v2.get(item);
            if(rating1==null)
                rating1 = 0.0;
            if(rating2==null)
                rating2 = 0.0;
            dotProduct += rating1 * rating2;
            normV1 += Math.pow(rating1, 2);
            normV2 += Math.pow(rating2, 2);
        }

        // Tránh lỗi chia cho 0
        if (normV1 == 0 || normV2 == 0) {
            return 0.0;
        }

        return dotProduct / (Math.sqrt(normV1) * Math.sqrt(normV2));
    }

}
