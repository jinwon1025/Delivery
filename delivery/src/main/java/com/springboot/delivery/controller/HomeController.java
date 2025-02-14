package com.springboot.delivery.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.service.SalesService;

@Controller
public class HomeController {


	@GetMapping(value="/home/userIndex")
	public ModelAndView userIndex() {
		ModelAndView mav = new ModelAndView("user/index");
		return mav;
	}
	
	@GetMapping(value="/home/ownerIndex")
	public ModelAndView ownerIndex() {
		ModelAndView mav = new ModelAndView("owner/index");
		return mav;
	}
}
