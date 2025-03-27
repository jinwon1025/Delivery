package com.springboot.delivery.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.Coupon;
import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.OrderCart;
import com.springboot.delivery.model.Owner;
import com.springboot.delivery.model.Reply;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.StoreCoupon;
import com.springboot.delivery.model.User;
import com.springboot.delivery.service.AdminService;
import com.springboot.delivery.service.OwnerService;
import com.springboot.delivery.service.UserStoreService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class OwnerController {

	@Autowired
	private OwnerService ownerSerivce;
	@Autowired
	private UserStoreService userStoreService;
	@Autowired
	private AdminService adminService;

	@GetMapping(value = "/owner/index")
	public ModelAndView ownerIndex(HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/ownerMain");

		// 세션에서 로그인 정보 확인
		LoginOwner loginOwner = (LoginOwner) session.getAttribute("loginOwner");

		if (loginOwner != null) {
			// 로그인되어 있는 경우 메인 페이지 또는 스토어 목록 페이지로 리다이렉트
			return new ModelAndView("redirect:/store/storeList");
		} else {
			// 로그인되어 있지 않은 경우 로그인 페이지 표시
			mav.addObject("BODY", "ownerLogin.jsp");
			mav.addObject(new LoginOwner());
			return mav;
		}
	}

	@PostMapping(value = "/owner/register")
	public ModelAndView ownerRegister(@Valid Owner owner, BindingResult br, HttpSession session,
			HttpServletRequest request) throws Exception {

		ModelAndView mav = new ModelAndView("owner/register");
		if (br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			br.getFieldErrors().forEach(error -> {
				System.out.println("Field: " + error.getField() + ", Error: " + error.getDefaultMessage());
			});
			return mav;
		}

		MultipartFile multiFile = owner.getImage(); // 파일을 읽어온다 (업로드한 파일을 서버에서 받기 위해)
		String fileName = null;
		String path = null;
		OutputStream out = null;
		if (multiFile.getOriginalFilename() == "") {
			fileName = "";
		} else {
			fileName = owner.getOwner_id() + "_" + multiFile.getOriginalFilename(); // 업로드된 원본 파일명 가져오기
		}
		if (!fileName.equals("")) { // 파일이 존재하는 경우, 이미지 파일을 변경
			ServletContext ctx = session.getServletContext();
			path = ctx.getRealPath("/upload/ownerProfile/" + fileName);
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
		owner.setOwner_image_name(fileName);

		System.out.println("아이디: " + owner.getOwner_id());
		System.out.println("이름: " + owner.getOwner_name());
		System.out.println("이메일: " + owner.getOwner_email());
		System.out.println("비밀번호: " + owner.getOwner_password());
		System.out.println("전화번호: " + owner.getOwner_phone());
		System.out.println("이미지 이름: " + owner.getOwner_image_name());
		this.ownerSerivce.registerOwner(owner);

		// 회원가입 성공 후 리다이렉트
		return new ModelAndView("redirect:/owner/index"); // 리다이렉트
	}

	@GetMapping(value = "/owner/goRegister")
	public ModelAndView ownerRegister() {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		mav.addObject("BODY", "register.jsp");
		mav.addObject(new Owner());
		return mav;
	}

	@GetMapping(value = "/owner/idcheck")
	public ModelAndView idcheck(String owner_id) {
		ModelAndView mav = new ModelAndView("owner/idcheck");
		Integer count = this.ownerSerivce.idCheck(owner_id);
		if (count > 0) {
			mav.addObject("DUP", "YES");
		} else {
			mav.addObject("DUP", "NO");
		}
		mav.addObject("owner_id", owner_id);
		return mav;
	}

	@PostMapping(value = "/owner/loginDo")
	public ModelAndView login(@Valid LoginOwner loginOwner, BindingResult br, HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		if (br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			return mav;
		}
		LoginOwner owner = this.ownerSerivce.login(loginOwner);
		if (owner == null) {
			mav.addObject("BODY", "ownerLogin.jsp");
			mav.addObject("BBODY", "loginResult.jsp");
			mav.addObject("FAIL", "YES");
			return mav;
		} else {
			// 로그인 성공 시 바로 /store/storeList로 리다이렉트
			session.setAttribute("loginOwner", owner);
			mav.setViewName("redirect:/store/storeList");
		}
		return mav;
	}

	@GetMapping(value = "/owner/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate(); // 세션 무효화

		// ModelAndView 객체 생성하고 리다이렉트 사용
		ModelAndView mav = new ModelAndView();

		// 리다이렉트 경로 설정
		mav.setViewName("redirect:/owner/index");

		return mav; // 리다이렉트하여 "owner/index" 페이지로 이동
	}

	@GetMapping(value = "/owner/goLogin")
	public ModelAndView goLogin() {
		return new ModelAndView("redirect:/owner/index");
	}

	@GetMapping(value = "/owner/myPage")
	public ModelAndView myPage(HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		LoginOwner loginOwner = (LoginOwner) session.getAttribute("loginOwner");
		Owner owner = this.ownerSerivce.getOwnerInfo(loginOwner.getId());
		String maskedPassword = owner.getOwner_password().replaceAll(".", "*"); // "." : 모든 문자
		owner.setOwner_password(maskedPassword);
		mav.addObject("BODY", "ownerMyPage.jsp");
		mav.addObject("owner", owner);
		return mav;
	}

	@GetMapping(value = "/owner/goEdit")
	public ModelAndView goEdit(HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		LoginOwner loginOwner = (LoginOwner) session.getAttribute("loginOwner");
		Owner owner = this.ownerSerivce.getOwnerInfo(loginOwner.getId());
		mav.addObject("owner", owner);
		mav.addObject("BODY", "ownerEditInfo.jsp");
		return mav;
	}

	@PostMapping(value = "/owner/updateInfo")
	public ModelAndView updateInfo(Owner owner, HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		MultipartFile multiFile = owner.getImage();
		ServletContext ctx = session.getServletContext();

		Owner existingOwner = this.ownerSerivce.getOwnerInfo(owner.getOwner_id());
		String existingImageName = existingOwner.getOwner_image_name();

		if (multiFile != null && !multiFile.isEmpty()) {
			// 새로운 이미지가 업로드된 경우
			String newFileName = owner.getOwner_id() + "_" + multiFile.getOriginalFilename();
			String newPath = ctx.getRealPath("/upload/ownerProfile/" + newFileName);

			// 기존 이미지가 있으면 삭제
			if (existingImageName != null && !existingImageName.isEmpty()) {
				String existingPath = ctx.getRealPath("/upload/ownerProfile/" + existingImageName);
				File existingFile = new File(existingPath);
				if (existingFile.exists()) {
					existingFile.delete();
				}
			}

			// 새 이미지 저장
			try (OutputStream os = new FileOutputStream(newPath);
					BufferedInputStream bis = new BufferedInputStream(multiFile.getInputStream())) {
				byte[] buffer = new byte[8156];
				int read;
				while ((read = bis.read(buffer)) > 0) {
					os.write(buffer, 0, read);
				}
				owner.setOwner_image_name(newFileName);
			} catch (Exception e) {
				System.out.println("새 이미지 업로드 중 문제 발생: " + e.getMessage());
			}
		} else {
			// 새로운 이미지가 업로드되지 않은 경우, 기존 이미지 삭제
			if (existingImageName != null && !existingImageName.isEmpty()) {
				String existingPath = ctx.getRealPath("/upload/ownerProfile/" + existingImageName);
				File existingFile = new File(existingPath);
				if (existingFile.exists()) {
					existingFile.delete();
				}
			}
			owner.setOwner_image_name("");
		}

		this.ownerSerivce.updateInfo(owner);

		// 세션 업데이트
		LoginOwner loginOwner = new LoginOwner();
		loginOwner.setId(owner.getOwner_id());
		loginOwner.setPassword(owner.getOwner_password());
		loginOwner.setImage_name(owner.getOwner_image_name());
		loginOwner.setName(owner.getOwner_name());
		session.setAttribute("loginOwner", loginOwner);

		return new ModelAndView("redirect:../owner/myPage");
	}

	// 주문 목록 조회 메소드
	@GetMapping(value = "/owner/orderList")
	public ModelAndView orderList(HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/storeMain");

		// 세션에서 로그인한 업주 정보 가져오기
		LoginOwner loginOwner = (LoginOwner) session.getAttribute("loginOwner");

		if (loginOwner != null) {
			// 업주가 소유한 가게 정보 가져오기
			List<Store> storeList = ownerSerivce.getOwnerStores(loginOwner.getId());

			// 업주의 모든 가게에 대한 주문 목록 가져오기
			List<Map<String, Object>> orderList = ownerSerivce.getOrderList(loginOwner.getId());

			System.out.println("Store List: " + storeList);
			System.out.println("Order List: " + orderList);

			mav.addObject("storeList", storeList);
			mav.addObject("orderList", orderList);
			mav.addObject("BODY", "ownerOrderList.jsp");
		} else {
			// 로그인하지 않은 경우 로그인 페이지로 리다이렉트
			mav.setViewName("redirect:/owner/index");
		}

		return mav;
	}

	// 주문 상세 정보 조회 메소드 (ModelAndView 방식으로 수정)
	@GetMapping(value="/owner/getOrderDetail")
	public ModelAndView getOrderDetail(@RequestParam String orderId, @RequestParam String storeId) {
	    ModelAndView mav = new ModelAndView("owner/orderDetailFragment");
	    
	    // 주문 상품 목록 가져오기
	    List<Map<String, Object>> orderItems = ownerSerivce.getOrderItems(orderId, storeId);
	    
	    // 주문 기본 정보 가져오기
	    Map<String, Object> orderInfo = ownerSerivce.getOrderInfo(orderId);
	    
	    // orderItems 콘솔 출력
	    System.out.println("===== 주문 상품 목록 (orderItems) =====");
	    for (int i = 0; i < orderItems.size(); i++) {
	        Map<String, Object> item = orderItems.get(i);
	        System.out.println("상품 #" + (i+1) + ": " + item);
	        // 각 항목의 키값들 출력
	        for (String key : item.keySet()) {
	            System.out.println("  " + key + ": " + item.get(key));
	        }
	    }
	    
	    // orderInfo 콘솔 출력
	    System.out.println("===== 주문 기본 정보 (orderInfo) =====");
	    for (String key : orderInfo.keySet()) {
	        System.out.println(key + ": " + orderInfo.get(key));
	    }
	    
	    mav.addObject("orderItems", orderItems);
	    mav.addObject("orderInfo", orderInfo);
	    
	    return mav;
	}
	@GetMapping("/owner/checkDeliveryTime")
	@ResponseBody
	public String checkDeliveryTime(@RequestParam("orderId") String orderId) {
	    Integer deliveryTime = ownerSerivce.getEstimatedDeliveryTime(orderId);
	    return (deliveryTime == null || deliveryTime == 0) ? "notSet" : "set";
	}

	@PostMapping("/owner/saveDeliveryTime")
	@ResponseBody
	public String saveDeliveryTime(@RequestParam("orderId") String orderId,
	                             @RequestParam("deliveryTime") int deliveryTime) {
	    boolean result = ownerSerivce.saveEstimatedDeliveryTime(orderId, deliveryTime);
	    return result ? "success" : "fail";
	}

	@PostMapping(value="/owner/updateOrderStatus")
	@ResponseBody
	public Map<String, Object> updateOrderStatus(@RequestParam String orderId, @RequestParam int status) {
	    Map<String, Object> result = new HashMap<>();
	    
	    try {
	        // 주문 상태 업데이트
	        ownerSerivce.updateOrderStatus(orderId, status);
	        
	        // 배달 시간 조회 (이미 저장된)
	        Integer deliveryTime = this.ownerSerivce.getEstimatedDeliveryTime(orderId);
	        
	        System.out.println("=================updatePoint============");
	        if(status == 5) {
	            String user_id = this.ownerSerivce.getUserId(orderId);
	            Integer totalprice = this.ownerSerivce.getTotalPrice(orderId); //주문 가격
	            double pointRate = this.adminService.getpointRate(); //할인률
	            Integer point = (int)(totalprice * pointRate); //적립된 포인트
	            Integer totalPoint = this.userStoreService.getPoint(user_id); //고객의 현재 포인트
	            Integer usedPoint = this.ownerSerivce.getUsedPoint(orderId); // 고객이 주문할때 사용한 포인트
	            Integer userPoint = totalPoint - point + usedPoint;
	            User user = new User();
	            user.setPoint(userPoint);
	            user.setUser_id(user_id);
	            this.userStoreService.updatePoint(user);
	        }
	        
	        // 성공 응답에 배달 시간도 함께 포함
	        result.put("status", "success");
	        result.put("deliveryTime", deliveryTime);
	        return result;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("status", "error");
	        result.put("message", e.getMessage());
	        return result;
	    }
	}
	
	@GetMapping(value="/owner/reviewList")
	public ModelAndView reviewList(HttpSession session) {
	    ModelAndView mav = new ModelAndView("owner/storeMain");
	    OrderCart oc = new OrderCart();
	    LoginOwner loginOwner = (LoginOwner)session.getAttribute("loginOwner");
	    Store currentStore = (Store) session.getAttribute("currentStore");
	    oc.setStore_id(currentStore.getStore_id());
	    System.out.println("가게 아이디:"+currentStore.getStore_id());

	    List<Map<String, Object>> rarList = this.ownerSerivce.getStoreReviews(currentStore.getStore_id());

	    // 리뷰 리스트 정보 출력
	    System.out.println("총 리뷰 수: " + rarList.size());

	    // 각 리뷰 정보 출력
	    for (int i = 0; i < rarList.size(); i++) {
	        Map<String, Object> review = rarList.get(i);
	        System.out.println("===================== 리뷰 #" + (i+1) + " =====================");
	        System.out.println("리뷰 ID: " + review.get("reviewId"));
	        System.out.println("가게 ID: " + review.get("storeId"));
	        System.out.println("가게 이름: " + review.get("storeName"));
	        System.out.println("사용자 ID: " + review.get("userId"));
	        System.out.println("사용자 이름: " + review.get("userName"));
	        System.out.println("주문 ID: " + review.get("orderId"));
	        System.out.println("리뷰 제목: " + review.get("reviewTitle"));
	        System.out.println("리뷰 내용: " + review.get("reviewContent"));
	        System.out.println("리뷰 이미지: " + review.get("reviewImageName"));
	        System.out.println("별점: " + review.get("rating"));
	        System.out.println("리뷰 작성일: " + review.get("reviewDate"));
	        
	        // 답변 정보 출력 (있는 경우)
	        if (review.get("replyId") != null) {
	            System.out.println("---- 답변 정보 ----");
	            System.out.println("답변 ID: " + review.get("replyId"));
	            System.out.println("사업자 ID: " + review.get("ownerId"));
	            System.out.println("사업자 이름: " + review.get("ownerName"));
	            System.out.println("사업자 이미지: " + review.get("ownerImageName"));
	            System.out.println("답변 내용: " + review.get("replyContent"));
	            System.out.println("답변 작성일: " + review.get("replyDate"));
	        } else {
	            System.out.println("---- 답변 정보: 답변 없음 ----");
	        }
	        System.out.println("====================================================");
	    }

	    mav.addObject("rarList", rarList);
	    mav.addObject("owner_image_name", loginOwner.getImage_name());
	    System.out.println(loginOwner.getImage_name());
	    mav.addObject("BODY", "../owner/reviewList.jsp");

	    return mav;
	}
	
	// 쿠폰 관리 페이지
	// 쿠폰 관리 페이지
	@GetMapping("/owner/couponManagement")
	public ModelAndView couponManagement(HttpSession session) {
	    ModelAndView mav = new ModelAndView("owner/ownerMain");

	    LoginOwner loginOwner = (LoginOwner) session.getAttribute("loginOwner");

	    if (loginOwner != null) {
	        // 해당 사장님이 적용할 수 있는 쿠폰 목록 가져오기
	        List<Coupon> availableCoupons = ownerSerivce.getAvailableCoupons(loginOwner.getId());
	        
	        // 해당 사장님이 가게에 적용한 쿠폰 목록 가져오기
	        List<Map<String, Object>> appliedStoreCoupons = ownerSerivce.getAppliedStoreCoupons(loginOwner.getId());
	        System.out.println("적용된 쿠폰 목록 크기: " + (appliedStoreCoupons != null ? appliedStoreCoupons.size() : "null"));
	        if(appliedStoreCoupons != null && !appliedStoreCoupons.isEmpty()) {
	            System.out.println("첫 번째 쿠폰: " + appliedStoreCoupons.get(0));
	        }

	        // 사장님의 가게 목록 가져오기
	        List<Store> storeList = ownerSerivce.getOwnerStores(loginOwner.getId());

	        mav.addObject("availableCoupons", availableCoupons);
	        mav.addObject("appliedStoreCoupons", appliedStoreCoupons);
	        mav.addObject("storeList", storeList);
	        mav.addObject("BODY", "ownerCouponManager.jsp");
	    } else {
	        mav.setViewName("redirect:/owner/index");
	    }

	    return mav;
	}

	// 쿠폰 적용하기 (기존 쿠폰 업데이트 또는 새 쿠폰 생성)
	@PostMapping("/owner/applyCoupon")
	public ModelAndView applyCoupon(HttpSession session, String couponId, String couponName, String salePrice, String expireDate
			,String storeId, String owner_coupon_id, String quantity,
			String totalQuantity, String minimumPurchase) {
		
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		
		LoginOwner loginOwner = (LoginOwner)session.getAttribute("loginOwner");
		
		StoreCoupon sc = new StoreCoupon();
		Integer maxCount = this.ownerSerivce.getMaxStoreCouponId();
		if(maxCount == null) {
			maxCount = 0;
		}
		sc.setStore_coupon_id(maxCount+1);
		sc.setStore_id(storeId);
		sc.setOwner_coupon_id(Integer.parseInt(owner_coupon_id));
		sc.setQuantity(Integer.parseInt(quantity));
		sc.setExpire_date(expireDate);
		sc.setOwner_id(loginOwner.getId());
		sc.setCp_name(couponName);
		sc.setUsed_quantity(0);
		System.out.println("최소주문금액" +minimumPurchase);
		sc.setMinimum_purchase(Integer.parseInt(minimumPurchase));
		
		//b_store_coupon_tbl에 등록
		this.ownerSerivce.registerCoupon(sc);
		Integer store_used_quantity = this.ownerSerivce.getStoreUsedQuantity(owner_coupon_id);
		
		Coupon c = new Coupon();
		c.setOwner_coupon_id(Integer.parseInt(owner_coupon_id));
		c.setStore_used_quantity(store_used_quantity + Integer.parseInt(quantity));
		System.out.println("등록된 쿠폰개수 :"+ (store_used_quantity + Integer.parseInt(quantity)));
		
		
		//등록한 쿠폰 개수만큼 owner_coupon_tbl에서 깎기
		this.ownerSerivce.updateOwnerCouponQuantity(c);
		mav.setViewName("redirect:/owner/couponManagement");
		return mav;
		
		
	}

	@PostMapping("/owner/removeCoupon")
	public String removeCoupon(@RequestParam Integer couponId, @RequestParam String storeId, HttpSession session) {

		LoginOwner loginOwner = (LoginOwner) session.getAttribute("loginOwner");

		if (loginOwner == null) {
			return "redirect:/owner/index";
		}

		try {
			ownerSerivce.removeCouponFromStore(couponId, storeId, loginOwner.getId());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/owner/couponManagement";
	}
	
	@PostMapping(value="/owner/addReviewReply")
	public ModelAndView addReviewReply(String storeId, String ownerId,
 			String user_id, String orderId, String replyContent) {
		
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		Reply r = new Reply();
		Integer maxCount = this.ownerSerivce.getMaxReplyId();
		if(maxCount== null) {
			maxCount = 0;
		}
		r.setReply_id(maxCount+1);
		r.setStore_id(storeId);
		r.setOwner_id(ownerId);
		r.setOrder_id(orderId);
		r.setReply_content(replyContent);
		r.setWrite_date(new String());
		
		this.ownerSerivce.writeOwnerReply(r);
		mav.setViewName("redirect:/owner/reviewList");
		return mav;
		
		
		
	}
	
	@GetMapping("/owner/getRealtimeOrders")
	@ResponseBody
	public List<Map<String, Object>> getRealtimeOrders(HttpSession session) {
	    // 세션에서 로그인한 업주 정보 가져오기
	    LoginOwner loginOwner = (LoginOwner) session.getAttribute("loginOwner");

	    if (loginOwner != null) {
	        // 업주의 모든 가게에 대한 주문 목록 가져오기
	        List<Map<String, Object>> orderList = ownerSerivce.getOrderList(loginOwner.getId());
	        
	        // 전체 orderList 크기 출력
//	        System.out.println("주문 목록 크기: " + orderList.size());
//	        
//	       // 전체 orderList 출력 (간단한 출력)
//	        System.out.println("주문 목록 전체: " + orderList);
	        
	        // 주문 목록의 각 항목을 자세히 출력
	        for (int i = 0; i < orderList.size(); i++) {
	            Map<String, Object> order = orderList.get(i);
//	            System.out.println("주문 #" + i + ": " + order);
//	            
////	            // 각 주문의 개별 필드를 더 자세히 출력하고 싶다면
//	            System.out.println("  - 주문 ID: " + order.get("ORDER_ID"));
//	            System.out.println("  - 매장명: " + order.get("STORE_NAME"));
//	            System.out.println("  - 주문 상태: " + order.get("ORDER_STATUS"));
//	            System.out.println("  - 주문 시간: " + order.get("ORDER_TIME"));
//	            System.out.println("  - 총 금액: " + order.get("TOTALPRICE"));
	        }
	        
	        return orderList;
	    } else {
	        // 로그인하지 않은 경우 빈 리스트 반환
	        System.out.println("로그인 정보 없음 - 빈 주문 목록 반환");
	        return new ArrayList<>();
	    }
	}
	
	

}