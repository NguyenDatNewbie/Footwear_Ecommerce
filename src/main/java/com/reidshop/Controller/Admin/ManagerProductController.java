package com.reidshop.Controller.Admin;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.reidshop.Model.Entity.Category;
import com.reidshop.Model.Entity.Image;
import com.reidshop.Model.Entity.Product;
import com.reidshop.Model.Entity.Size;
import com.reidshop.Reponsitory.*;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.*;

@Controller
@RequestMapping("admin/products")
public class ManagerProductController {
    @Autowired
    OrdersRepository ordersRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    SizeRepository sizeRepository;
    @Autowired
    ImageRepository imageRepository;
    @Autowired
    Cloudinary cloudinary;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String listProduct(ModelMap modelMap){
        List<Category> categoryList = categoryRepository.findAll();
        modelMap.addAttribute("categories",categoryList);
        modelMap.addAttribute("ordersRepository", ordersRepository);
        modelMap.addAttribute("productRepository", productRepository);
        modelMap.addAttribute("formatVND",formatVND);

        return "admin/products";
    }

    @PostMapping("addNewProduct")
    public ModelAndView addNewProduct(ModelMap model,
                                     @Valid @ModelAttribute("product") Product product,
                                      @RequestParam("category") Long categoryId,
                                      @RequestParam("color") String color,
                                      @RequestParam("selectedSizes") String selectedSizes,
                                      @RequestParam("image-file") MultipartFile[] imageFiles,
                                      BindingResult result) throws IOException {
        if(result.hasErrors()){
            System.out.println(result);
            return new ModelAndView("admin/detailOrEdit");
        }

        Category category = categoryRepository.findById(categoryId).orElse(null);
        //Thêm màu
        String name = product.getName() + " " + color;
        product.setName(name);
        product.setCategory(category);
        productRepository.save(product);

        //Xử lý hình ảnh, lưu vào cloud dinary

        System.out.println(imageFiles);
        try {
            for (MultipartFile imageFile : imageFiles){
                Map r = this.cloudinary.uploader().upload(imageFile.getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                String img = (String) r.get("secure_url");
                Image image = new Image();
                image.setImg(img);
                image.setProduct(product);
                imageRepository.save(image);
            }
        }catch (IOException e){
            e.printStackTrace();
        }



        //Add size
        String[] sizesArray = selectedSizes.split(",");
        for (String size : sizesArray){
            Size newSize = new Size();
            newSize.setProduct(product);
            newSize.setSize(size);
            sizeRepository.save(newSize);
        }

        return new ModelAndView("redirect:/admin/products", model);
    }

    @PostMapping("updateProduct")
    public ModelAndView updateProduct(ModelMap model,
                                      @Valid @ModelAttribute("product") Product product, BindingResult result){
        if(result.hasErrors()){
            return new ModelAndView("admin/detailOrEdit");
        }
        productRepository.save(product);

        return new ModelAndView("redirect:/admin/products", model);
    }

    @GetMapping("edit/{productId}")
    public ModelAndView edit(ModelMap model, @PathVariable("productId") Long productId){
        Optional<Product> opt = productRepository.findById(productId); //lấy đối tượng
        if (opt.isPresent()){
            Product product = opt.get();
            model.addAttribute("product", product);
            return new ModelAndView("admin/detailOrEdit", model);
        }

        return new ModelAndView("redirect:/admin/products", model);
    }
}
