package com.reidshop.Controller.User;

import com.reidshop.Model.Cookie.CookieHandle;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LogOutController {
    @GetMapping("/reset")
    public ModelAndView logout(@RequestParam("back") String urlBack, HttpServletResponse response, HttpServletRequest request){
        CookieHandle.RemoveCookies(request,response);
        return new ModelAndView("redirect:"+urlBack);
    }
}
