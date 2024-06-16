package com.reidshop.Controller.User;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@RestController
@RequestMapping("/api")
public class APICostShipController {
    private String apiToken = "eyJhbGciOiJFUzI1NiJ9.eyJzdWIiOiIwMzM1NDQxODk1IiwiVXNlcklkIjoxNDE1NjA0OCwiRnJvbVNvdXJjZSI6NSwiVG9rZW4iOiJVSzZVMjVYNVgxWUIiLCJleHAiOjE3MTczMTcyMTMsIlBhcnRuZXIiOjE0MTU2MDQ4fQ.-1H53035Jkqd9_EKpksi3gbhTs5gbztukYLOACFCCNS4IWdV4fPZoxf3JS-IoFcMyqWf-THwiosqQB30bqczrw";
    @GetMapping("/listProvinceById")
    public String listProvinceById() {
        String apiUrl = "https://partner.viettelpost.vn/v2/categories/listProvinceById?provinceId=0";
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForObject(apiUrl, String.class);
    }
    @GetMapping("/listDistrictById")
    public String listDistrictById(@RequestParam("provinceId") int provinceId){
        String apiUrl = "https://partner.viettelpost.vn/v2/categories/listDistrict?provinceId=" + provinceId;
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForObject(apiUrl, String.class);
    }
    @GetMapping("/listWardsById")
    public String listWardsById(@RequestParam("districtId") int districtId){
        String apiUrl = "https://partner.viettelpost.vn/v2/categories/listWards?districtId=" + districtId;
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForObject(apiUrl, String.class);
    }

    @PostMapping("/getPrice")
    public String getPrice(@RequestBody Map<String, Object> priceRequest){
        String apiUrl = "https://partner.viettelpost.vn/v2/order/getPrice";
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.set("Token", apiToken); // Thêm token vào header

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(priceRequest, headers);

        ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.POST, request, String.class);

        return response.getBody();
    }

    @PostMapping("/getPriceNlp")
    public String getPriceWithTextAddress(@RequestBody Map<String, Object> priceRequest){
        String apiUrl = "https://partner.viettelpost.vn/v2/order/getPriceNlp";
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.set("Token", apiToken); // Thêm token vào header

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(priceRequest, headers);

        ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.POST, request, String.class);

        return response.getBody();
    }

    @PostMapping("/getPriceAllNlp")
    public String getAllServiceWithTextAddress(@RequestBody Map<String, Object> priceRequest){
        String apiUrl = "https://partner.viettelpost.vn/v2/order/getPriceAllNlp";
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.set("Token", apiToken); // Thêm token vào header

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(priceRequest, headers);

        ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.POST, request, String.class);

        return response.getBody();
    }
}