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

}
