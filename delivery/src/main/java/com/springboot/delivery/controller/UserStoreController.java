package com.springboot.delivery.controller;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.CartUser;
import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.Maincategory;
import com.springboot.delivery.model.MatchingOptionParam;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionOrder;
import com.springboot.delivery.model.OptionSet;
import com.springboot.delivery.model.OrderCart;
import com.springboot.delivery.model.OrderQuantity;
import com.springboot.delivery.model.QuantityUpdateParam;
import com.springboot.delivery.model.Review;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.StoreCoupon;
import com.springboot.delivery.model.UsedCoupon;
import com.springboot.delivery.model.User;
import com.springboot.delivery.model.UserCard;
import com.springboot.delivery.model.UserCoupon;
import com.springboot.delivery.model.UserCouponDetail;
import com.springboot.delivery.service.AdminService;
import com.springboot.delivery.service.StoreService;
import com.springboot.delivery.service.UserService;
import com.springboot.delivery.service.UserStoreService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserStoreController {
   @Autowired
   private UserStoreService userStoreService;
   @Autowired
   private StoreService storeService;
   @Autowired
   private AdminService adminService;
   @Autowired
   private UserService userService;

   public String generateOrderId() {
      return UUID.randomUUID().toString().replaceAll("[^a-zA-Z0-9]", "").substring(0, 10);
   }

   @GetMapping(value = "/userstore/detail")
   public ModelAndView storeDetial(String store_id, HttpSession session) {
      Store currentStore = (Store) storeService.getStore(store_id);
      session.setAttribute("currentStore", currentStore);
      LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

      // 현재 로그인한 사용자 ID 가져오기
      String userId = (String) session.getAttribute("userId");

      List<Maincategory> maincategoryList = adminService.getAllMaincategory();
      List<MenuCategory> mc = this.userStoreService.storeCategory(store_id);

      ModelAndView mav = new ModelAndView("user/userMain");
      mav.addObject("maincategoryList", maincategoryList);
      mav.addObject("storeCategory", mc);
      mav.addObject("BODY", "../userstore/userStoreMain.jsp");

      StoreCoupon sc = new StoreCoupon();
      sc.setStore_id(currentStore.getStore_id());
      sc.setUser_id(loginUser.getUser_id());

      // 사용 가능한 쿠폰 목록 조회
      List<Map<String, Object>> availableCoupons = userStoreService.getStoreCouponList(sc);
      mav.addObject("availableCoupons", availableCoupons);
      System.out.println("=== 조회된 쿠폰 정보 ===");
      System.out.println("조회된 쿠폰 수: " + (availableCoupons != null ? availableCoupons.size() : "null"));

      if (availableCoupons != null && !availableCoupons.isEmpty()) {
         for (Map<String, Object> coupon : availableCoupons) {
            System.out.println(coupon);
         }
      }

      if (!mc.isEmpty()) {
         Integer firstCategoryId = mc.get(0).getMenu_category_id();
         List<MenuItem> menuList = userStoreService.getAllMenusByStoreId(store_id);
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
      LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
      ModelAndView mav = new ModelAndView("user/userMain");

      List<Maincategory> maincategoryList = adminService.getAllMaincategory();
      List<MenuCategory> mc = this.userStoreService.storeCategory(store.getStore_id());
      mav.addObject("maincategoryList", maincategoryList);
      mav.addObject("storeCategory", mc);
      mav.addObject("BODY", "../userstore/userStoreMain.jsp");

      MenuItem mi = this.userStoreService.menuItemDetail(menu_item_id);

      // 장바구니 관련 로직
      OrderCart oc = new OrderCart();
      oc.setUser_id(loginUser.getUser_id());
      oc.setOrder_status(0);
      System.out.println("유저 아이디" + oc.getUser_id());
      String existingOrderId = this.userStoreService.findOrderByUserId(oc);
      String existingOrderStoreId = "none"; // 기본값

      // 장바구니 상태를 확인하여 결과 저장
      boolean showModal = false;

      if (existingOrderId != null) {
         oc.setOrder_id(existingOrderId);
         oc.setOrder_status(0);
         existingOrderStoreId = this.userStoreService.findStoreByMenuItemInCart(oc);

         // 장바구니가 비어있지 않고, 다른 가게의 상품이 담겨있는 경우
         if (existingOrderStoreId != null && !existingOrderStoreId.equals(store.getStore_id())) {
            showModal = true;
         }
      }

      // 결과를 모델에 추가
      mav.addObject("showModal", showModal);

      List<OptionSet> os = this.userStoreService.optionDetail(menu_item_id);
      Map<String, List<OptionSet>> groupedOptions = new TreeMap<>();
      for (OptionSet option : os) {
         groupedOptions.computeIfAbsent(option.getOption_group_name(), k -> new ArrayList<>()).add(option);
      }

      // 옵션 정보 로깅
      System.out.println("====== 옵션 정보 ======");
      for (OptionSet option : os) {
         System.out.println("옵션 ID: " + option.getOption_id() + ", 이름: " + option.getOption_name() + ", 가격: "
               + option.getOption_price() + ", 그룹 ID: " + option.getOption_group_id() + ", 그룹 이름: "
               + option.getOption_group_name() + ", 선택 타입: " + option.getSelection_type());
      }

      // 그룹화된 옵션 정보 로깅
      System.out.println("\n====== 그룹화된 옵션 정보 ======");
      for (Map.Entry<String, List<OptionSet>> entry : groupedOptions.entrySet()) {
         System.out.println("그룹 이름: " + entry.getKey());
         System.out.println("옵션 개수: " + entry.getValue().size());
         if (!entry.getValue().isEmpty()) {
            System.out.println("선택 타입: " + entry.getValue().get(0).getSelection_type());
         }
         System.out.println("------");
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

      System.out.println("로그인유저 아이디아이디:" + loginUser.getUser_id());

      // 현재 사용자의 장바구니(order_status=0) 주문 ID 가져오기
      String existingCartId = this.userStoreService.isMenuInCart(loginUser.getUser_id());

      if (existingCartId == null) {
         System.out.println("장바구니에 이전 항목이 없습니다.");
      }

      // 옵션 객체 준비 - 선택된 옵션들 처리
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

      String orderId;
      if (existingCartId != null) {
         System.out.println("이미 장바구니에 항목이 있습니다");
         // 기존 장바구니 사용
         orderId = existingCartId;
         OrderCart oc = new OrderCart();
         oc.setUser_id(loginUser.getUser_id());
         oc.setOrder_id(existingCartId);
         oc.setOrder_status(0);

         // 현재 장바구니에 있는 상점 ID 확인
         String storeIdInOrder = this.userStoreService.findStoreByMenuItemInCart(oc);
         String currentStoreId = store.getStore_id();

         if (storeIdInOrder == null || !storeIdInOrder.equals(currentStoreId)) {
            // 다른 가게 상품을 담으려는 경우 - 기존 장바구니 아이템 삭제 후 가게 정보 업데이트
            System.out.println("장바구니에 있는 가게와 다른 가게에서 주문합니다");

            // 기존 주문 옵션과 수량 정보 삭제
            this.userStoreService.deleteOrderQuantityInCart(existingCartId);
            this.userStoreService.deleteOrderOptionInCart(existingCartId);

            // 주문 정보를 새 가게 정보로 업데이트
            OrderCart updateStoreCart = new OrderCart();
            updateStoreCart.setOrder_id(existingCartId);
            updateStoreCart.setStore_id(store.getStore_id());
            updateStoreCart.setStore_address(storeAddress);
            this.userStoreService.updateOrderStore(updateStoreCart);

            // 선택된 옵션 처리
            if (!optionOrders.isEmpty()) {
               // 옵션 ID 얻기
               Integer maxCount = this.userStoreService.getMaxCountOrderOption();
               Integer orderOptionId = (maxCount == null) ? 1 : maxCount + 1;

               // 각 옵션 추가
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
            System.out.println("장바구니에 있는 가게와 같은 가게에서 주문합니다");

            // 옵션이 있는 메뉴인 경우 동일한 메뉴와 옵션 조합이 있는지 확인
            if (!optionOrders.isEmpty()) {
               MatchingOptionParam mop = new MatchingOptionParam();
               mop.setOrderId(existingCartId);
               mop.setMenuItemId(menuId);
               mop.setOptionList(optionOrders);
               mop.setOptionCount(optionOrders.size());

               Integer matchingOptionId = userStoreService.findMatchingOptionId(mop);

               if (matchingOptionId != null) {
                  // 동일한 메뉴와 옵션 조합이 이미 있으면 수량만 증가
                  System.out.println("동일한 메뉴와 옵션 조합이 있어 수량만 증가시킵니다");
                  QuantityUpdateParam qup = new QuantityUpdateParam();
                  qup.setOrderOptionId(matchingOptionId);
                  qup.setOrderId(existingCartId);
                  qup.setAdditionalQuantity(quantity);

                  userStoreService.increaseQuantity(qup);

                  return new ModelAndView("redirect:/userstore/menuDetail?menu_item_id=" + menuId);
               }
            }

            // 동일 메뉴+옵션 조합이 없거나 옵션이 없는 경우 새 항목 추가
            System.out.println("카트에 없는 메뉴를 추가합니다");
            Integer orderOptionId = this.userStoreService.getOrderOptionId(orderId);
            orderOptionId = (orderOptionId == null) ? 1 : orderOptionId + 1;

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
         }
      } else {
         // 장바구니가 비어있는 경우 - 새 주문 생성
         System.out.println("장바구니가 비어있어 새 주문을 생성합니다");
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

      // loginUser가 null인 경우 처리
      if (loginUser == null) {
         return new ModelAndView("redirect:/user/index"); // 로그인 페이지로 리다이렉트
      }

      // 기본 화면 설정
      List<Maincategory> maincategoryList = adminService.getAllMaincategory();
      mav.addObject("maincategoryList", maincategoryList);
      mav.addObject("BODY", "../userstore/userStoreMain.jsp");

      // 주문 정보 가져오기
      OrderCart oc = this.userStoreService.getOrderByUserId(loginUser.getUser_id());

      // oc가 null인 경우 처리
      if (oc == null) {
         mav.addObject("isEmptyCart", "empty");
         mav.addObject("STOREBODY", "../userstore/userCart.jsp");
         return mav;
      }

      // 장바구니 정보 가져오기
      String isEmptyCart = "";
      List<Map<String, Object>> cartList = this.userStoreService.getCartMenuDetails(loginUser.getUser_id());

      System.out.println("User ID: " + loginUser.getUser_id());
      System.out.println("Order ID: " + oc.getOrder_id());

      // cartList가 null이거나 비어있는 경우 처리
      if (cartList == null || cartList.isEmpty()) {
         mav.addObject("isEmptyCart", "empty");
         mav.addObject("STOREBODY", "../userstore/userCart.jsp");
         return mav;
      }

      System.out.println("Cart List Size: " + cartList.size());
      System.out.println("Cart List: " + cartList);

      OrderCart oc1 = new OrderCart();
      oc1.setOrder_id(oc.getOrder_id());
      oc1.setUser_id(loginUser.getUser_id());
      oc1.setOrder_status(0);

      System.out.println("로그인 유저 아이디 : " + loginUser.getUser_id());
      System.out.println("orderId : " + oc.getOrder_id());
      System.out.println("userId : " + oc.getUser_id());
      System.out.println("orderStatus : " + oc.getOrder_status());

      String store_id = this.userStoreService.findStoreByMenuItemInCart(oc1);
      Integer delivery_fee = this.userStoreService.getDeliveryFee(store_id);

      mav.addObject("isEmptyCart", "notEmpty");
      mav.addObject("cartDetails", cartList);
      mav.addObject("deliveryFee", delivery_fee);
      mav.addObject("STOREBODY", "../userstore/userCart.jsp");

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
   public ModelAndView deleteItemInCart(HttpSession session, String menu_item_id, String order_id,
         String order_option_id) {
      ModelAndView mav = new ModelAndView("user/userMain");
      System.out.println("(메뉴아이템 아이디) :" + menu_item_id);
      System.out.println("(오더 아이디) : " + order_id);
      OrderCart oc = new OrderCart();
      oc.setOrder_option_id(Integer.parseInt(order_option_id));
      oc.setOrder_id(order_id);

      this.userStoreService.deleteItemInCart(oc);
      this.userStoreService.deleteQuantityInCart(oc);
      Integer isEmptyCart = this.userStoreService.checkCountInCart(order_id); // 삭제를 했는데 카트가 비어있는지 확인
      if (isEmptyCart == 0) { // 카트가 빈 상태이기 때문에 order_tbl, order_detail_tbl 정보 삭제
         this.userStoreService.deleteOrderDetail(order_id);
         this.userStoreService.deleteOrder(order_id);
      }
      return new ModelAndView("redirect:/userstore/viewCart");
   }

   @GetMapping(value = "/userStore/startOrder")
   public ModelAndView startOrder(HttpSession session, String totalPrice, String deliveryFee, String finalTotalPrice,
         String order_Id) {
      LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
      ModelAndView mav = new ModelAndView("user/userMain");
      mav.addObject("BODY", "../userstore/startOrder.jsp");
      CartUser cu = this.userStoreService.cartUserData(loginUser.getUser_id());
      
      StoreCoupon sc = new StoreCoupon();
       sc.setUser_id(loginUser.getUser_id());
       sc.setMinimum_purchase(Integer.parseInt(totalPrice));
       
      List<Map<String, Object>> userCoupons = userStoreService.getUserCoupons(sc);
      List<UserCard> uc = this.userService.userCardLIst(loginUser.getUser_id());
      Integer password = userService.getPayPassword(loginUser.getUser_id());
      mav.addObject("cardList", uc);
      mav.addObject("userCoupons", userCoupons);
      mav.addObject("userInfo", cu);
      mav.addObject("totalPrice", totalPrice);
      mav.addObject("deliveryFee", deliveryFee);
      mav.addObject("finalTotalPrice", finalTotalPrice);
      mav.addObject("hasPaymentPassword", password);
      System.out.println("결제창 오더 아이디:" + order_Id);
      mav.addObject("order_Id", order_Id);
      return mav;
   }
	@PostMapping(value = "/userstore/pay")
	public ModelAndView pay(HttpSession session, String riderRequest, String storeRequest, String order_Id,
	                        String finalTotal, String selectedCouponId, String paymentMethod, String pointValue) {
	    ModelAndView mav = new ModelAndView("user/userMain");
	    LoginUser loginUser = (LoginUser)session.getAttribute("loginUser");
	    
	    // 주문 상태 확인
	    OrderCart orderStatusCart = this.userStoreService.getOrderStatus(order_Id);
	    
	    // 디버깅을 위해 order_status 값 확인
	    System.out.println("orderStatusCart.getOrder_status(): " + orderStatusCart.getOrder_status());
	    
	    Integer currentStatus = orderStatusCart.getOrder_status();
	    
	    // 이미 처리된 주문인 경우 (주문 상태가 0이 아닌 경우)
	       if (currentStatus != 0) {
	           System.out.println("새로고침 했는데 상태가 0이 아님: " + currentStatus);
	           mav.addObject("orderCart", orderStatusCart);
	           mav.addObject("TOTALPRICE", finalTotal);
	           mav.addObject("BODY", "../userstore/end.jsp");
	           return mav;
	       }
	    
	    try {
	        // 포인트 처리 로직 추가
	        if(pointValue != null && !pointValue.isEmpty()) {
	            int usedPoints = Integer.parseInt(pointValue);
	            if(usedPoints > 0) {
	                // 현재 사용자의 포인트 가져오기
	                Integer currentPoints = this.userStoreService.getPoint(loginUser.getUser_id());
	                
	                // 사용한 포인트만큼 차감
	                Integer remainingPoints = currentPoints - usedPoints;
	                
	                // 사용자 객체에 업데이트할 포인트 설정
	                User user = new User();
	                user.setUser_id(loginUser.getUser_id());
	                user.setPoint(remainingPoints);
	                
	                // 포인트 업데이트 서비스 호출
	                this.userStoreService.updatePoint(user);
	                
	                System.out.println("사용한 포인트: " + usedPoints);
	                System.out.println("남은 포인트: " + remainingPoints);
	            }
	        }
	        
	        // 포인트 적립 처리
	        Integer userPoint = this.userStoreService.getPoint(loginUser.getUser_id());
	        double pointRate = adminService.getpointRate();
	        Integer point = (int)(Integer.parseInt(finalTotal) * pointRate);
	        Integer userTotalPoint = userPoint + point;
	        User user = new User();
	        user.setPoint(userTotalPoint);
	        user.setUser_id(loginUser.getUser_id());
	        this.userStoreService.updatePoint(user);
	        
	        // 주문 정보와 사용자 주소가 포함된 OrderCart 객체 가져오기
	        OrderCart orderWithAddress = this.userStoreService.getOrderInfoWithAddress(order_Id);
	        
	        // 쿠폰 처리
	        if (selectedCouponId != null && !selectedCouponId.isEmpty() && !selectedCouponId.equals("0")) {
	            int couponId = Integer.parseInt(selectedCouponId);
	            
	            UserCoupon uc = new UserCoupon();
	            uc.setOrder_id(order_Id);
	            uc.setUser_cp_id(couponId);
	            
	            // b_order_tbl에 user_cp_id 넣기1
	            this.userStoreService.updateUserCoupon(uc);
	            
	            // b_user_coupon_tbl의 status 변경
	            this.userStoreService.updateUserCouponStatus(couponId);
	            
	            // 쿠폰 관련 정보 가져오기
	            Map<String, Object> couponInfo = this.userStoreService.getCouponInfoByUserCouponId(couponId);
	            
	            if (couponInfo != null) {
	                System.out.println("USER_CP_ID: " + couponInfo.get("USER_CP_ID"));
	                System.out.println("STORE_COUPON_ID: " + couponInfo.get("STORE_COUPON_ID"));
	                System.out.println("OWNER_COUPON_ID: " + couponInfo.get("OWNER_COUPON_ID"));
	                System.out.println("CP_NAME: " + couponInfo.get("CP_NAME"));
	                System.out.println("SALE_PRICE: " + couponInfo.get("SALE_PRICE"));
	                System.out.println("MINIMUM_PURCHASE: " + couponInfo.get("MINIMUM_PURCHASE"));
	                
	                // 사용된 쿠폰 정보 저장
	                UsedCoupon udc = new UsedCoupon();
	                
	                Integer maxCount = this.userStoreService.getMaxCountUsedCoupon();
	                if(maxCount == null) {
	                    maxCount = 0;
	                }
	                
	                udc.setUsed_cp_id(maxCount+1);
	                udc.setOrder_id(order_Id);
	                udc.setUser_id(loginUser.getUser_id());
	                udc.setUsed_date(new String());
	                udc.setStore_coupon_id(Integer.valueOf(couponInfo.get("STORE_COUPON_ID").toString()));
	                udc.setOwner_coupon_id(Integer.valueOf(couponInfo.get("OWNER_COUPON_ID").toString()));
	                udc.setUser_cp_id(Integer.valueOf(couponInfo.get("USER_CP_ID").toString()));
	                
	                this.userStoreService.insertUsedCoupon(udc);
	            }
	        }
	        
	        // 최종적으로 주문 상태 업데이트 (가장 마지막에 수행)
	        if (orderWithAddress != null) {
	            // 필요한 정보 설정
	            orderWithAddress.setToowner(storeRequest);
	            orderWithAddress.setTorider(riderRequest);
	            orderWithAddress.setTotalPrice(Integer.parseInt(finalTotal));
	            orderWithAddress.setOrder_id(order_Id);
	            orderWithAddress.setOrder_status(1); // 주문완료 처리
	            
	            // 수정된 객체로 결제 정보 저장
	            this.userStoreService.insertPay(orderWithAddress);
	            
	            // 모델에 객체 추가
	            mav.addObject("orderCart", orderWithAddress);
	        } else {
	            // 쿼리 결과가 없을 경우 새 객체 생성
	            OrderCart oc = new OrderCart();
	            oc.setToowner(storeRequest);
	            oc.setTorider(riderRequest);
	            oc.setOrder_id(order_Id);
	            oc.setTotalPrice(Integer.parseInt(finalTotal));
	            oc.setOrder_status(1);
	            
	            // 현금 결제 시 주소 정보를 추가
	            CartUser cartUser = this.userStoreService.cartUserData(loginUser.getUser_id());
	            if (cartUser != null) {
	                oc.setUser_address(cartUser.getUser_address());
	            }
	            
	            // 만약 CartUser에서 주소를 가져올 수 없다면 주문 정보에서 가져오기 시도
	            if (oc.getUser_address() == null || oc.getUser_address().isEmpty()) {
	                // 주문 기본 정보에서 주소 가져오기
	                Map<String, Object> orderInfo = this.userStoreService.getOrderInfoByOrderId(order_Id);
	                if (orderInfo != null && orderInfo.containsKey("USER_ADDRESS")) {
	                    oc.setUser_address((String) orderInfo.get("USER_ADDRESS"));
	                }
	            }
	            
	            // 결제 정보 저장
	            this.userStoreService.insertPay(oc);
	            
	            mav.addObject("orderCart", oc);
	        }
	        
	        //결제 시간 바꾸기 (원래는 장바구니에 음식 넣을 때 시간이 들어가있음.)
	        this.userStoreService.insertOrderDate(order_Id);
	        
	    } catch (Exception e) {
	        // 오류 처리
	        e.printStackTrace();
	        mav.addObject("error", "결제 처리 중 오류가 발생했습니다.");
	        return mav;
	    }
	    
	    // 추가 정보 모델에 추가
	    mav.addObject("TOTALPRICE", finalTotal);
	    mav.addObject("BODY", "../userstore/end.jsp");
	    System.out.println("결제카드 아이디 : " + paymentMethod);
	    return mav;
	}

   @GetMapping(value = "/userstore/myOrderList")
   public ModelAndView myOrderList(HttpSession session) {
      ModelAndView mav = new ModelAndView("user/userMain");

      LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
      if (loginUser == null) {
         return new ModelAndView("redirect:/user/index");
      }

      // 기본 페이지 설정
      List<Maincategory> maincategoryList = adminService.getAllMaincategory();
      mav.addObject("maincategoryList", maincategoryList);

      // 주문 목록 가져오기
      List<Map<String, Object>> orderList = userStoreService.getOrderListByUserId(loginUser.getUser_id());

      for (Map<String, Object> order : orderList) {
         String orderId = (String) order.get("ORDER_ID");
         Integer reviewCount = userStoreService.checkReviewExists(orderId);
         boolean hasReview = (reviewCount != null && reviewCount > 0);
         order.put("HAS_REVIEW", hasReview);
      }

      mav.addObject("orderList", orderList);
      mav.addObject("activeMenu", "myOrderList");
      mav.addObject("contentPage", "myOrderList");
      mav.addObject("BODY", "mypage.jsp");

      return mav;
   }

   @GetMapping(value = "/userstore/orderDetail")
   public ModelAndView orderDetail(HttpSession session, @RequestParam String orderId) {
      ModelAndView mav = new ModelAndView("user/userMain");
      LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

      // 로그인 체크
      if (loginUser == null) {
         return new ModelAndView("redirect:/user/index");
      }

      // 기본 페이지 설정
      List<Maincategory> maincategoryList = adminService.getAllMaincategory();
      mav.addObject("maincategoryList", maincategoryList);

      // 주문 기본 정보 가져오기
      Map<String, Object> orderInfo = userStoreService.getOrderInfoByOrderId(orderId);

      // 디버깅: 주문 기본 정보 로그 출력
      System.out.println("====== 주문 기본 정보 ======");
      for (Map.Entry<String, Object> entry : orderInfo.entrySet()) {
         System.out.println(entry.getKey() + ": " + entry.getValue());
      }

      // 주문 상세 메뉴 정보 가져오기
      List<Map<String, Object>> orderItems = userStoreService.getOrderItemsByOrderId(orderId);

      // 디버깅: 주문 상세 메뉴 정보 로그 출력
      System.out.println("====== 주문 상세 메뉴 정보 ======");
      for (int i = 0; i < orderItems.size(); i++) {
         Map<String, Object> item = orderItems.get(i);
         System.out.println("메뉴 항목 #" + (i + 1));
         for (Map.Entry<String, Object> entry : item.entrySet()) {
            System.out.println("  " + entry.getKey() + ": " + entry.getValue());
         }
      }

      mav.addObject("orderInfo", orderInfo);
      mav.addObject("orderItems", orderItems);
      mav.addObject("BODY", "../userstore/orderDetail.jsp");

      return mav;
   }

   @GetMapping(value = "/userstore/goWriteReview")
   public ModelAndView goWriteReview(HttpSession session, String orderId, String storeId) {
      ModelAndView mav = new ModelAndView("user/userMain");
      LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

      // 로그인 체크
      if (loginUser == null) {
         return new ModelAndView("redirect:/user/index");
      }

      // 기본 페이지 설정
      List<Maincategory> maincategoryList = adminService.getAllMaincategory();
      mav.addObject("maincategoryList", maincategoryList);
      mav.addObject("orderId", orderId);

      // 주문 정보 조회
      Map<String, Object> orderInfo = userStoreService.getOrderInfoByOrderId(orderId);
      mav.addObject("orderInfo", orderInfo);

      // 리뷰 객체 생성 및 초기값 설정
      Review review = new Review();
      mav.addObject("orderId", orderId);
      mav.addObject("storeId", storeId);
      System.out.println("보내는 오더 아이디: " + orderId);
      System.out.println("보내는 가게 아이디:" + storeId);
      mav.addObject(new Review());
      mav.addObject("BODY", "../userstore/writeReview.jsp");
      return mav;
   }

   @PostMapping(value = "/userstore/submitReview")
   public ModelAndView submitReview(@Valid Review review, BindingResult br, HttpSession session,
         HttpServletRequest request) throws Exception {

      System.out.println("받은 가게 아이디: " + review.getStore_id());
      ModelAndView mav = new ModelAndView("user/userMain");
      LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
      if (br.hasErrors()) {
         mav.getModel().putAll(br.getModel());
         br.getFieldErrors().forEach(error -> {
            System.out.println("Field: " + error.getField() + ", Error: " + error.getDefaultMessage());
         });
         return mav;
      }

      MultipartFile multiFile = review.getImage(); // 파일을 읽어온다 (업로드한 파일을 서버에서 받기 위해)
      String fileName = null;
      String path = null;
      OutputStream out = null;
      if (multiFile.getOriginalFilename() == "") {
         fileName = "";
      } else {
         fileName = review.getOrder_id() + "_" + multiFile.getOriginalFilename(); // 업로드된 원본 파일명 가져오기
      }

      if (!fileName.equals("")) { // 파일이 존재하는 경우, 이미지 파일을 변경
         ServletContext ctx = session.getServletContext();
         path = ctx.getRealPath("/upload/reviewProfile/" + fileName);
         System.out.println("업로드 위치" + path);
         BufferedInputStream bis = null;
         try {
            out = new FileOutputStream(path);
            bis = new BufferedInputStream(multiFile.getInputStream());
            byte[] buffer = new byte[8192];
            int read = 0;
            while ((read = bis.read(buffer)) > 0) {
               out.write(buffer, 0, read);
            }
         } catch (Exception e) {
            e.printStackTrace();
         } finally {
            try {
               if (out != null)
                  out.close();
               if (bis != null)
                  bis.close();
            } catch (Exception e) {
            }
         }
      }
      review.setReview_image_name(fileName);
      review.setUser_id(loginUser.getUser_id());
      Integer maxCount = this.userStoreService.getMaxReviewId();
      if (maxCount == null) {
         maxCount = 0;
      }
      review.setReview_id(maxCount + 1);
      review.setGroup_id(maxCount + 1);
      review.setOrder_no(0);
      review.setParent_id(0);
      System.out.println("리뷰 아이디: " + review.getReview_id());
      System.out.println("가게 아이디: " + review.getStore_id());
      System.out.println("작성자 아이디: " + review.getUser_id());
      System.out.println("주문 아이디: " + review.getOrder_id());
      System.out.println("리뷰 내용: " + review.getReview_content());
      System.out.println("리뷰 이미지 이름: " + review.getReview_image_name());
      System.out.println("평점: " + review.getRating());
      this.userStoreService.registerReview(review);
      return new ModelAndView("redirect:/userstore/myOrderList");

   }

   @GetMapping(value = "/userstore/myReviewList")
   public ModelAndView myReviewList(HttpSession session) {
      ModelAndView mav = new ModelAndView("user/userMain");

      LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
      if (loginUser == null) {
         return new ModelAndView("redirect:/user/index");
      }

      // 사용자의 리뷰 목록 조회
      List<Map<String, Object>> reviewList = userStoreService.getMyReviewList(loginUser.getUser_id());

      mav.addObject("reviewList", reviewList);

      // 기본 페이지 설정
      List<Maincategory> maincategoryList = adminService.getAllMaincategory();
      mav.addObject("maincategoryList", maincategoryList);
      mav.addObject("activeMenu", "myReviewList");
      mav.addObject("contentPage", "myReviewList");
      mav.addObject("BODY", "mypage.jsp");

      return mav;
   }

   @GetMapping(value = "/userstore/deleteReview")
   public String deleteReview(@RequestParam("reviewId") int reviewId, HttpSession session) {
      LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

      // 로그인 체크
      if (loginUser == null) {
         return "redirect:/user/index";
      }

      // 리뷰 삭제
      userStoreService.deleteReview(reviewId);

      return "redirect:/userstore/myReviewList";
   }

   @GetMapping(value = "/userstore/viewReview")
   public ModelAndView viewReview(String orderId) {
      ModelAndView mav = new ModelAndView("user/userMain");
      Map<String, Object> review = this.userStoreService.getReviewDetail(orderId);
      mav.addObject("review", review);
      mav.addObject("BODY", "../userstore/reviewDetail.jsp");
      return mav;

   }

	@PostMapping("/userstore/verifyPaymentPasswordAjax")
	@ResponseBody
	public Map<String, Object> verifyPaymentPasswordAjax(@RequestParam("paymentMethod") String paymentMethod,
			@RequestParam("paymentPassword") String paymentPassword, @RequestParam("order_Id") String orderId,
			HttpSession session) {

		Map<String, Object> response = new HashMap<>();

		// 로그인 사용자 정보 가져오기
		LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

		if (loginUser == null) {
			response.put("success", false);
			response.put("message", "로그인 정보가 없습니다");
			return response;
		}

		// 1. 주문 상태 확인 - 이미 처리된 주문인지 체크
		OrderCart orderStatusCart = this.userStoreService.getOrderStatus(orderId);
		if (orderStatusCart != null && orderStatusCart.getOrder_status() != 0) {
			response.put("success", false);
			response.put("message", "이미 처리된 주문입니다");
			return response;
		}

		// 2. 결제 비밀번호 검증
		Integer storedPassword = this.userStoreService.getPayPassword(loginUser.getUser_id());
		boolean isPasswordValid = false;

		try {
			if (Integer.parseInt(paymentPassword) == storedPassword) {
				isPasswordValid = true;
			}
		} catch (NumberFormatException e) {
			response.put("success", false);
			response.put("message", "유효하지 않은 비밀번호 형식입니다");
			return response;
		}

		if (!isPasswordValid) {
			response.put("success", false);
			response.put("message", "비밀번호가 일치하지 않습니다");
			return response;
		}

		// 3. 비밀번호 검증 성공 시 응답만 반환 (실제 결제 처리는 하지 않음)
		response.put("success", true);

		return response;
	}

   @GetMapping(value = "/userstore/mypage/viewCart")
   public ModelAndView mypageviewCart(HttpSession session) {
      ModelAndView mav = new ModelAndView("user/userMain");

      LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");
      if (loginUser == null) {
         return new ModelAndView("redirect:/user/index");
      }

      // 기본 화면 설정
      List<Maincategory> maincategoryList = adminService.getAllMaincategory();
      mav.addObject("maincategoryList", maincategoryList);

      // 주문 정보 가져오기
      OrderCart oc = this.userStoreService.getOrderByUserId(loginUser.getUser_id());

      // oc가 null인 경우 처리
      if (oc == null) {
         mav.addObject("isEmptyCart", "empty");
         mav.addObject("activeMenu", "viewCart");
         mav.addObject("contentPage", "viewCart");
         mav.addObject("BODY", "mypage.jsp");
         return mav;
      }

      // 장바구니 정보 가져오기
      List<Map<String, Object>> cartList = this.userStoreService.getCartMenuDetails(loginUser.getUser_id());

      // cartList가 null이거나 비어있는 경우 처리
      if (cartList == null || cartList.isEmpty()) {
         mav.addObject("isEmptyCart", "empty");
         mav.addObject("activeMenu", "viewCart");
         mav.addObject("contentPage", "viewCart");
         mav.addObject("BODY", "mypage.jsp");
         return mav;
      }

      OrderCart oc1 = new OrderCart();
      oc1.setOrder_id(oc.getOrder_id());
      oc1.setUser_id(loginUser.getUser_id());
      oc1.setOrder_status(0);

      String store_id = this.userStoreService.findStoreByMenuItemInCart(oc1);
      Integer delivery_fee = this.userStoreService.getDeliveryFee(store_id);

      mav.addObject("isEmptyCart", "notEmpty");
      mav.addObject("cartDetails", cartList);
      mav.addObject("deliveryFee", delivery_fee);
      mav.addObject("activeMenu", "viewCart");
      mav.addObject("contentPage", "viewCart");
      mav.addObject("BODY", "mypage.jsp");

		return mav;
	}

	@GetMapping(value = "/userstore/myCouponList")
	public ModelAndView myCouponList(HttpSession session) {
		ModelAndView mav = new ModelAndView("user/userMain");
		LoginUser loginUser = (LoginUser) session.getAttribute("loginUser");

		List<UserCouponDetail> couponList = this.userStoreService.getCouponList(loginUser.getUser_id());

		Date currentDate = new Date();

		mav.addObject("couponList", couponList);
		mav.addObject("currentDate", currentDate);
		mav.addObject("BODY", "../userstore/couponList.jsp");

		return mav;
	}
}