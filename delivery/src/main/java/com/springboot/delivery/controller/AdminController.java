package com.springboot.delivery.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.Coupon;
import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.Maincategory;
import com.springboot.delivery.model.Owner;
import com.springboot.delivery.model.User;
import com.springboot.delivery.service.AdminService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
    @Autowired
    private AdminService adminService;
    
    // 관리자 메인 페이지
    @GetMapping("/admin/home")
    public ModelAndView adminHome(HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/adminMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        // 전체 회원 수 가져오기
        int userCount = adminService.getUserCount();
        mav.addObject("userCount", userCount);
        
        // 기본적으로 대시보드 표시
        mav.addObject("activeMenu", "dashboard");      
        return mav;
    }
    
    // 사용자 관리 페이지
    @GetMapping("/admin/userManagement")
    public ModelAndView userManagement(HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/adminMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        // 유저 목록 가져와서 모델에 추가
        List<User> userList = adminService.getAllUsers();
        mav.addObject("userList", userList);
        mav.addObject("activeMenu", "userManagement");
        mav.addObject("contentPage", "../admin/userManagement.jsp");
        
        return mav;
    }
    
    // 카테고리 관리 페이지
    @GetMapping("/admin/categoryManagement")
    public ModelAndView categoryManagement(HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/adminMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        // 카테고리 목록을 가져와서 모델에 추가
        List<Maincategory> maincategoryList = adminService.getAllMaincategory();
        mav.addObject("maincategoryList", maincategoryList);
        mav.addObject("activeMenu", "categoryManagement");
        mav.addObject("contentPage", "../admin/categoryManagement.jsp");
        
        return mav;
    }
    
    // 쿠폰 관리 페이지
    @GetMapping("/admin/couponManagement")
    public ModelAndView couponManagement(HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/adminMain");

        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        //사업자 총 목록 가져오기
       List<Owner> ownerList = this.adminService.getAllOwner();
        
        // 쿠폰 목록을 가져와서 모델에 추가
        List<Coupon> couponList = adminService.getAllCoupons();
        mav.addObject("couponList", couponList);
        mav.addObject("ownerList", ownerList);
        mav.addObject("activeMenu", "couponManagement");
        mav.addObject("contentPage", "../admin/couponManagement.jsp");
        
        return mav;
    }
    
    // 쿠폰 삭제
    @PostMapping("/admin/coupon/delete/{owner_coupon_id}")
    @ResponseBody
    public ResponseEntity<String> deleteCoupon(@PathVariable Integer owner_coupon_id, HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("권한이 없습니다.");
        }
        
        try {
            adminService.deleteCoupon(owner_coupon_id);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("삭제 실패");
        }
    }
    
    // 카테고리 삭제
    @PostMapping("/admin/maincategory/delete/{main_category_id}")
    @ResponseBody
    public ResponseEntity<String> deleteMaincategory(@PathVariable Integer main_category_id, HttpSession session) {
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("권한이 없습니다.");
        }
        
        try {
            adminService.deleteMaincategory(main_category_id);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("삭제 실패");
        }
    }
    
    // 쿠폰 생성
    @PostMapping("/admin/coupon/create")
    public ModelAndView createCoupon(Coupon coupon, HttpSession session) {
        ModelAndView mav = new ModelAndView("redirect:/admin/couponManagement");
        
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        Integer maxCount = this.adminService.getMaxCouponId();
        if(maxCount == null) {
        	maxCount=0;
        	
        }
        coupon.setOwner_coupon_id(maxCount+1);
        coupon.setIssued_date(new String());  // 생성일자 설정
        adminService.createCoupon(coupon);        
        return mav;
    }
    
    // 카테고리 생성
    @PostMapping("/admin/maincategory/create")
    public ModelAndView createMaincategory(Maincategory maincategory, HttpSession session) {
        ModelAndView mav = new ModelAndView("redirect:/admin/categoryManagement");  
        
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        adminService.createMaincategory(maincategory);        
        return mav;
    }
    
    @GetMapping("/admin/pointManagement")
    public ModelAndView pointManagement(HttpSession session) {
    	ModelAndView mav = new ModelAndView("admin/adminMain");
    	
    	// 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        float currentRate = this.adminService.getpointRate();
        Integer currentpointRate = (int)(currentRate * 100);
        mav.addObject("currentRate",currentpointRate);
        mav.addObject("contentPage", "../admin/pointManagement.jsp");
        return mav;
    }
    @PostMapping("/admin/updatePointRate")
    public ModelAndView updatePointRate(HttpSession session, Integer pointRate) {
    	ModelAndView mav = new ModelAndView("admin/adminMain");
    	// 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        float point_rate = (float)pointRate / 100;
        float currentRate = this.adminService.getpointRate();
        System.out.println("포인트설정"+point_rate);
        this.adminService.pointRate(point_rate);
        Integer currentpointRate = (int)(currentRate * 100);
        mav.addObject("currentRate",currentpointRate);
        mav.addObject("contentPage", "../admin/pointManagement.jsp");
        return mav;
    }
}









