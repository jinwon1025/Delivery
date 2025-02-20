package com.springboot.delivery.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.service.AdminService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private AdminService adminService;

    // 관리자 권한 체크 메서드
    private boolean checkAdminAuth(HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        return loginUser != null && "ADMIN".equals(loginUser.getRole());
    }

    // 유저 관리 페이지
    @GetMapping("/users")
    public ModelAndView userManagement(HttpSession session) {
        ModelAndView mav = new ModelAndView("user/userMain");
        
        if (!checkAdminAuth(session)) {
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        mav.addObject("userList", adminService.getAllUsers());
        mav.addObject("BODY", "admin/userManagement.jsp");
        return mav;
    }

    // 쿠폰 관리 페이지
    @GetMapping("/coupons")
    public ModelAndView couponManagement(HttpSession session) {
        ModelAndView mav = new ModelAndView("user/userMain");
        
        if (!checkAdminAuth(session)) {
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        mav.addObject("couponList", adminService.getAllCoupons());
        mav.addObject("BODY", "admin/couponManagement.jsp");
        return mav;
    }
}