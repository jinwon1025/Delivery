package com.springboot.delivery.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.Owner;
import com.springboot.delivery.service.OwnerService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class OwnerController {

	@Autowired
	private OwnerService ownerSerivce;
	
	@GetMapping(value="/owner/index")
	public ModelAndView ownerIndex() {
		ModelAndView mav = new ModelAndView("owner/index");
		mav.addObject(new LoginOwner());
		return mav;
	}
	
	@PostMapping(value="/owner/register")
	public ModelAndView ownerRegister(@Valid Owner owner, BindingResult br) {
		
		ModelAndView mav = new ModelAndView("owner/register");
		if(br.hasErrors()){
			mav.getModel().putAll(br.getModel());
	        br.getFieldErrors().forEach(error -> {
	            System.out.println("Field: " + error.getField() + ", Error: " + error.getDefaultMessage());
	        });

			return mav;
		}
		if(owner.getOwner_image_name()=="") {
			owner.setOwner_image_name("");
		}
		System.out.println("아이디 체크 여부: " + owner.getIdchecked());
        System.out.println("비밀번호 체크 여부: " + owner.getPasswordchecked());
        System.out.println("아이디: " + owner.getOwner_id());
        System.out.println("이름: " + owner.getOwner_name());
        System.out.println("이메일: " + owner.getOwner_email());
        System.out.println("암호: " + owner.getOwner_password());
        System.out.println("전화번호: " + owner.getOwner_phone());
        System.out.println("프로필 이미지 이름: " + owner.getOwner_image_name());
		this.ownerSerivce.registerOwner(owner);
		
		mav.setViewName("owner/index");
		mav.addObject(new LoginOwner());
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
	
	@PostMapping(value="/owner/loginDo")
	public ModelAndView login(@Valid LoginOwner loginOwner, BindingResult br, HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		if(br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		LoginOwner owner = this.ownerSerivce.login(loginOwner);
		if(owner == null) {
			mav.addObject("FAIL", "YES");
		} else {
			session.setAttribute("loginOwner", owner);
		}
		return mav;
	}
}
