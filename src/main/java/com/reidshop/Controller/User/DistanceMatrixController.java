package com.reidshop.Controller.User;

import com.reidshop.Model.Response.DistanceResponse;
import org.json.JSONObject;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
public class DistanceMatrixController {

    @GetMapping("/getDistances/{origin}/{destination}")
    public ResponseEntity<String> getDistances(@PathVariable String origin,@PathVariable String destination) {
        final String apiKey = "AIzaSyAUic2ta4mUKXuPpbszvDGMy1D8FosuFm8"; // Thay YOUR_API_KEY bằng khóa API của bạn
        String message;

        try {
            String url = "https://maps.googleapis.com/maps/api/distancematrix/json"
                    + "?origins=" + origin
                    + "&destinations=" + destination
                    + "&language=vi-VN&units=metric&key=" + apiKey;
            ResponseEntity<DistanceResponse> response = new RestTemplate().exchange(url, HttpMethod.GET, null, DistanceResponse.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                JSONObject json = new JSONObject(response.getBody());

                String distance = json.getJSONArray("rows")
                        .getJSONObject(0)
                        .getJSONArray("elements")
                        .getJSONObject(0)
                        .getJSONObject("distance")
                        .getString("text");
                message = "Khoảng cách từ " + origin + " đến " + destination + ": " + distance;
            } else {
                message = "Không thể lấy thông tin khoảng cách từ " + origin + " đến " + destination;
            }
            return ResponseEntity.status(HttpStatus.OK).body(message);
        } catch (Exception e) {
            message = "Đã xảy ra lỗi khi tìm khoảng cách từ " + origin + " đến " + destination + ": " + e.getMessage();
            return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(message);
        }
    }
}
