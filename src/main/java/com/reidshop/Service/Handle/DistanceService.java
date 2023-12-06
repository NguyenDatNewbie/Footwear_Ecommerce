package com.reidshop.Service.Handle;

import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Request.StoreValidRequest;
import com.reidshop.Model.Response.DistanceResponse;
import com.reidshop.Model.Response.StoreResponse;
import com.reidshop.Service.IStoreService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Service
public class DistanceService {
    @Autowired
    IStoreService storeService;
    
    public StoreValidRequest getStoreDistanceMin(List<StoreValidRequest> stores, String origin){
        StoreValidRequest min = stores.get(0)!=null ? stores.get(0) : new StoreValidRequest();
        for(int i =1;i<stores.size();i++)
        {
            Long storeMin = getDistanceValue(origin, min.getStore().getDepartment());
            Long storeI = getDistanceValue(origin,stores.get(i).getStore().getDepartment());
            if(storeI==null)
                continue;
            if(storeMin==null){
                min=stores.get(i);
                continue;
            }
            if(storeMin>storeI)
            {
                min = stores.get(i);
            }
        }
        return min;
    }
    
    Long getDistanceValue(String origin,String destination){
        final String apiKey = "AIzaSyAUic2ta4mUKXuPpbszvDGMy1D8FosuFm8"; // Thay YOUR_API_KEY bằng khóa API của bạn
        Long distanceValue = null;

        try {
            String url = "https://maps.googleapis.com/maps/api/distancematrix/json"
                    + "?origins=" + origin
                    + "&destinations=" + destination
                    + "&language=vi-VN&units=metric&key=" + apiKey;
            ResponseEntity<DistanceResponse> response = new RestTemplate().exchange(url, HttpMethod.GET, null, DistanceResponse.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                JSONObject json = new JSONObject(response.getBody());

                Long distance = json.getJSONArray("rows")
                        .getJSONObject(0)
                        .getJSONArray("elements")
                        .getJSONObject(0)
                        .getJSONObject("distance")
                        .getLong("value");
                distanceValue= distance;
            } 
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return distanceValue;
    }

    public double calCostShip(List<StoreValidRequest> storeValidRequests,String city,String district, String ward){
        String address = "";
        if(city!=null && !city.isEmpty()) {
            address = city;
            if(district!=null && !district.isEmpty()) {
                address = district + ", " + city;
                if(ward!=null && !ward.isEmpty())
                    address = ward+", " + district + ", " + city;
            }
        }
        StoreValidRequest min = getStoreDistanceMin(storeValidRequests,address);
        Long distance = getDistanceValue(min.getStore().getDepartment(),address);
        if(distance==null)
            distance= Long.valueOf(0);
        if(distance<=2500){
            return 25000;
        }
        if(distance<5000)
            return 30000;
        if(distance<10000)
            return 35000;
        if(distance<15000) // 30km
            return 3*distance;
        return 50000;
    }
}
