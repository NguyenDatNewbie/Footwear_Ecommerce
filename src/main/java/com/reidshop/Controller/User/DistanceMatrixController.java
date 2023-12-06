package com.reidshop.Controller.User;

import com.reidshop.Model.Request.StoreValidRequest;
import com.reidshop.Model.Response.DistanceResponse;
import com.reidshop.Model.Response.StoreValidResponse;
import com.reidshop.Service.Handle.DistanceService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
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
    @Autowired
    DistanceService distanceService;
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

    @PostMapping("/getCostShip/{ward}/{district}/{city}")
    public ResponseEntity<Double> getCost(@RequestBody List<StoreValidRequest> storeValidRequests, @PathVariable String city,
                                          @PathVariable String district,@PathVariable String ward) {
        if(ward=="" || ward==null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body((double)0);
        }
        double cost = distanceService.calCostShip(storeValidRequests,city,district,ward);
        return ResponseEntity.status(HttpStatus.OK).body(cost);
    }
}
