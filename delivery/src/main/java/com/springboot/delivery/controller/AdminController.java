package com.springboot.delivery.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.LoginUser;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @GetMapping("/admin/couponManagement")
    public ModelAndView couponManagement(HttpSession session) {
        ModelAndView mav = new ModelAndView("user/userMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        mav.addObject("BODY", "../admin/couponManagement.jsp");
        return mav;
    }

    @GetMapping("/admin/userManagement")
    public ModelAndView userManagement(HttpSession session) {
        ModelAndView mav = new ModelAndView("user/userMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        mav.addObject("BODY", "../admin/userManagement.jsp");
        return mav;
    }
}