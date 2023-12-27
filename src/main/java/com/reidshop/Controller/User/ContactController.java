package com.reidshop.Controller.User;

import com.reidshop.Model.Entity.Store;
import com.reidshop.Model.Mapper.StoreMapper;
import com.reidshop.Model.Request.ContactRequest;
import com.reidshop.Model.Response.StoreResponse;
import com.reidshop.Reponsitory.StoreRepository;
import com.reidshop.Service.IEmailService;
import jakarta.persistence.PreUpdate;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/contact")
public class ContactController {
    @Autowired
    IEmailService emailService;
    @Autowired
    StoreRepository storeRepository;
    final StoreMapper mapper;
    @GetMapping("")
    String index(){
        return "user/contact";
    }

    @PostMapping("/support")
    ModelAndView send(@ModelAttribute ContactRequest contactRequest){
        try {
            emailService.sendMessage(contactRequest);
            return new ModelAndView("user/contact");
        }
        catch (Exception exception){
            return new ModelAndView("user/contact");
        }
    }
    @GetMapping("/district/{value}")
    @ResponseBody
    List<String> getDistrict(@PathVariable String value){
        return storeRepository.findOneColDistrictByCity(value);
    }
    @GetMapping("/address")
    String showAddress(ModelMap modelMap){
        modelMap.addAttribute("storeRepository",storeRepository);
        return "user/address";
    }
    @GetMapping("/getStore")
    @ResponseBody
    List<StoreResponse> findStoresByDepartment(@RequestParam("address") String department){
        List<Store> stores = storeRepository.searchAllByDepartment(department);
        return mapper.toListResponse(stores);
    }
}
