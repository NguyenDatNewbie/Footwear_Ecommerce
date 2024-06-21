package com.reidshop.Controller.User;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.reidshop.Model.Entity.Evaluate;
import com.reidshop.Model.Entity.Image;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Reponsitory.*;
import com.reidshop.Service.Handle.CollaborativeFiltering;
import com.reidshop.Service.IEvaluateServiceImpl;
import com.reidshop.Service.IImageService;
import com.reidshop.Service.IProductService;
import com.reidshop.security.JwtService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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
    @Autowired
    Cloudinary cloudinary;
    @Autowired
    JwtService jwtService;
    @Autowired
    CollaborativeFiltering collaborativeFiltering;
    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);

    @GetMapping("")
    String productDetail(ModelMap modelMap, @RequestParam("id") Long productId, HttpServletRequest request){
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

//        List<Product> products = collaborativeFiltering.collaborativeFilter(null,false,product);
//        if(products.size()<4)
//            modelMap.addAttribute("productCategory",productService.findAllSimilarityProductByCategory(product.getCategory()));
//        else
//            modelMap.addAttribute("productCategory",products);
        List<Product> productsCategory = productService.findAllSimilarityProductByCategory(product.getCategory());
        productsCategory.removeIf(item -> item.getId().equals(productId));

        modelMap.addAttribute("productCategory",productsCategory);
        Long colorFirst = imageRepository.findColorOther(productId).get(0);
        List<Image> images = imageRepository.findAllByProductAndColor(colorFirst,productId);
        modelMap.addAttribute("images",images);
        return "user/product-details";
    }
    @GetMapping("/images")
    @ResponseBody
    List<Image> findImagesByProductAndColor(@RequestParam("product") Long productId, @RequestParam("color") Long colorId){
        return imageRepository.findAllByProductAndColor(colorId,productId);
    }
    @PostMapping("/measurement")
    @ResponseBody
    String measurement(@RequestParam("file") MultipartFile imageFiles){
        String img = null;
        try {
            Map r = this.cloudinary.uploader().upload(imageFiles.getBytes(), ObjectUtils.asMap("resource_type", "auto"));
            img = (String) r.get("secure_url");
        }catch (IOException e){
            e.printStackTrace();
            return null;
        }
        RestTemplate restTemplate = new RestTemplate();

        // Xây dựng URL của API với tham số truyền vào
        String apiUrl = "http://127.0.0.1:5000/calculate_feet_size";
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(apiUrl)
                .queryParam("image_url", img);

        // Gửi yêu cầu POST tới API và nhận response
        Map<String, Double> response = restTemplate.getForObject(builder.toUriString(), Map.class);
        // Truy cập và in kết quả
        Double feetSizeCm = response.get("feet_size_cm");
        String roundedNumber = String.format("%." + 1 + "f", feetSizeCm);
        return roundedNumber;
    }
    @GetMapping("/query")
    @ResponseBody
    List<Product> findBySize(@RequestParam("size") String size){
        Pageable pageable = PageRequest.of(0, 10);
        Page<Product> productPageable = sizeRepository.findBySize(size,pageable);
        return productPageable.getContent();
    }
}
