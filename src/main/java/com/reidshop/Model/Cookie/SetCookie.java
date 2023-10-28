package com.reidshop.Model.Cookie;

import com.reidshop.security.JwtService;
import jakarta.servlet.http.Cookie;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class SetCookie {

    public static Cookie createCookie(String fieldName,String value){
        Cookie cookie = new Cookie(fieldName,value);
        cookie.setMaxAge(7 * 24 * 60 * 60); // expires in 7 days
        cookie.setSecure(true);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        return cookie;
    }
}
