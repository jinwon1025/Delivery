package com.springboot.delivery.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.Owner;
import com.springboot.delivery.service.OwnerService;

import jakarta.validation.Valid;

@Controller
public class OwnerController {

	@Autowired
	private OwnerService ownerSerivce;
	
	@GetMapping(value="/owner/index")
	public ModelAndView ownerIndex() {
		ModelAndView mav = new ModelAndView("owner/index");
		return mav;
	}
	
	@PostMapping(value="/owner/register")
	public ModelAndView ownerRegister(@Valid Owner owner, BindingResult br) {
		
		ModelAndView mav = new ModelAndView("owner/register");
		if(br.hasErrors()){
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		this.ownerSerivce.registerOwner(owner);
		mav.setViewName("result");
		return mav;
	}
	
	@GetMapping(value="/owner/goRegister")
	public ModelAndView ownerRegister() {
		
		ModelAndView mav = new ModelAndView("owner/register");
		mav.addObject(new Owner());
		return mav;
	}
	
	@GetMapping(value="/owner/idcheck")
	public ModelAndView idcheck(String owner_id) {
		ModelAndView mav = new ModelAndView("owner/idcheck");
		Integer count = this.ownerSerivce.idCheck(owner_id);
		if(count > 0) {
			mav.addObject("DUP", "YES");
		}
		else {
			mav.addObject("DUP", "NO");
		}
		mav.addObject("owner_id", owner_id);
		return mav;
		
	}
}
