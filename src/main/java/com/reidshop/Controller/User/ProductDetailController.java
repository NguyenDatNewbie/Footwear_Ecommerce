package com.reidshop.Controller.User;

import com.reidshop.Model.Entity.Evaluate;
import com.reidshop.Model.Entity.Image;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Reponsitory.*;
import com.reidshop.Service.IEvaluateServiceImpl;
import com.reidshop.Service.IImageService;
import com.reidshop.Service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping("/product")
public class ProductDetailController {
    @Autowired
    ProductRepository productRepository;
    @Autowired
    IProductService productService;
    @Autowired
    ImageRepository imageRepository;
    @Autowired
    SizeRepository sizeRepository;
    @Autowired
    EvaluateRepository evaluateRepository;
    @Autowired
    IEvaluateServiceImpl evaluateService;
    @Autowired
    AccountDetailRepository accountDetailRepository;
    @Autowired
    IImageService imageService;
    @Autowired
    ColorRepository colorRepository;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    @RequestMapping("/{productId}")
    String productDetail(ModelMap modelMap, @PathVariable Long productId){
        Product product = productRepository.findByProductId(productId);
        List<Evaluate> evaluateList = evaluateRepository.findAllByProductId(productId);
        double rateAvg = evaluateService.rateAvg(evaluateList);
        modelMap.addAttribute("formatVND",formatVND);

        modelMap.addAttribute("accountDetailRepository",accountDetailRepository);
        modelMap.addAttribute("productRepository",productRepository);
        modelMap.addAttribute("productService",productService);
        modelMap.addAttribute("rateAvg",rateAvg);
        modelMap.addAttribute("evaluateList",evaluateList);
        modelMap.addAttribute("evaluateService",evaluateService);
        modelMap.addAttribute("evaluateRepository",evaluateRepository);
        modelMap.addAttribute("sizeRepository",sizeRepository);
        modelMap.addAttribute("productCurrent",product);
        modelMap.addAttribute("imageRepository",imageRepository);
        modelMap.addAttribute("imageService",imageService);
        modelMap.addAttribute("colorRepository",colorRepository);
        List<Image> images = imageService.imageFirstOfColor(productId);
        modelMap.addAttribute("images",images);

        return "user/product-details";
    }

}
