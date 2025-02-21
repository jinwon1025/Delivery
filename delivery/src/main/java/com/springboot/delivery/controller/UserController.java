package com.springboot.delivery.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.User;
import com.springboot.delivery.service.UserService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;



@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@GetMapping(value = "/user/index")
	public ModelAndView userIndex(HttpSession session) {
	    ModelAndView mav = new ModelAndView("user/userMain");
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	    //로그인이 되어있다면 로그인상태 페이지 유지
	    if(loginUser != null) {
	    	if("ADMIN".equals(loginUser.getRole())) {
	            mav.addObject("BODY", "admin/adminHome.jsp");  // 관리자는 관리자 페이지로
	        } else {
	            mav.addObject("BODY", "loginUser.jsp");  // 일반 사용자는 일반 페이지로
	        }
	    } else {
	        // 로그인되지 않은 상태면 로그인 폼(index.jsp) 보여주기
	        mav.addObject("BODY", "index.jsp");
	        mav.addObject(new LoginUser());
	    }	
	    return mav;
	}
	@GetMapping(value="/user/register")
	public ModelAndView insertRegister() {
		ModelAndView mav = new ModelAndView("user/userMain");
		mav.addObject("BODY", "register.jsp");
		mav.addObject(new User());
		return mav;
	}
	@PostMapping(value="/user/insertRegister")
	public ModelAndView userRegister(@Valid User user, BindingResult br, HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView("user/userMain");
		if(br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			mav.addObject("BODY", "register.jsp");
			br.getFieldErrors().forEach(error -> {
	            System.out.println("Field: " + error.getField() + ", Error: " + error.getDefaultMessage());
	         });
			return mav;
		}
		MultipartFile multiFile = user.getImage();
		String fileName = null;
		String path = null;
		if(multiFile != null && !multiFile.getOriginalFilename().isEmpty()) {
			fileName = user.getUser_id() + "_" + multiFile.getOriginalFilename();
		}
		
		if (fileName != null) {
	         ServletContext ctx = session.getServletContext();
	         path = ctx.getRealPath("/upload/userProfile/" + fileName);
	         System.out.println("업로드 위치: " + path);

	         try (BufferedInputStream bis = new BufferedInputStream(multiFile.getInputStream());
	               FileOutputStream fos = new FileOutputStream(path)) {
	            byte[] buffer = new byte[8192];
	            int read;
	            while ((read = bis.read(buffer)) > 0) {
	               fos.write(buffer, 0, read);
	            }
	         }
	         user.setImage_name(fileName);
	      } else {
	    	 user.setImage_name("");
	      }
		this.userService.registerUser(user);
    	mav.addObject("BODY","registerSuccess.jsp");
    	mav.addObject("user",user);
    	return mav;
	}
	
	@GetMapping(value="/user/idcheck")
	public ModelAndView idcheck(String user_id) {
		ModelAndView mav = new ModelAndView("user/userIdcheck");
		Integer count = this.userService.idcheck(user_id);
		if(count > 0) {
			mav.addObject("DUP", "YES");
		} else {
			mav.addObject("DUP", "NO");
		}
		mav.addObject("user_id", user_id);
		return mav;
	}
	
	
	@PostMapping(value="/user/login")
	public ModelAndView loginUser(@Valid LoginUser loginuser, BindingResult br, HttpSession session) {
	    ModelAndView mav = new ModelAndView("user/userMain");
	    
	    if(br.hasErrors()) {
	        System.out.println("유효성 검사 실패");
	        mav.getModel().putAll(br.getModel());
	        return mav;
	    }
	    
	    LoginUser user = this.userService.loginUser(loginuser);

	    if (user == null) {
	        System.out.println("로그인 실패");
	        mav.addObject("BODY","index.jsp");
	        mav.addObject("BBODY","loginResult.jsp");
	        mav.addObject("FAIL","YES");
	    } else {
	        session.setAttribute("loginUser", user);

	        // role이 있고 ADMIN인 경우에만 관리자 페이지로
	        if(user.getRole() != null && user.getRole().toUpperCase().equals("ADMIN")) {
	            mav.setViewName("user/userMain");
	            mav.addObject("BODY", "../admin/adminHome.jsp");  // 절대 경로로 시작
	        } else {
	            mav.addObject("BODY", "loginUser.jsp");  // 동일하게 절대 경로 사용
	        }
	    }
	    return mav;
	}
	// UserController 클래스에 추가할 메소드들

	@GetMapping("/user/mypage")
	public ModelAndView myPage(HttpSession session) {
	    ModelAndView mav = new ModelAndView("user/userMain");
	    
	    // 세션에서 로그인한 사용자 정보 가져오기
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	    
	    if (loginUser == null) {
	        // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
	        mav.setViewName("redirect:/user/index");
	        return mav;
	    }
	    
	    // 사용자의 전체 정보 조회
	    User userInfo = this.userService.getUserById(loginUser.getUser_id());
	    String maskedPassword= userInfo.getPassword().replaceAll(".", "*");
	    userInfo.setPassword(maskedPassword);
	    System.out.println(userInfo.getUser_phone());
	    mav.addObject("userInfo", userInfo);
	    mav.addObject("BODY", "mypage.jsp");
	    
	    return mav;
	}

	@GetMapping("/user/updateForm")
	public ModelAndView updateForm(HttpSession session) {
	    ModelAndView mav = new ModelAndView("user/userMain");
	    
	    // 세션에서 로그인한 사용자 정보 가져오기
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	    
	    if (loginUser == null) {
	        // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
	        mav.setViewName("redirect:/user/index");
	        return mav;
	    }
	    
	    // 사용자의 전체 정보 조회
	    User userInfo = this.userService.getUserById(loginUser.getUser_id());
	    System.out.println(userInfo.getImage_name());
	    mav.addObject("userInfo", userInfo);
	    mav.addObject("BODY", "updateForm.jsp");
	    
	    return mav;
	}

	@PostMapping("/user/updateUser")
	public ModelAndView updateUser(User user, HttpSession session) {
	    ModelAndView mav = new ModelAndView("redirect:/user/mypage");
	    
	    // 세션에서 로그인한 사용자 정보 가져오기
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	    
	    if (loginUser == null) {
	        // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
	        mav.setViewName("redirect:/user/index");
	        return mav;
	    }
	    
	    // user_id 설정 (보안을 위해 세션에서 가져온 값 사용)
	    user.setUser_id(loginUser.getUser_id());
	    
	    // 기존 사용자 정보 조회
	    User existingUser = this.userService.getUserById(loginUser.getUser_id());
	    String existingImageName = existingUser.getImage_name();
	    
	    MultipartFile multiFile = user.getImage();
	    ServletContext ctx = session.getServletContext();
	    
	    // multiFile이 null이 아니고 비어있지 않은 경우 (새 이미지 업로드)
	    if (multiFile != null && !multiFile.isEmpty()) {
	        String originalFilename = multiFile.getOriginalFilename();
	        // 파일명 길이 제한 (30자 이내)
	        String newFileName = user.getUser_id() + "_";
	        
	        // 확장자 추출
	        int lastDotIndex = originalFilename.lastIndexOf('.');
	        String extension = "";
	        String baseFileName = originalFilename;
	        
	        if (lastDotIndex > 0) {
	            extension = originalFilename.substring(lastDotIndex); // .jpg 같은 확장자
	            baseFileName = originalFilename.substring(0, lastDotIndex);
	        }
	        
	        // 남은 길이 계산 (user_id + "_" + 확장자 길이를 제외한 나머지)
	        int remainingLength = 30 - newFileName.length() - extension.length();
	        
	        // 파일명이 너무 길면 자르기
	        if (baseFileName.length() > remainingLength) {
	            baseFileName = baseFileName.substring(0, remainingLength);
	        }
	        
	        newFileName += baseFileName + extension;
	        String newPath = ctx.getRealPath("/upload/userProfile/" + newFileName);
	        
	        // 기존 이미지가 있으면 삭제
	        if (existingImageName != null && !existingImageName.isEmpty()) {
	            String existingPath = ctx.getRealPath("/upload/userProfile/" + existingImageName);
	            File existingFile = new File(existingPath);
	            if (existingFile.exists()) {
	                boolean deleted = existingFile.delete();
	                System.out.println("기존 파일 삭제 " + (deleted ? "성공" : "실패") + ": " + existingPath);
	            }
	        }
	        
	        // 새 이미지 저장
	        try (OutputStream os = new FileOutputStream(newPath);
	             BufferedInputStream bis = new BufferedInputStream(multiFile.getInputStream())) {
	            byte[] buffer = new byte[8156];
	            int read;
	            while ((read = bis.read(buffer)) > 0) {
	                os.write(buffer, 0, read);
	            }
	            user.setImage_name(newFileName);
	            System.out.println("새 이미지 저장 성공: " + newPath);
	        } catch (Exception e) {
	            System.out.println("새 이미지 업로드 중 문제 발생: " + e.getMessage());
	        }
	    } else {
	        // 새 이미지가 없는 경우, 기존 이미지가 있으면 삭제
	        if (existingImageName != null && !existingImageName.isEmpty()) {
	            String existingPath = ctx.getRealPath("/upload/userProfile/" + existingImageName);
	            File existingFile = new File(existingPath);
	            if (existingFile.exists()) {
	                boolean deleted = existingFile.delete();
	                System.out.println("이미지 선택 안함 - 기존 파일 삭제 " + (deleted ? "성공" : "실패") + ": " + existingPath);
	            }
	        }
	        // 이미지 이름을 빈 문자열로 설정
	        user.setImage_name("");
	    }
	    
	    // 회원 정보 수정
	    this.userService.updateUserInfo(user);
	    LoginUser lu = new LoginUser();
	    lu.setUser_id(user.getUser_id());
	    lu.setPassword(user.getPassword());
	    lu.setUser_name(user.getUser_name());
	    lu.setImage_name(user.getImage_name());
	    session.setAttribute("loginUser", lu);
	    
	    return mav;
	}
	@GetMapping(value="/user/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/user/index");
		return mav;
	}
	
	@GetMapping(value="/user/allStore")
	public ModelAndView allStore() {
		ModelAndView mav =new ModelAndView("user/userMain");
		List<Store> allStore = this.userService.getAllStore();
		mav.addObject("StoreList", allStore);
		mav.addObject("BODY", "allStoreList.jsp");
		return mav;
	}
	

}
