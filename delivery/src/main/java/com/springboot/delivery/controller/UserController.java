package com.springboot.delivery.controller;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.User;

import jakarta.validation.Valid;



@Controller
public class UserController {
	
	@GetMapping(value="/user/index")
	public ModelAndView userIndex() {
		ModelAndView mav = new ModelAndView("user/index");
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
			System.out.println("생일"+user.getBirth());
			return mav;
		}
		System.out.println("생일"+user.getBirth());
		return mav;
	}

	
}
