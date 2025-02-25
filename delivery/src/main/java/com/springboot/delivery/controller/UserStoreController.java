package com.springboot.delivery.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.Maincategory;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.service.AdminService;
import com.springboot.delivery.service.StoreService;
import com.springboot.delivery.service.UserStoreService;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserStoreController {
	@Autowired
	private UserStoreService userStoreService;
	@Autowired
	private StoreService storeService;
	@Autowired
	private AdminService adminService;
	@GetMapping(value="/userstore/detail")
	public ModelAndView storeDetial(String store_id, HttpSession session) {
		Store currentStore = (Store)storeService.getStore(store_id);
		session.setAttribute("currentStore", currentStore);
		List<Maincategory> maincategoryList = adminService.getAllMaincategory();
		ModelAndView mav = new ModelAndView("user/userMain");
		mav.addObject("maincategoryList",maincategoryList);
		List<MenuCategory> mc = this.userStoreService.storeCategory(store_id);
		mav.addObject("storeCategory", mc);
		mav.addObject("BODY","../userstore/userStoreMain.jsp");
		return mav;
	}
	@GetMapping(value="/userstore/menuList")
	public ModelAndView storeMenuList(Integer menu_category_id,HttpSession session) {
		Store store = (Store)session.getAttribute("currentStore");
		List<Maincategory> maincategoryList = adminService.getAllMaincategory();
		ModelAndView mav = new ModelAndView("user/userMain");
		mav.addObject("maincategoryList",maincategoryList);
		List<MenuItem> mi = this.userStoreService.menuList(menu_category_id);
		List<MenuCategory> mc = this.userStoreService.storeCategory(store.getStore_id());
		mav.addObject("storeCategory", mc);
		mav.addObject("BODY","../userstore/userStoreMain.jsp");
		mav.addObject("menuList", mi);
		mav.addObject("STOREBODY","../userstore/userMenuList.jsp");
		return mav;
	}
}
