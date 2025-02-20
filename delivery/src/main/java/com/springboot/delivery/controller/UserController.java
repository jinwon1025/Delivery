package com.springboot.delivery.controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.LoginUser;
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
	public ModelAndView userIndex() {
		ModelAndView mav = new ModelAndView("user/userMain");
		mav.addObject("BODY", "index.jsp");
		mav.addObject(new LoginUser());
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
	    	  user.setImage_name(fileName);
	      }
		this.userService.registerUser(user);
    	mav.addObject("BODY","registerSuccess.jsp");
    	mav.addObject("user",user);
    	return mav;
	}
	
//	@GetMapping(value="/user/idcheck")
//	public ModelAndView idcheck(String user_id) {
//		ModelAndView mav = new ModelAndView("user/userIdcheck");
//		Integer count = this.userService.idcheck(user_id);
//		if(count > 0) {
//			mav.addObject("DUP", "YES");
//		} else {
//			mav.addObject("DUP", "NO");
//		}
//		mav.addObject("user_id", user_id);
//		return mav;
//	}
	
	
	@PostMapping(value="/user/login")
	public ModelAndView loginUser(@Valid LoginUser loginuser, BindingResult br, HttpSession session) {
		System.out.println("로그인 시도: " + loginuser.getUser_id());
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
			System.out.println("로그인 성공");
			session.setAttribute("loginUser", user);
			mav.addObject("BODY","loginUser.jsp");
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
	    mav.addObject("userInfo", userInfo);
	    mav.addObject("BODY", "mypage.jsp");
	    
	    return mav;
	}

	@GetMapping("/user/updateForm")
	public ModelAndView updateForm(HttpSession session) {
	    ModelAndView mav = new ModelAndView("user/userMain");
	    
	    // 세션에서 로그인한 사용자 정보 가져오기
	    LoginUser loginUser = (LoginUser) session.getAttribute("user");
	    
	    if (loginUser == null) {
	        // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
	        mav.setViewName("redirect:/user/index");
	        return mav;
	    }
	    
	    // 사용자의 전체 정보 조회
	    User userInfo = this.userService.getUserById(loginUser.getUser_id());
	    mav.addObject("userInfo", userInfo);
	    mav.addObject("BODY", "updateForm.jsp");
	    
	    return mav;
	}

	@PostMapping("/user/updateUser")
	public ModelAndView updateUser(User user, HttpSession session) {
	    ModelAndView mav = new ModelAndView("redirect:/user/mypage");
	    
	    // 세션에서 로그인한 사용자 정보 가져오기
	    LoginUser loginUser = (LoginUser) session.getAttribute("user");
	    
	    if (loginUser == null) {
	        // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
	        mav.setViewName("redirect:/user/index");
	        return mav;
	    }
	    
	    // user_id 설정 (보안을 위해 세션에서 가져온 값 사용)
	    user.setUser_id(loginUser.getUser_id());
	    
	    // 회원 정보 수정
	    this.userService.updateUserInfo(user);
	    
	    return mav;
	}
	@GetMapping(value="/user/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/user/index");
		return mav;
	}
	

}
