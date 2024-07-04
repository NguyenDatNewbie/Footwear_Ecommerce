package com.reidshop.Controller.Admin;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Enum.OrderStatus;
import com.reidshop.Reponsitory.*;
import com.reidshop.Service.IProductService;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
    ProductRepository productRepository;
    @Autowired
    IProductService productService;
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
        modelMap.addAttribute("productService", productService);
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
                                      @RequestParam("video-file") MultipartFile[] videoFiles,
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
        product.setEnable(true);
        productRepository.save(product);

        //Xử lý hình ảnh, lưu vào cloud dinary

        System.out.println(imageFiles);
        try {
            for (MultipartFile imageFile : imageFiles){
                if (!imageFile.isEmpty()) {
                    Image image = new Image();
                    Color color1 = new Color();
                    color1.setId(1L);
                    Map r = this.cloudinary.uploader().upload(imageFile.getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                    String img = (String) r.get("secure_url");
                    image.setImg(img);
                    image.setProduct(product);
                    image.setColor(color1);
                    imageRepository.save(image);
                }
            }
        }catch (IOException e){
            e.printStackTrace();
        }

        //Xử lý video và lưu lên cloudinary

        System.out.println(videoFiles);
        try {
            for (MultipartFile videoFile : videoFiles){
                if (!videoFile.isEmpty()){
                    Image image = new Image();
                    Color color1 = new Color();
                    color1.setId(1L);
                    Map r = this.cloudinary.uploader().upload(videoFile.getBytes(), ObjectUtils.asMap("resource_type", "video"));
                    String img = (String) r.get("secure_url");
                    image.setImg(img);
                    image.setProduct(product);
                    image.setColor(color1);
                    imageRepository.save(image);
                }
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
    @Transactional
    public ModelAndView updateProduct(ModelMap model,
                                      @Valid @ModelAttribute("product") Product product,
                                      @RequestParam("category") Long categoryId,
                                      @RequestParam("selectedSizes") String selectedSizes,
                                      @RequestParam("image-file") MultipartFile[] imageFiles,
                                      @RequestParam("video-file") MultipartFile[] videoFiles,
                                      BindingResult result){
        if(result.hasErrors()){
            return new ModelAndView("admin/detailOrEdit");
        }
        //Set category
        Category category = categoryRepository.findById(categoryId).orElse(null);
        product.setCategory(category);

//        List<Size> sizeOfProID = sizeRepository.findAllByProductId(product.getId());

        //Xóa size của product

        //Thêm size mới
        String[] sizesArray = selectedSizes.split(",");

        if (sizesArray.length == 0 || (sizesArray.length == 1 && sizesArray[0].isEmpty())){
            System.out.println("Kooong thêm size");
        }else {
            sizeRepository.deleteByProductId(product.getId());
            for (String size : sizesArray){
                Size newSize = new Size();
                newSize.setProduct(product);
                newSize.setSize(size);
                sizeRepository.save(newSize);
            }
        }


//        Add new Image
        try {
            for (MultipartFile imageFile : imageFiles){
                if (!imageFile.isEmpty()){
                    Color color1 = new Color();
                    color1.setId(1L);
                    Image image = new Image();
                    Map r = this.cloudinary.uploader().upload(imageFile.getBytes(), ObjectUtils.asMap("resource_type", "auto"));
                    String img = (String) r.get("secure_url");
                    image.setImg(img);
                    image.setProduct(product);
                    image.setColor(color1);
                    imageRepository.save(image);
                }
            }
        }catch (IOException e){
            e.printStackTrace();
        }

        System.out.println(videoFiles);
        try {
            for (MultipartFile videoFile : videoFiles){
                if (!videoFile.isEmpty()){
                    Image image = new Image();
                    Color color1 = new Color();
                    color1.setId(1L);
                    Map r = this.cloudinary.uploader().upload(videoFile.getBytes(), ObjectUtils.asMap("resource_type", "video"));
                    String img = (String) r.get("secure_url");
                    image.setImg(img);
                    image.setProduct(product);
                    image.setColor(color1);
                    imageRepository.save(image);
                }
            }
        }catch (IOException e){
            e.printStackTrace();
        }

        //Update product
        productRepository.save(product);

        return new ModelAndView("redirect:/admin/products", model);
    }

    @GetMapping("edit/{productId}")
    public ModelAndView edit(ModelMap model, @PathVariable("productId") Long productId) {
        Optional<Product> opt = productRepository.findByIdAtAdmin(productId); //lấy đối tượng

        //All Size
        List<String> allSizes = Arrays.asList("38", "39", "40", "41", "42", "43");
        List<Category> categoryList = categoryRepository.findAll();
        List<Size> sizeOfProID = sizeRepository.findAllByProductId(productId);
        List<Image> imagesPro = imageRepository.findAllByProduct(productId);


        if (opt.isPresent()) {
            Product product = opt.get();
            Map<String, Boolean> sizeCheckedMap = new HashMap<>();
            allSizes.forEach(size -> sizeCheckedMap.put(size, false));
            sizeOfProID.stream()
                    .filter(size -> allSizes.contains(size.getSize()))
                    .forEach(size -> sizeCheckedMap.put(size.getSize(), true));


            model.addAttribute("product", product);
            model.addAttribute("imagesPro", imagesPro);
            model.addAttribute("allSizes", allSizes);   //All size
            model.addAttribute("sizeOfProID", sizeOfProID); //Size của product
            model.addAttribute("sizeCheckedMap", sizeCheckedMap);
            model.addAttribute("categories", categoryList);
            return new ModelAndView("admin/detailOrEdit", model);
        }
        return new ModelAndView("redirect:/admin/products", model);
    }

    @GetMapping("delete-image/{imageId}")
    public ModelAndView deleteImage(ModelMap model, @PathVariable("imageId") Long imageId) {
        Optional<Image> image = imageRepository.findById(imageId);
        if (image.isPresent()) {
            Long productID = image.get().getProduct(); //lay productID
            String imageUrl = image.get().getImg();    //lấy đường dẫn của ảnh trên cloudinary
            String publicID = extractPublicId(imageUrl);

            System.out.println("publicID: " + publicID);
            System.out.println("imageUrl: " + imageUrl);

            try {
                boolean isVideo = imageUrl.contains("/video");
                Map result;
                if (isVideo){
                    //Xóa video
                    result = cloudinary.uploader().destroy(publicID, ObjectUtils.asMap("resource_type", "video"));
                } else {
                    //Xóa ảnh
                    result = cloudinary.uploader().destroy(publicID, ObjectUtils.emptyMap());
                }

                // Kiểm tra kết quả xóa ảnh từ Cloudinary
                if (result.get("result").equals("ok")) {
                    imageRepository.deleteById(imageId);
                    System.out.println("Đã xóa ảnh từ Cloudinary");
                } else {
                    System.out.println("Lỗi xóa ảnh từ Cloudinary");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            return new ModelAndView("redirect:/admin/products/edit/" + productID, model);
        }
        return new ModelAndView("redirect:/admin/products/", model);
    }
    private static String extractPublicId(String imageUrl) {
        String[] parts = imageUrl.split("/");
        String lastPart = parts[parts.length - 1];
        String publicId = lastPart.split("\\.")[0];

        System.out.println(publicId);
        return publicId;
    }
}
