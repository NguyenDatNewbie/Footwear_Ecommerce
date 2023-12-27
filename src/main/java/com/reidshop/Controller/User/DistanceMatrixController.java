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
import java.util.Map;

@RestController
public class DistanceMatrixController {
    @Autowired
    DistanceService distanceService;
    @GetMapping("/getDistances/{origin}/{destination}")
    @ResponseBody
    public Map<String,String> getDistances(@PathVariable String origin, @PathVariable String destination) {
        return  distanceService.getDistanceValue(origin,destination);
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
