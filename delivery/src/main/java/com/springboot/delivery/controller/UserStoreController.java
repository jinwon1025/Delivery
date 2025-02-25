package com.springboot.delivery.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.service.UserStoreService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserStoreController {
	@Autowired
	private UserStoreService userStoreService;
	@PostMapping(value="/userStore/detail")
	public ModelAndView storeDetial(HttpSession session, String store_id) {
		ModelAndView mav = new ModelAndView("user/userMain");
		List<MenuCategory> mc = this.userStoreService.storeCategory(store_id);
		mav.addObject("storeCategory", mc);
		mav.addObject("BODY","storeDetail");
		return mav;
	}
}
