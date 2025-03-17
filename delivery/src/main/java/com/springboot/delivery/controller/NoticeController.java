package com.springboot.delivery.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.Maincategory;
import com.springboot.delivery.model.OwnerNotice;
import com.springboot.delivery.model.StartEnd;
import com.springboot.delivery.model.UserNotice;
import com.springboot.delivery.service.AdminService;
import com.springboot.delivery.service.NoticeService;

import jakarta.servlet.http.HttpSession;

@Controller
public class NoticeController {
    
    @Autowired
    private NoticeService noticeService;
    
    @Autowired
    private AdminService adminService;
    
    // === 사용자 공지사항 ===
    
    // 사용자 공지사항 목록
    @GetMapping("/user/notice")
    public ModelAndView userNoticeList(HttpSession session, Integer PAGE_NUM) {
        ModelAndView mav = new ModelAndView("user/userMain");
        
        // 메인 카테고리 목록 가져오기 (메뉴 표시용)
        List<Maincategory> maincategoryList = adminService.getAllMaincategory();
        mav.addObject("maincategoryList", maincategoryList);
        
        int currentPage = 1;
        if(PAGE_NUM != null) {
        	currentPage = PAGE_NUM;
        }
        Integer count = this.noticeService.getMaxCountFromUserNotice();
        int startRow = 0; int endRow = 0; int totalPageCount = 0;
        if(count > 0) {
        	totalPageCount = count / 5;
        	if(count % 5 != 0) totalPageCount++;
        	startRow = (currentPage - 1) * 5;
        	endRow = ((currentPage - 1) * 5) + 6;
        	if(endRow > count) endRow = count;
        }
        StartEnd se = new StartEnd(); se.setStart(startRow); se.setEnd(endRow);
        
        List<UserNotice> noticeList = noticeService.getAllUserNotices(se);
        mav.addObject("START", startRow);
        mav.addObject("END", endRow);
        mav.addObject("TOTAL", count);
        mav.addObject("currentPage", currentPage);
        mav.addObject("LIST", noticeList);
        mav.addObject("BODY", "userNoticeList.jsp");
        return mav;
    }
    
    // 사용자 공지사항 상세보기
    @GetMapping("/user/notice/{notice_id}")
    public ModelAndView userNoticeDetail(@PathVariable Integer notice_id, HttpSession session) {
        ModelAndView mav = new ModelAndView("user/userMain");
        
        // 메인 카테고리 목록 가져오기 (메뉴 표시용)
        List<Maincategory> maincategoryList = adminService.getAllMaincategory();
        mav.addObject("maincategoryList", maincategoryList);
        
        // 조회수 증가
        noticeService.increaseUserNoticeViewCount(notice_id);
        
        UserNotice notice = noticeService.getUserNoticeById(notice_id);
        mav.addObject("notice", notice);
        mav.addObject("BODY", "userNoticeDetail.jsp");
        return mav;
    }
    
    // === 사업자 공지사항 ===
    
    // 사업자 공지사항 목록
    @GetMapping("/owner/notice")
    public ModelAndView ownerNoticeList(HttpSession session) {
        ModelAndView mav = new ModelAndView("owner/ownerMain");
        
        List<OwnerNotice> noticeList = noticeService.getAllOwnerNotices();
        mav.addObject("noticeList", noticeList);
        mav.addObject("BODY", "ownerNoticeList.jsp");
        return mav;
    }
    
    // 사업자 공지사항 상세보기
    @GetMapping("/owner/notice/{notice_id}")
    public ModelAndView ownerNoticeDetail(@PathVariable Integer notice_id, HttpSession session) {
        ModelAndView mav = new ModelAndView("owner/ownerMain");
        
        // 조회수 증가
        noticeService.increaseOwnerNoticeViewCount(notice_id);
        
        OwnerNotice notice = noticeService.getOwnerNoticeById(notice_id);
        mav.addObject("notice", notice);
        mav.addObject("BODY", "ownerNoticeDetail.jsp");
        return mav;
    }
    
    // === 관리자 공지사항 관리 ===
    
    // 사용자 공지사항 관리 페이지
    @GetMapping("/admin/userNotice")
    public ModelAndView adminUserNoticeList(HttpSession session, Integer PAGE_NUM) {
        ModelAndView mav = new ModelAndView("admin/adminMain");
        
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        int currentPage = 1;
        if(PAGE_NUM != null) {
        	currentPage = PAGE_NUM;
        }
        Integer count = this.noticeService.getMaxCountFromUserNotice();
        int startRow = 0; int endRow = 0; int totalPageCount = 0;
        if(count > 0) {
        	totalPageCount = count / 5;
        	if(count % 5 != 0) totalPageCount++;
        	startRow = (currentPage - 1) * 5;
        	endRow = ((currentPage - 1) * 5) + 6;
        	if(endRow > count) endRow = count;
        }
        StartEnd se = new StartEnd(); se.setStart(startRow); se.setEnd(endRow);
        List<UserNotice> noticeList = noticeService.getAllUserNotices(se);
        mav.addObject("noticeList", noticeList);
        mav.addObject("activeMenu", "userNotice");
        mav.addObject("contentPage", "../admin/userNoticeManagement.jsp");
        
        return mav;
    }
    
    // 사용자 공지사항 작성 폼
    @GetMapping("/admin/userNotice/write")
    public ModelAndView userNoticeWriteForm(HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/adminMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        mav.addObject("activeMenu", "userNotice");
        mav.addObject("contentPage", "../admin/userNoticeWriteForm.jsp");
        
        return mav;
    }
    
    // 사용자 공지사항 작성 처리
    @PostMapping("/admin/userNotice/write")
    public ModelAndView userNoticeWrite(UserNotice notice, HttpSession session) {
        ModelAndView mav = new ModelAndView("redirect:/admin/userNotice");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        notice.setWriter(loginUser.getUser_id());
        noticeService.createUserNotice(notice);
        
        return mav;
    }
    
    // 사용자 공지사항 수정 폼
    @GetMapping("/admin/userNotice/edit/{notice_id}")
    public ModelAndView userNoticeEditForm(@PathVariable Integer notice_id, HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/adminMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        UserNotice notice = noticeService.getUserNoticeById(notice_id);
        mav.addObject("notice", notice);
        mav.addObject("activeMenu", "userNotice");
        mav.addObject("contentPage", "../admin/userNoticeEditForm.jsp");
        
        return mav;
    }
    
    // 사용자 공지사항 수정 처리
    @PostMapping("/admin/userNotice/edit")
    public ModelAndView userNoticeEdit(UserNotice notice, HttpSession session) {
        ModelAndView mav = new ModelAndView("redirect:/admin/userNotice");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        noticeService.updateUserNotice(notice);
        
        return mav;
    }
    
    // 사용자 공지사항 삭제 처리
    @GetMapping("/admin/userNotice/delete/{notice_id}")
    public ModelAndView userNoticeDelete(@PathVariable Integer notice_id, HttpSession session) {
        ModelAndView mav = new ModelAndView("redirect:/admin/userNotice");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        noticeService.deleteUserNotice(notice_id);
        
        return mav;
    }
    
    // 사업자 공지사항 관리 페이지
    @GetMapping("/admin/ownerNotice")
    public ModelAndView adminOwnerNoticeList(HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/adminMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        List<OwnerNotice> noticeList = noticeService.getAllOwnerNotices();
        mav.addObject("noticeList", noticeList);
        mav.addObject("activeMenu", "ownerNotice");
        mav.addObject("contentPage", "../admin/ownerNoticeManagement.jsp");
        
        return mav;
    }
    
    // 사업자 공지사항 작성 폼
    @GetMapping("/admin/ownerNotice/write")
    public ModelAndView ownerNoticeWriteForm(HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/adminMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        mav.addObject("activeMenu", "ownerNotice");
        mav.addObject("contentPage", "../admin/ownerNoticeWriteForm.jsp");
        
        return mav;
    }
    
    // 사업자 공지사항 작성 처리
    @PostMapping("/admin/ownerNotice/write")
    public ModelAndView ownerNoticeWrite(OwnerNotice notice, HttpSession session) {
        ModelAndView mav = new ModelAndView("redirect:/admin/ownerNotice");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        notice.setWriter(loginUser.getUser_id());
        noticeService.createOwnerNotice(notice);
        
        return mav;
    }
    
    // 사업자 공지사항 수정 폼
    @GetMapping("/admin/ownerNotice/edit/{notice_id}")
    public ModelAndView ownerNoticeEditForm(@PathVariable Integer notice_id, HttpSession session) {
        ModelAndView mav = new ModelAndView("admin/adminMain");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        OwnerNotice notice = noticeService.getOwnerNoticeById(notice_id);
        mav.addObject("notice", notice);
        mav.addObject("activeMenu", "ownerNotice");
        mav.addObject("contentPage", "../admin/ownerNoticeEditForm.jsp");
        
        return mav;
    }
    
    // 사업자 공지사항 수정 처리
    @PostMapping("/admin/ownerNotice/edit")
    public ModelAndView ownerNoticeEdit(OwnerNotice notice, HttpSession session) {
        ModelAndView mav = new ModelAndView("redirect:/admin/ownerNotice");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        noticeService.updateOwnerNotice(notice);
        
        return mav;
    }
    
    // 사업자 공지사항 삭제 처리
    @GetMapping("/admin/ownerNotice/delete/{notice_id}")
    public ModelAndView ownerNoticeDelete(@PathVariable Integer notice_id, HttpSession session) {
        ModelAndView mav = new ModelAndView("redirect:/admin/ownerNotice");
        
        // 세션에서 로그인 사용자 확인 (관리자 권한 체크)
        LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
        
        if (loginUser == null || !"ADMIN".equals(loginUser.getRole().toUpperCase())) {
            // 관리자가 아니면 로그인 페이지로 리다이렉트
            mav.setViewName("redirect:/user/index");
            return mav;
        }
        
        noticeService.deleteOwnerNotice(notice_id);
        
        return mav;
    }
}