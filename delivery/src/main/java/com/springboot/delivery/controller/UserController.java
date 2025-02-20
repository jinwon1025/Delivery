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
	@GetMapping(value = "/user/index")
	public ModelAndView userIndex() {
		ModelAndView mav = new ModelAndView("user/userMain");
		mav.addObject("BODY", "index.jsp");
		mav.addObject(new LoginUser());
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
		ModelAndView mav = new ModelAndView("user/userMain");
		if(br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		this.userService.registerUser(user);
    	mav.addObject("BODY","registerSuccess.jsp");
    	mav.addObject("user",user);
    	return mav;
	}
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
	@GetMapping(value="/user/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/user/index");
		return mav;
	}
}
