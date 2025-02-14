package com.springboot.delivery.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserController {

	@GetMapping(value="/user/index")
	public ModelAndView userIndex() {
		ModelAndView mav = new ModelAndView("user/index");
		return mav;
	}
	
	@GetMapping(value="/user/register")
	public ModelAndView userRegister() {
		
		ModelAndView mav = new ModelAndView("user/register");
		return mav;
	}
	
}
