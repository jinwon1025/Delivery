package com.springboot.delivery.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.User;
import com.springboot.delivery.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;



@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@GetMapping(value="/user/index")
	public ModelAndView userIndex() {
		ModelAndView mav = new ModelAndView("user/userMain");
		mav.addObject(new LoginUser());
		mav.addObject("BODY", "index.jsp");
		return mav;
	}
	@GetMapping(value="/user/register")
	public ModelAndView insertRegister() {
		ModelAndView mav = new ModelAndView("user/register");
		mav.addObject(new User());
		return mav;
	}
	@PostMapping(value="/user/insertRegister")
	public ModelAndView userRegister(@Valid User user, BindingResult br) {
		ModelAndView mav = new ModelAndView("user/register");
		if(br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		this.userService.registerUser(user);
    	mav.setViewName("user/registerSuccess");
    	mav.addObject("user",user);
    	return mav;
	}
	@PostMapping(value="/user/login")
	public ModelAndView loginUser(@Valid LoginUser loginuser, BindingResult br, HttpSession session) {
		ModelAndView mav = new ModelAndView("user/userMain");
		if(br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		LoginUser user = this.userService.loginUser(loginuser);
		if (user == null) {
	        mav.addObject("BODY","index.jsp");
	        mav.addObject("BBODY","loginResult.jsp");
	        mav.addObject("FAIL","YES");
		} else {
			session.setAttribute("user", user);
			mav.addObject("BODY","loginUser.jsp");
		}
		return mav;
	}
	@GetMapping("/user/loginUser")
	public ModelAndView loginSuccess(HttpSession session) {
	    ModelAndView mav = new ModelAndView("user/loginUser");
	    return mav;
	}
	
	
	// UserController 클래스에 추가할 메소드들

	@GetMapping("/user/mypage")
	public ModelAndView myPage(HttpSession session) {
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

	@GetMapping("/user/logout")
	public String logout(HttpSession session) {
	    session.invalidate();
	    return "redirect:/user/index";
	}
	
	
	
	
	
	
	
	

}
