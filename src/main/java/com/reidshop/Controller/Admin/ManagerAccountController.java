package com.reidshop.Controller.Admin;

import com.reidshop.Model.Entity.*;
import com.reidshop.Model.Enum.ROLE;
import com.reidshop.Reponsitory.*;
import com.reidshop.Service.IAccountService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

@Controller
@RequestMapping("/admin/account")
public class ManagerAccountController {
    @Autowired
    AccountRepository accountRepository;
    @Autowired
    IAccountService accountService;

    @Autowired
    AccountDetailRepository accountDetailRepository;
    @Autowired
    OrdersRepository ordersRepository;
    @Autowired
    OrderItemRepository orderItemRepository;
    @Autowired
    StoreRepository storeRepository;
    @Autowired
    PasswordEncoder passwordEncoder;

    Locale locale = new Locale("vi","VN");
    DecimalFormat formatVND = (DecimalFormat) NumberFormat.getCurrencyInstance(locale);
    @RequestMapping("")
    public String listAccount(ModelMap modelMap){
        modelMap.addAttribute("formatVND",formatVND);
        modelMap.addAttribute("accountRepository", accountRepository);
        modelMap.addAttribute("accountService", accountService);
        modelMap.addAttribute("accountDetailRepository", accountDetailRepository);
        return "admin/account";
    }
    @GetMapping("{accountId}")
    public ModelAndView detail(ModelMap model, @PathVariable("accountId") Long accountId){
        Optional<AccountDetail> opt = accountDetailRepository.findByAccountId(accountId);
        Optional<Account> optAccount = accountRepository.findById(accountId);
        List<Orders> ordersByAcc = ordersRepository.findAllOrderByAccountId(accountId);

        if(opt.isPresent()){
            AccountDetail accountDetail = opt.get();
            Account account = optAccount.get();
            model.addAttribute("accountDetail", accountDetail);
            model.addAttribute("account", account);
            model.addAttribute("ordersByAcc", ordersByAcc);
            model.addAttribute("formatVND",formatVND);
            return new ModelAndView("admin/accountDetail", model);
        }
        return new ModelAndView("redirect:/admin/account", model);
    }

    @GetMapping("{accountId}/{ordered}")
    public ModelAndView orderDetail(ModelMap model, @PathVariable("accountId") Long accountId, @PathVariable("ordered") Long orderedID){
        Optional<AccountDetail> opt = accountDetailRepository.findByAccountId(accountId);
        Optional<Account> optAccount = accountRepository.findById(accountId);
        Optional<Orders> optOrder = ordersRepository.findById(orderedID);
        List<OrderItem> items = orderItemRepository.findAllItemByOrderId(orderedID);

        if(opt.isPresent()){
            AccountDetail accountDetail = opt.get();
            Account account = optAccount.get();
            Orders order = optOrder.get();
            model.addAttribute("accountDetail", accountDetail);
            model.addAttribute("account", account);
            model.addAttribute("order", order);
            model.addAttribute("formatVND",formatVND);
            model.addAttribute("orderItem",items);
            return new ModelAndView("admin/orderDetail", model);
        }
        return new ModelAndView("redirect:/admin/account", model);
    }

    @Transactional
    @PostMapping("addNewAccountVendor")
    public ModelAndView addNewAccountVendor(ModelMap modelMap,
                                            @Valid @ModelAttribute("account") Account account,
                                            @RequestParam("addressDepartment") String addressDepartment,
                                            @RequestParam("name") String nameDepartment,
                                            @RequestParam("phoneNumber") String phoneNumber,
                                            BindingResult result) throws IOException {
        if(result.hasErrors()){
            System.out.println(result);
            return new ModelAndView("admin/account");
        }
        System.out.println(addressDepartment);
        Optional<Account> opt = accountRepository.findByEmail(account.getEmail());
        try {
            if (opt.isPresent()){
                System.out.println("Đã tồn tại email");
                modelMap.addAttribute("errorMessage", "The email already exists. Please use a different email.");

                modelMap.addAttribute("account", new Account());
                modelMap.addAttribute("accountRepository", accountRepository);
                modelMap.addAttribute("accountDetailRepository", accountDetailRepository);
                return new ModelAndView("forward:/admin/account", modelMap);
            }
            else {
                account.setRole(ROLE.VENDOR);
                account.setPassword(passwordEncoder.encode((account.getPassword())));
                accountRepository.save(account);

                //Add Store:
                Store newStore = new Store();
                newStore.setAccount(account);
                newStore.setDepartment(addressDepartment);
                storeRepository.save(newStore);

                //New Account Detail
                AccountDetail newAccDtl = new AccountDetail();
                newAccDtl.setImage("https://pos.nvncdn.com/80c639-72864/ps/20230619_g56PqYH9vP.jpeg");
                newAccDtl.setName(nameDepartment);
                newAccDtl.setAccount(account);
                newAccDtl.setPhone(phoneNumber);
                newAccDtl.setAddress(addressDepartment);
                accountDetailRepository.save(newAccDtl);

                modelMap.addAttribute("successMessage", "Register Account For Vendor Successfully.");
                modelMap.addAttribute("account", new Account());
                modelMap.addAttribute("accountRepository", accountRepository);
                modelMap.addAttribute("accountDetailRepository", accountDetailRepository);
                return new ModelAndView("forward:/admin/account", modelMap);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
