package com.springboot.delivery.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.service.SalesService;

@Controller
public class HomeController {

	
	@Autowired
	private SalesService salesSerivce;
	@GetMapping(value="/home/index")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView("index");
		Integer count = this.salesSerivce.getUserCount();
		mav.addObject("count", count);
		return mav;
	}
}
