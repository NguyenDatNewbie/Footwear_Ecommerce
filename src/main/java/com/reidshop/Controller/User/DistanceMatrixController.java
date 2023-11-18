package com.reidshop.Controller.User;

import org.json.JSONObject;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
public class DistanceMatrixController {

    @GetMapping("/getDistances")
    public List<String> getDistances() {
        final String apiKey = "AIzaSyCALRft4mYsyiQ2mKPq20gfk452Gz2u2xU"; // Thay YOUR_API_KEY bằng khóa API của bạn
        final String origins = "Sư phạm kỹ thuật"; // Điểm bắt đầu
        final List<String> destinations = Arrays.asList(
                "63 Linh Trung, Thủ Đức",
                "63 Linh Trung, Thủ Đức"
                // Thêm các địa chỉ đích khác vào danh sách destinations
        );

        List<String> distances = new ArrayList<>();

        for (String destination : destinations) {
            try {
                String url = "https://maps.googleapis.com/maps/api/distancematrix/json"
                        + "?origins=" + origins
                        + "&destinations=" + destination
                        + "&language=vi-VN&units=metric&key=" + apiKey;
                ResponseEntity<String> response = new RestTemplate().exchange(url, HttpMethod.GET, null, String.class);

                if (response.getStatusCode() == HttpStatus.OK) {
                    JSONObject json = new JSONObject(response.getBody());
                    String distance = json.getJSONArray("rows")
                            .getJSONObject(0)
                            .getJSONArray("elements")
                            .getJSONObject(0)
                            .getJSONObject("distance")
                            .getString("text");
                    distances.add("Khoảng cách từ " + origins + " đến " + destination + ": " + distance);
                } else {
                    distances.add("Không thể lấy thông tin khoảng cách từ " + origins + " đến " + destination);
                }
            } catch (Exception e) {
                distances.add("Đã xảy ra lỗi khi tìm khoảng cách từ " + origins + " đến " + destination + ": " + e.getMessage());
            }
        }

        return distances;
    }
}
