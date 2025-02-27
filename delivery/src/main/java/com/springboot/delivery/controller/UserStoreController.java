package com.springboot.delivery.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.BookMarkStore;
import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.Maincategory;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionSet;
import com.springboot.delivery.model.OrderCart;
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

	public String generateOrderId() {
		return UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "").substring(0, 10);
	}

	@GetMapping(value = "/userstore/detail")
	public ModelAndView storeDetial(String store_id, HttpSession session) {
		Store currentStore = (Store) storeService.getStore(store_id);
		session.setAttribute("currentStore", currentStore);
		List<Maincategory> maincategoryList = adminService.getAllMaincategory();
		List<MenuCategory> mc = this.userStoreService.storeCategory(store_id);
		ModelAndView mav = new ModelAndView("user/userMain");
		mav.addObject("maincategoryList", maincategoryList);
		mav.addObject("storeCategory", mc);
		mav.addObject("BODY", "../userstore/userStoreMain.jsp");

		if (!mc.isEmpty()) {
			Integer firstCategoryId = mc.get(0).getMenu_category_id();
			List<MenuItem> menuList = userStoreService.menuList(firstCategoryId);
			mav.addObject("menuList", menuList);
			mav.addObject("STOREBODY", "../userstore/userMenuList.jsp");
		}
		return mav;
	}

	@GetMapping(value = "/userstore/menuList")
	public ModelAndView storeMenuList(Integer menu_category_id, HttpSession session) {
		Store store = (Store) session.getAttribute("currentStore");
		List<Maincategory> maincategoryList = adminService.getAllMaincategory();
		ModelAndView mav = new ModelAndView("user/userMain");
		mav.addObject("maincategoryList", maincategoryList);
		List<MenuItem> mi = this.userStoreService.menuList(menu_category_id);
		List<MenuCategory> mc = this.userStoreService.storeCategory(store.getStore_id());
		mav.addObject("storeCategory", mc);
		mav.addObject("BODY", "../userstore/userStoreMain.jsp");
		mav.addObject("menuList", mi);
		mav.addObject("STOREBODY", "../userstore/userMenuList.jsp");
		return mav;
	}

	@GetMapping(value = "/userstore/menuDetail")
	public ModelAndView menuDetail(Integer menu_item_id, HttpSession session) {
		Store store = (Store) session.getAttribute("currentStore");
		ModelAndView mav = new ModelAndView("user/userMain");
		List<Maincategory> maincategoryList = adminService.getAllMaincategory();
		List<MenuCategory> mc = this.userStoreService.storeCategory(store.getStore_id());
		mav.addObject("maincategoryList", maincategoryList);
		mav.addObject("storeCategory", mc);
		mav.addObject("BODY", "../userstore/userStoreMain.jsp");
		MenuItem mi = this.userStoreService.menuItemDetail(menu_item_id);
		List<OptionSet> os = this.userStoreService.optionDetail(menu_item_id);
		Map<String, List<OptionSet>> groupedOptions = new TreeMap<>();
		for (OptionSet option : os) {
			groupedOptions.computeIfAbsent(option.getOption_group_name(), k -> new ArrayList<>()).add(option);
		}
		mav.addObject("menuDetail", mi);
		mav.addObject("optionGroups", groupedOptions);
		mav.addObject("STOREBODY", "../userstore/userMenuDetail.jsp");
		return mav;
	}

	@PostMapping(value = "/userstore/addCart")
	public ModelAndView addCart(HttpSession session, Integer menuId, Integer option_group_id, Integer option_id,
			String option_name, Integer option_price) {
		LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

		Store store = (Store) session.getAttribute("currentStore");
		System.out.println("스토어 세션" + store.getStore_id());
		ModelAndView mav = new ModelAndView("user/userMain");
		OrderCart oc = new OrderCart();
		if (loginUser == null) {
			// 로그인되지 않은 경우 로그인 페이지로 리다이렉트
			mav.setViewName("redirect:/user/index");
		}
		String orderId = generateOrderId();
		String storeAddress = this.userStoreService.storeAddress(store.getStore_id());

		oc.setOrder_id(orderId);
		oc.setUser_id(loginUser.getUser_id());
		oc.setStore_id(store.getStore_id());
		oc.setStore_address(storeAddress);
		oc.setOrder_status(0);
		oc.setOption_group_id(option_group_id);
		oc.setOption_id(option_id);
		oc.setOption_price(option_price);
		mav.addObject("CART", oc);
		return new ModelAndView("redirect:/userstore/menuDetail?menu_item_id=" + menuId);
	}


}
