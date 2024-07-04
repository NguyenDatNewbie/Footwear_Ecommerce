package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.Vourcher;
import com.reidshop.Reponsitory.VoucherRepository;
import com.reidshop.Service.IVoucherService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Locale;
import java.util.Optional;

@Controller
@RequestMapping("/admin/voucher")
public class VoucherController {
    @Autowired
    IVoucherService voucherService;

    @Autowired
    VoucherRepository voucherRepository;
    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy", locale);
    NumberFormat formatterDecimal = new DecimalFormat("#0");
    @RequestMapping
    public String index(ModelMap modelMap) {
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("dateFormat",dateFormat);
        modelMap.addAttribute("formatterDecimal",formatterDecimal);
        modelMap.addAttribute("voucherService", voucherService);
        return "admin/voucher";
    }

    @PostMapping("addNewVoucher")
    public ModelAndView addNewVoucher(ModelMap modelMap,
                                      @Valid @ModelAttribute("voucher")Vourcher vourcher,
                                      @RequestParam("expirationDateFormatYet") Date expirationDateFormatYet,
                                      BindingResult result) {
        if(result.hasErrors()){
            System.out.println(result);
            return new ModelAndView("admin/voucher");
        }

        System.out.println(vourcher);

        Optional<Vourcher> opt = voucherRepository.findByVoucherCode(vourcher.getVoucherCode());

        try {
            if (opt.isPresent()){
                System.out.println("Đã tồn tại voucher này");
                String errorMessage = "The voucher code already exists. Please enter a different voucher.";
                modelMap.addAttribute("errorMessage", "The voucher code already exists. Please enter a different voucher.");
                return new ModelAndView("redirect:/admin/voucher?error=" + URLEncoder.encode(errorMessage, StandardCharsets.UTF_8));
            } else {
                vourcher.setVoucherCode(vourcher.getVoucherCode().toUpperCase()); //uppercase voucher
                LocalDate localDate = LocalDate.now();
                java.sql.Date currentDate = java.sql.Date.valueOf(localDate);

                vourcher.setCreatedAt(currentDate);

                vourcher.setExpirationDate(expirationDateFormatYet);

                voucherRepository.save(vourcher);
                System.out.println("Tạo voucher mới");
                String successMessage = "Create new voucher successfully.";
                return new ModelAndView("redirect:/admin/voucher?success=" + URLEncoder.encode(successMessage, StandardCharsets.UTF_8), modelMap);
            }
        }catch (Exception e){
            throw new RuntimeException(e);
        }
    }
    @GetMapping("/edit/{voucherId}")
    public ModelAndView edit(ModelMap model, @PathVariable("voucherId") Long voucherId){
        Optional<Vourcher> opt = voucherRepository.findById(voucherId);

        if (opt.isPresent()){
            Vourcher vourcher = opt.get();
            model.addAttribute("voucher", vourcher);
            model.addAttribute("dateFormat",dateFormat);
            return new ModelAndView("admin/voucherDetail", model);
        }
        return new ModelAndView("redirect:/admin/voucher", model);
    }
    @PostMapping("updateVoucher")
    public ModelAndView updateVoucher(ModelMap modelMap,
                                      @Valid @ModelAttribute("voucher")Vourcher vourcher,
                                      @RequestParam("expirationDateFormatYet") Date expirationDateFormatYet,
                                      BindingResult result) {
        if(result.hasErrors()){
            System.out.println(result);
            return new ModelAndView("admin/voucher");
        }

        try {
                vourcher.setVoucherCode(vourcher.getVoucherCode().toUpperCase()); //uppercase voucher

                vourcher.setExpirationDate(expirationDateFormatYet);

                voucherRepository.save(vourcher);
                return new ModelAndView("redirect:/admin/voucher", modelMap);
//            }
        }catch (Exception e){
            throw new RuntimeException(e);
        }
    }
}
