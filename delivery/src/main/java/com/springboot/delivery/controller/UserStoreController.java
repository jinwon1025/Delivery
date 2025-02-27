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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.Maincategory;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionOrder;
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
	
	@GetMapping(value="/userstore/detail")
	public ModelAndView storeDetial(String store_id, HttpSession session) {
		Store currentStore = (Store)storeService.getStore(store_id);
		session.setAttribute("currentStore", currentStore);
		List<Maincategory> maincategoryList = adminService.getAllMaincategory();
		List<MenuCategory> mc = this.userStoreService.storeCategory(store_id);
		ModelAndView mav = new ModelAndView("user/userMain");
		mav.addObject("maincategoryList",maincategoryList);
		mav.addObject("storeCategory", mc);
		mav.addObject("BODY","../userstore/userStoreMain.jsp");
		
		if (!mc.isEmpty()) {
			Integer firstCategoryId = mc.get(0).getMenu_category_id();
			List<MenuItem> menuList = userStoreService.menuList(firstCategoryId);
			mav.addObject("menuList", menuList);
			mav.addObject("STOREBODY", "../userstore/userMenuList.jsp");
		}
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
	@GetMapping(value="/userstore/menuDetail")
	public ModelAndView menuDetail(Integer menu_item_id,HttpSession session) {
		Store store = (Store)session.getAttribute("currentStore");
		ModelAndView mav = new ModelAndView("user/userMain");
		List<Maincategory> maincategoryList = adminService.getAllMaincategory();
		List<MenuCategory> mc = this.userStoreService.storeCategory(store.getStore_id());
		mav.addObject("maincategoryList",maincategoryList);
		mav.addObject("storeCategory", mc);
		mav.addObject("BODY","../userstore/userStoreMain.jsp");
		MenuItem mi = this.userStoreService.menuItemDetail(menu_item_id);
		List<OptionSet> os = this.userStoreService.optionDetail(menu_item_id);
		Map<String, List<OptionSet>> groupedOptions = new TreeMap<>();
	    for (OptionSet option : os) {
	        groupedOptions
	            .computeIfAbsent(option.getOption_group_name(), k -> new ArrayList<>())
	            .add(option);
	    }
		mav.addObject("menuDetail",mi);
		mav.addObject("optionGroups",groupedOptions);
		mav.addObject("STOREBODY","../userstore/userMenuDetail.jsp");
		return mav;
	}
	@PostMapping(value="/userstore/addCart")
	public ModelAndView addCart(HttpSession session, 
	                          Integer menuId,
	                          @RequestParam(required=false) List<Integer> selectedOptions,
	                          @RequestParam(required=false) List<Integer> allOptionIds,
	                          @RequestParam(required=false) List<Integer> allOptionGroupIds) {
	    
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	    Store store = (Store) session.getAttribute("currentStore");
	    ModelAndView mav = new ModelAndView("user/userMain");
	    
	    if (loginUser == null) {
	        // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
	        mav.setViewName("redirect:/user/index");
	        return mav;
	    }
	    
	    // 주문 ID 생성 및 가게 주소 가져오기
	    String orderId = generateOrderId();
	    String storeAddress = this.userStoreService.storeAddress(store.getStore_id());
	    
	    // OrderCart 객체 생성
	    OrderCart orderCart = new OrderCart();
	    orderCart.setOrder_id(orderId);
	    orderCart.setUser_id(loginUser.getUser_id());
	    orderCart.setStore_id(store.getStore_id());
	    orderCart.setStore_address(storeAddress);
	    orderCart.setOrder_status(0);
	    orderCart.setMenu_item_id(menuId);
	    
	    // 주문 기본 정보 삽입
	    userStoreService.insertOrder(orderCart);
	    
	    // 주문 상세 정보 삽입
	    userStoreService.insertOrderDetail(orderCart);
	    
	    // 선택된 옵션이 있다면 처리
	    if (selectedOptions != null && !selectedOptions.isEmpty()) {
	        List<OptionOrder> optionOrders = new ArrayList<>();
	        
	        for (Integer optionId : selectedOptions) {
	            // allOptionIds 리스트에서 이 옵션의 인덱스 찾기
	            int index = allOptionIds.indexOf(optionId);
	            if (index >= 0) {
	                OptionOrder optionOrder = new OptionOrder();
	                optionOrder.setOption_id(optionId);
	                optionOrder.setOption_group_id(allOptionGroupIds.get(index));
	                optionOrders.add(optionOrder);
	            }
	        }
	        
	        // 주문 카트에 옵션 설정
	        orderCart.setOptions(optionOrders);
	        
	        // 옵션을 데이터베이스에 삽입
	        for (OptionOrder option : optionOrders) {
	            OrderCart tempCart = new OrderCart();
	            tempCart.setOrder_id(orderId);
	            tempCart.setMenu_item_id(menuId);
	            tempCart.setOption_id(option.getOption_id());
	            tempCart.setOption_group_id(option.getOption_group_id());
	            
	            userStoreService.insertOrderOption(tempCart);
	        }
	    }
	    
	    // 메뉴 상세 페이지로 리다이렉트
	    return new ModelAndView("redirect:/userstore/menuDetail?menu_item_id=" + menuId);
	}
	
	@PostMapping(value="/userstore/bookmark")
	public ModelAndView bookmark(HttpSession session, String loginStatus) {
		ModelAndView mav = new ModelAndView("user/userMain");
		if(loginStatus.equals("no")) {
			 mav.setViewName("redirect:/user/index");
		        return mav;
		}
		return null;
	}
	
}
