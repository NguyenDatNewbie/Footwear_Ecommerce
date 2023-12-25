package com.reidshop.Model.Cookie;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;

@RequiredArgsConstructor
public class CookieHandle {

    public static Cookie createCookie(String fieldName,String value){
        Cookie cookie = new Cookie(fieldName,value);
        cookie.setMaxAge(7 * 24 * 60 * 60); // expires in 7 days
        cookie.setSecure(true);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        return cookie;
    }

    public static Cookie createCookieNotAuthentication(String fieldName, String value){
        Cookie cookie = new Cookie(fieldName,value);
        cookie.setMaxAge(7 * 24 * 60 * 60); // expires in 7 days
        cookie.setSecure(true);
        cookie.setHttpOnly(false);
        cookie.setPath("/");
        return cookie;
    }

    public static void RemoveCookies(HttpServletRequest request, HttpServletResponse response){
        Cookie[] cookies = request.getCookies();
        if(cookies!=null){
            for (Cookie cookie: cookies) {
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
            }
        }
    }
    public static String getCookieValue(HttpServletRequest req, String cookieName) {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            return Arrays.stream(cookies)
                    .filter(c -> c.getName().equals(cookieName))
                    .findFirst()
                    .map(Cookie::getValue)
                    .orElse(null);
        }
        return null;
    }
}
