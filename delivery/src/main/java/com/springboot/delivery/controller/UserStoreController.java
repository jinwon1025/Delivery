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
import com.springboot.delivery.model.OrderQuantity;
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
	public ModelAndView addCart(HttpSession session, Integer menuId,
	        @RequestParam(required = false) List<Integer> selectedOptions,
	        @RequestParam(required = false) List<Integer> allOptionIds,
	        @RequestParam(required = false) List<Integer> allOptionGroupIds, Integer quantity) {
	    
	    // 필요한 사용자 및 상점 정보 가져오기
	    LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
	    Store store = (Store) session.getAttribute("currentStore");

	    // 로그인 체크
	    if (loginUser == null) {
	        return new ModelAndView("redirect:/user/index");
	    }

	    // 가게 주소 가져오기
	    String storeAddress = this.userStoreService.storeAddress(store.getStore_id());
	    
	    // 현재 장바구니 상태 확인
	    String orderId;
	    String existingCartId = this.userStoreService.isMenuInCart(loginUser.getUser_id());
	    
	    // 옵션 객체 준비 (두 경우 모두 사용)
	    List<OptionOrder> optionOrders = new ArrayList<>();
	    
	    if (selectedOptions != null && !selectedOptions.isEmpty()) {
	        for (Integer optionId : selectedOptions) {
	            int index = allOptionIds.indexOf(optionId);
	            if (index >= 0) {
	                OptionOrder optionOrder = new OptionOrder();
	                optionOrder.setOption_id(optionId);
	                optionOrder.setOption_group_id(allOptionGroupIds.get(index));
	                optionOrders.add(optionOrder);
	            }
	        }
	    }

	    if (existingCartId != null) {
	        // 장바구니에 이미 항목이 있는 경우
	        orderId = existingCartId;
	        
	        // 주문 옵션 ID 가져오기
	        Integer orderOptionId = this.userStoreService.getOrderOptionId(orderId) + 1;
	        
	        // 선택된 옵션 처리
	        if (!optionOrders.isEmpty()) {
	            for (OptionOrder option : optionOrders) {
	                OrderCart tempCart = new OrderCart();
	                tempCart.setOrder_option_id(orderOptionId);
	                tempCart.setOrder_id(orderId);
	                tempCart.setMenu_item_id(menuId);
	                tempCart.setOption_id(option.getOption_id());
	                tempCart.setOption_group_id(option.getOption_group_id());

	                userStoreService.insertOrderOption(tempCart);
	            }
	            
	            // 수량 정보 추가
	            OrderQuantity oq = new OrderQuantity();
	            oq.setOrder_option_id(orderOptionId);
	            oq.setQuantity(quantity);
	            oq.setOrder_id(orderId);
	            userStoreService.insertOrderItemQuantity(oq);
	        }
	    } else {
	        // 장바구니가 비어있는 경우
	        orderId = generateOrderId();
	        
	        // 새 주문 카트 생성
	        OrderCart orderCart = new OrderCart();
	        orderCart.setOrder_id(orderId);
	        orderCart.setUser_id(loginUser.getUser_id());
	        orderCart.setStore_id(store.getStore_id());
	        orderCart.setStore_address(storeAddress);
	        orderCart.setOrder_status(0);
	        orderCart.setMenu_item_id(menuId);
	        
	        // 기본 주문 정보 입력
	        userStoreService.insertOrder(orderCart);
	        userStoreService.insertOrderDetail(orderCart);
	        
	        // 선택된 옵션 처리
	        if (!optionOrders.isEmpty()) {
	            // 옵션 ID 결정
	            Integer maxCount = this.userStoreService.getMaxCountOrderOption();
	            Integer orderOptionId = (maxCount == null) ? 1 : maxCount + 1;
	            
	            for (OptionOrder option : optionOrders) {
	                OrderCart tempCart = new OrderCart();
	                tempCart.setOrder_option_id(orderOptionId);
	                tempCart.setOrder_id(orderId);
	                tempCart.setMenu_item_id(menuId);
	                tempCart.setOption_id(option.getOption_id());
	                tempCart.setOption_group_id(option.getOption_group_id());
	                
	                userStoreService.insertOrderOption(tempCart);
	            }
	            
	            // 수량 정보 추가
	            OrderQuantity oq = new OrderQuantity();
	            oq.setOrder_option_id(orderOptionId);
	            oq.setQuantity(quantity);
	            oq.setOrder_id(orderId);
	            userStoreService.insertOrderItemQuantity(oq);
	        }
	    }

	    // 메뉴 상세 페이지로 리다이렉트
	    return new ModelAndView("redirect:/userstore/menuDetail?menu_item_id=" + menuId);
	}


	@PostMapping(value = "/userstore/bookmark")
	public ModelAndView bookmark(HttpSession session, String loginStatus) {
		ModelAndView mav = new ModelAndView("user/userMain");
		if (loginStatus.equals("no")) {
			mav.setViewName("redirect:/user/index");
			return mav;
		}
		return null;
	}

	@GetMapping(value = "/userstore/viewCart")
	public ModelAndView viewCart(HttpSession session) {
		ModelAndView mav = new ModelAndView("user/userMain");
		LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
		OrderCart oc = this.userStoreService.getOrderByUserId(loginUser.getUser_id()); // 유저 아이디로 오더id 찾기
		String isEmptyCart = "";
		List<Map<String, Object>> cartList = this.userStoreService.getCartMenuDetails(loginUser.getUser_id());

		System.out.println("User ID: " + loginUser.getUser_id());
		System.out.println("Cart List Size: " + cartList.size());
		System.out.println("Cart List: " + cartList);

		if (cartList == null || cartList.isEmpty()) {
			isEmptyCart = "empty";
		} else {
			isEmptyCart = "notEmpty";
		}
		mav.addObject("isEmptyCart", isEmptyCart);
		mav.addObject("cartDetails", cartList);
		mav.addObject("BODY", "../userstore/userCart.jsp");

		return mav;

	}

	@GetMapping(value = "/userstore/returnToStore")
	public ModelAndView returnToStore(String store_id, HttpSession session) {
		System.out.println(store_id);
		ModelAndView mav = new ModelAndView("user/userMain");
		Store currentStore = (Store) storeService.getStore(store_id);
		session.setAttribute("currentStore", currentStore);
		List<Maincategory> maincategoryList = adminService.getAllMaincategory();
		List<MenuCategory> mc = this.userStoreService.storeCategory(store_id);
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

	@PostMapping(value = "/userstore/deleteItemInCart")
	public ModelAndView deleteItemInCart(HttpSession session, String menu_item_id, String order_id) {
		ModelAndView mav = new ModelAndView("user/userMain");
		System.out.println("(메뉴아이템 아이디) :" + menu_item_id);
		System.out.println("(오더 아이디) : " + order_id);
		this.userStoreService.deleteItemInCart(menu_item_id);
		Integer isEmptyCart = this.userStoreService.checkCountInCart(order_id); // 삭제를 했는데 카트가 비어있는지 확인
		if (isEmptyCart == 0) { // 카트가 빈 상태이기 때문에 order_tbl, order_detail_tbl 정보 삭제
			this.userStoreService.deleteOrderDetail(order_id);
			this.userStoreService.deleteOrder(order_id);
		}
		return new ModelAndView("redirect:/userstore/viewCart");
	}

}
