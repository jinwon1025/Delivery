package com.springboot.delivery.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class OwnerController {

	
	@GetMapping(value="/owner/index")
	public ModelAndView ownerIndex() {
		ModelAndView mav = new ModelAndView("owner/index");
		return mav;
	}
	
	@GetMapping(value="/owner/register")
	public ModelAndView ownerRegister() {
		
		ModelAndView mav = new ModelAndView("owner/register");
		return mav;
	}
}
