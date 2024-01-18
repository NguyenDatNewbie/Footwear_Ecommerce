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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DistanceService {
    @Autowired
    IStoreService storeService;
    
    public StoreValidRequest getStoreDistanceMin(List<StoreValidRequest> stores, String origin,int status){
        StoreValidRequest min = stores.get(0)!=null ? stores.get(0) : new StoreValidRequest();
        for(int i =1;i<stores.size();i++)
        {
            if(stores.get(i).getStatus()!=status)
                continue;

            Long storeMin = Long.valueOf(getDistanceValue(origin, min.getStore().getDepartment()).get("value"));
            Long storeI = Long.valueOf(getDistanceValue(origin,stores.get(i).getStore().getDepartment()).get("value"));
            if(storeI==null)
                continue;
            if(storeMin==null){
                min=stores.get(i);
                continue;
            }

            if(storeMin>storeI && min.getStatus()==0)
                min = stores.get(i);
            else if(min.getStatus()==0 && stores.get(i).getStatus()==1)
                min = stores.get(i);
        }
        if(min.getStatus()!=1 && status==1)
            return getStoreDistanceMin(stores,origin,0);
        return min;
    }

    public Map<String,String> getDistanceValue(String origin, String destination){
        final String apiKey = "AIzaSyAUic2ta4mUKXuPpbszvDGMy1D8FosuFm8"; // Thay YOUR_API_KEY bằng khóa API của bạn
        Map<String,String> map = new HashMap<>();
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

                String text = json.getJSONArray("rows")
                        .getJSONObject(0)
                        .getJSONArray("elements")
                        .getJSONObject(0)
                        .getJSONObject("distance")
                        .getString("text");
                map.put("value", String.valueOf(distance));
                map.put("text",text);
            }

        } catch (Exception e) {
            System.out.println(e.getMessage()+"Sai");
        }
        return map;

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
        StoreValidRequest min = getStoreDistanceMin(storeValidRequests,address,1);
        Long distance = null;
        if (getDistanceValue(min.getStore().getDepartment(),address).get("value")!=null)
            distance = Long.valueOf(getDistanceValue(min.getStore().getDepartment(),address).get("value"));
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
