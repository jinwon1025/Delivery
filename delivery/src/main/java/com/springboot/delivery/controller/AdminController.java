package com.springboot.delivery.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;  // 추가
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.Coupon;
import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.service.AdminService;  // 추가

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
    @Autowired  // 추가
    private AdminService adminService;  // 추가
    
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

        // 쿠폰 목록을 가져와서 모델에 추가
        List<Coupon> couponList = adminService.getAllCoupons();
        mav.addObject("couponList", couponList);
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
    
    @GetMapping("/admin/home")
    public ModelAndView adminHome(HttpSession session) {
        ModelAndView mav = new ModelAndView("user/userMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        mav.addObject("BODY", "../admin/adminHome.jsp");
        return mav;
    }
   
   
    @PostMapping("/admin/coupon/create")
    public ModelAndView createCoupon(Coupon coupon, HttpSession session) {
        ModelAndView mav = new ModelAndView("redirect:/admin/couponManagement");
        
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        coupon.setCreated_date(new String());  // 생성일자 설정
        adminService.createCoupon(coupon);        
        return mav;
    }        
}