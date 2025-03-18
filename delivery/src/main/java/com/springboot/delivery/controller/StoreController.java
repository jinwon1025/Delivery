package com.springboot.delivery.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
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

import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.Maincategory;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionCategory;
import com.springboot.delivery.model.OptionSet;
import com.springboot.delivery.model.Rating;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.SubOption;
import com.springboot.delivery.service.AdminService;
import com.springboot.delivery.service.StoreService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class StoreController {

	@Autowired
	private StoreService storeService;

	@Autowired
	private AdminService adminService;

	@GetMapping(value = "/store/goRegister")
	public ModelAndView storeRegister() {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		List<Maincategory> maincategoryList = adminService.getAllMaincategory();

		mav.addObject("BODY", "storeRegister.jsp");
		mav.addObject("maincategoryList", maincategoryList);
		mav.addObject(new Store());
		return mav;
	}

	@GetMapping(value = "/store/idcheck")
	public ModelAndView idcheck(String store_id) {
		ModelAndView mav = new ModelAndView("owner/storeIdcheck");
		Integer count = this.storeService.idcheck(store_id);
		if (count > 0) {
			mav.addObject("DUP", "YES");
		} else {
			mav.addObject("DUP", "NO");
		}
		mav.addObject("store_id", store_id);
		return mav;
	}

	@PostMapping(value = "/store/register")
	public ModelAndView register(@Valid Store store, BindingResult br, HttpSession session, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView("owner/ownerMain");

		if (br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			mav.addObject("BODY", "storeRegister.jsp");
			br.getFieldErrors().forEach(error -> {
				System.out.println("Field: " + error.getField() + ", Error: " + error.getDefaultMessage());
			});
			return mav;
		}

		MultipartFile multiFile = store.getImage();
		String fileName = null;
		String path = null;

		if (multiFile != null && !multiFile.getOriginalFilename().isEmpty()) {
			fileName = store.getStore_id() + "_" + multiFile.getOriginalFilename();
		}

		if (fileName != null) {
			ServletContext ctx = session.getServletContext();
			path = ctx.getRealPath("/upload/storeProfile/" + fileName);
			System.out.println("업로드 위치: " + path);

			try (BufferedInputStream bis = new BufferedInputStream(multiFile.getInputStream());
					FileOutputStream fos = new FileOutputStream(path)) {
				byte[] buffer = new byte[8192];
				int read;
				while ((read = bis.read(buffer)) > 0) {
					fos.write(buffer, 0, read);
				}
			}
			store.setStore_image_name(fileName);
		} else {
			store.setStore_image_name("");
		}

		// delivery_time 기본값 설정 (null이거나 빈 문자열인 경우)
		if (store.getDelivery_time() == null || store.getDelivery_time().trim().isEmpty()) {
			store.setDelivery_time("20~30분");
		}

		LoginOwner loginOwner = (LoginOwner) session.getAttribute("loginOwner");
		store.setOwner_id(loginOwner.getId());
		this.storeService.storeRegister(store);

		return new ModelAndView("redirect:../store/storeList");
	}

	@GetMapping(value = "/store/storeList")
	public ModelAndView storeList(HttpSession session) {
	    ModelAndView mav = new ModelAndView("owner/ownerMain");
	    LoginOwner owner = (LoginOwner) session.getAttribute("loginOwner");
	    List<Store> storeList = this.storeService.storeList(owner.getId());
	    List<Map<String,Object>> storeInfoList = this.storeService.getStoreStatus(owner.getId());
	    
	    // storeInfoList 내용 확인
	    System.out.println("===== storeInfoList 내용 =====");
	    for (Map<String, Object> storeInfo : storeInfoList) {
	        System.out.println(storeInfo);
	    }
	    
	    // 더 자세한 내용을 보려면 각 맵의 키와 값을 개별적으로 출력
	    System.out.println("===== storeInfoList 상세 내용 =====");
	    for (int i = 0; i < storeInfoList.size(); i++) {
	        Map<String, Object> storeInfo = storeInfoList.get(i);
	        System.out.println("가게 #" + (i+1) + " 정보:");
	        for (String key : storeInfo.keySet()) {
	            System.out.println("    " + key + ": " + storeInfo.get(key));
	        }
	    }
	    
	    mav.addObject("storeList", storeList);
	    mav.addObject("storeInfoList", storeInfoList);
	    mav.addObject("BODY", "storeList.jsp");
	    return mav;
	}

	@GetMapping(value = "/store/storeMain")
	public ModelAndView storeMain(String store_id, HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/storeMain");
		Store store = this.storeService.getStore(store_id);

		// 세션에서 현재 가게 정보를 가져옴
		Store currentStore = (Store) session.getAttribute("currentStore");

		// 현재 세션에 저장된 가게가 없거나, 다른 가게의 정보일 경우 새로운 가게 정보로 교체
		if (currentStore == null || !currentStore.getStore_id().equals(store_id)) {
			session.setAttribute("currentStore", store);
		}

		mav.addObject("store", store);
		
		Store menuStore = (Store)session.getAttribute("currentStore");

		// 오늘 주문 가져오기
		Integer todayOrder = this.storeService.getTodayOrderCountByStore(menuStore.getStore_id());
		if(todayOrder == null) {
			todayOrder = 0;
		}
		
		
		// 가게 메뉴 수 가져오기
		Integer menuCount = this.storeService.getCountMenuFromStore(menuStore.getStore_id());
		if(menuCount == null) {
			menuCount = 0;
		}

		// 평균 평점 가져오기
		Double averageRating;
		Rating r = this.storeService.getRatingFromStore(menuStore.getStore_id());
		if (r == null || r.getSum() == null || r.getCount() == null || r.getCount() == 0) {
		    averageRating = 0.0;
		} else {
		    averageRating = r.getSum().doubleValue() / r.getCount();
		}
		
		// 오늘 매출 가져오기
		Integer totalPrice = this.storeService.getTodayOrderTotalByStore(menuStore.getStore_id());
		if(totalPrice == null) {
			totalPrice = 0;
		}
		
		mav.addObject("todayOrder", todayOrder);
		mav.addObject("menuCount", menuCount);
		mav.addObject("averageRating", averageRating);
		mav.addObject("totalPrice", totalPrice);
		return mav;
	}

	@GetMapping(value = "/store/goStoreModify")
	public ModelAndView goStoreModify(HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/storeMain");
		try {
			Store currentStore = (Store) session.getAttribute("currentStore");
			List<Maincategory> maincategoryList = adminService.getAllMaincategory();
			mav.addObject("maincategoryList", maincategoryList);
			mav.addObject("store", currentStore);
			mav.addObject("BODY", "../owner/storeModify.jsp");
			System.out.println("모델 설정 완료: " + currentStore.getStore_id());
		} catch (Exception e) {
			e.printStackTrace();
			// 오류 처리 로직
			mav.addObject("errorMessage", "서버 오류가 발생했습니다: " + e.getMessage());
			mav.addObject("BODY", "../error/error.jsp");
		}
		return mav;
	}

	@PostMapping(value = "/store/modify")
	public ModelAndView modify(Store store, HttpSession session) {
		MultipartFile multiFile = store.getImage();
		ServletContext ctx = session.getServletContext();

		Store existingStore = this.storeService.getStore(store.getStore_id());
		String existingImageName = existingStore.getStore_image_name();

		if (multiFile != null && !multiFile.isEmpty()) {
			String newFileName = store.getStore_id() + "_" + multiFile.getOriginalFilename();
			String newPath = ctx.getRealPath("/upload/storeProfile/" + newFileName);

			if (existingImageName != null && !existingImageName.isEmpty()) {
				String existingPath = ctx.getRealPath("/upload/storeProfile/" + existingImageName);
				File existingFile = new File(existingPath);
				if (existingFile.exists()) {
					existingFile.delete();
				}
			}

			try (OutputStream os = new FileOutputStream(newPath);
					BufferedInputStream bis = new BufferedInputStream(multiFile.getInputStream())) {
				byte[] buffer = new byte[8156];
				int read;
				while ((read = bis.read(buffer)) > 0) {
					os.write(buffer, 0, read);
				}
				store.setStore_image_name(newFileName);
			} catch (Exception e) {
				System.out.println("새 이미지 업로드 중 문제 발생: " + e.getMessage());
			}
		} else {
			// 이미지를 변경하지 않는 경우 기존 이미지 이름 유지
			store.setStore_image_name(existingImageName);
		}

		// delivery_time 기본값 설정 (null이거나 빈 문자열인 경우)
		if (store.getDelivery_time() == null || store.getDelivery_time().trim().isEmpty()) {
			store.setDelivery_time("20~30분");
		}
		this.storeService.updateStore(store);
		// 세션의 현재 가게 정보 업데이트
		session.setAttribute("currentStore", store);
		return new ModelAndView("redirect:../store/storeList");
	}

	@PostMapping(value = "/store/delete")
	public ModelAndView deleteStore(String store_id, HttpSession session) {
		// store_id로 스토어 정보 조회
		Store store = this.storeService.getStore(store_id);

		if (store != null) {
			// 이미지가 있다면 삭제
			if (store.getStore_image_name() != null && !store.getStore_image_name().isEmpty()) {
				ServletContext ctx = session.getServletContext();
				String filePath = ctx.getRealPath("/upload/storeProfile/" + store.getStore_image_name());
				File file = new File(filePath);
				if (file.exists()) {
					file.delete();
				}
			}

			// 1. 옵션 삭제
			this.storeService.deleteOptionsByStoreId(store_id);
			// 2. 옵션 그룹 삭제
			this.storeService.deleteOptionGroupsByStoreId(store_id);
			// 3. 메뉴 아이템 삭제
			this.storeService.deleteMenuItemByStoreId(store_id);
			// 4. 메뉴 카테고리 삭제
			this.storeService.deleteMenuCategoryByStoreId(store_id);
			// 5. 리뷰 삭제
			this.storeService.deleteReviewsByStoreId(store_id);
			// 6. 주문 상세 삭제
			this.storeService.deleteOrderDetailsByStoreId(store_id);
			// 7. 사용한 쿠폰 삭제
			this.storeService.deleteUsedCouponsByStoreId(store_id);
			// 8. 사용자 쿠폰 삭제
			this.storeService.deleteUserCouponsByStoreId(store_id);
			// 9. 사업자 쿠폰 삭제
			this.storeService.deleteOwnerCouponsByStoreId(store_id);
			// 10. 즐겨찾기 삭제
			this.storeService.deleteBookmarksByStoreId(store_id);
			// 11. 가게 정보 삭제
			this.storeService.deleteStoreByStoreId(store);
		}

		return new ModelAndView("redirect:../store/storeList");
	}

	@PostMapping(value = "/store/categoryRegister")
	public ModelAndView menuRegister(@Valid MenuCategory menucategory, BindingResult br, String menu_category_name,
			HttpSession session) {
		// 현재 Store 정보 가져오기
		ModelAndView mav = new ModelAndView("owner/storeMain");
		Store currentStore = (Store) session.getAttribute("currentStore");
		if (br.hasErrors()) {
			List<MenuCategory> menuList = this.storeService.getAllMenu(currentStore.getStore_id());
			mav.addObject("menuList", menuList);
			mav.getModel().putAll(br.getModel());
			mav.addObject("BODY", "menuManager.jsp");
			return mav;
		}
		List<String> getCategory = this.storeService.getCategory(currentStore.getStore_id());
		if (getCategory.contains(menu_category_name)) {
			mav.addObject("errorMessage", "이미 존재하는 카테고리명입니다.");
			List<MenuCategory> menuList = this.storeService.getAllMenu(currentStore.getStore_id());
			List<MenuItem> menuItemList = this.storeService.getMenuList(currentStore.getStore_id());
			mav.addObject("menuList", menuList);
			mav.addObject("menuItemList", menuItemList);
			mav.addObject("BODY", "menuManager.jsp");
			mav.addObject(new MenuCategory());
			return mav;
		}

		// MenuCategory 객체 생성 및 설정
		Integer maxCount = this.storeService.getMaxMenuCount();
		if (maxCount == null) {
			maxCount = 0;
		}
		MenuCategory mc = new MenuCategory();
		System.out.println(maxCount + 1);
		mc.setMenu_category_id(maxCount + 1);
		mc.setMenu_category_name(menu_category_name);
		mc.setStore_id(currentStore.getStore_id()); // Store ID 설정

		// 메뉴 카테고리 저장
		this.storeService.insertMenu(mc);

		// 메뉴 관리자 페이지로 리다이렉트
		return new ModelAndView("redirect:/store/menuManager");
	}

	@PostMapping(value = "/store/menuInsert")
	public ModelAndView menuInsert(Integer menu_category_id, HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/storeMain");
		MenuItem menu = new MenuItem();
		session.setAttribute("menu_category_id", menu_category_id);
		mav.addObject("menuItem", menu);
		mav.addObject("BODY", "menuRegister.jsp");
		return mav;
	}

	@PostMapping(value = "/store/menuRegister")
	public ModelAndView menuRegister(@Valid MenuItem menu, BindingResult br, HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/storeMain");
		Store currentStore = (Store) session.getAttribute("currentStore");
		if (br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			mav.addObject("BODY", "menuRegister.jsp");
			return mav;
		}
		MultipartFile multiFile = menu.getImage();
		String fileName = null;
		String path = null;
		OutputStream out = null;
		if (multiFile.getOriginalFilename() == "") {
			fileName = "";
		} else {
			fileName = menu.getMenu_name() + "_" + multiFile.getOriginalFilename();
		}
		if (!fileName.equals("")) {
			ServletContext ctx = session.getServletContext();
			path = ctx.getRealPath("/upload/menuItemProfile/" + fileName);
			System.out.println("업로드 위치:" + path);
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
		List<String> menuName = this.storeService.getMenuName(currentStore.getStore_id());
		if (menuName.contains(menu.getMenu_name())) {
			mav.addObject("errorMessage", "같은 이름의 메뉴가 있습니다.");
			mav.addObject("BODY", "menuRegister.jsp");
			return mav;
		}
		menu.setImage_name(fileName);
		Integer menu_category_id = (Integer) session.getAttribute("menu_category_id");
		Integer count = this.storeService.getMenuCount();
		if (count == null) {
			count = 0;
		}
		menu.setMenu_category_id(menu_category_id);
		menu.setStore_id(currentStore.getStore_id());
		menu.setMenu_item_id(count + 1);
		System.out.println("카테고리 아이디=" + menu.getMenu_category_id() + "스토어 아이디 =" + menu.getStore_id() + ",메뉴 아이템 아이디="
				+ menu.getMenu_item_id() + "메뉴명" + menu.getMenu_name() + "메뉴가격" + menu.getPrice() + "메뉴설명"
				+ menu.getContent());

		this.storeService.menuRegister(menu);

		return new ModelAndView("redirect:/store/menuManager");
	}

	@GetMapping(value = "/store/menuManager")
	public ModelAndView goMenuManager(HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/storeMain");
		Store currentStore = (Store) session.getAttribute("currentStore");
		List<MenuCategory> menuList = this.storeService.getAllMenu(currentStore.getStore_id());
		List<MenuItem> menuItemList = this.storeService.getMenuList(currentStore.getStore_id());
		mav.addObject("menuList", menuList);
		mav.addObject("menuItemList", menuItemList);
		mav.addObject("BODY", "menuManager.jsp");
		mav.addObject(new MenuCategory());
		return mav;
	}

	@PostMapping(value = "/store/menuDelete")
	public ModelAndView deleteMenu(HttpSession session, Integer menu_item_id) {
		Store currentStore = (Store) session.getAttribute("currentStore");
		MenuItem mi = new MenuItem();
		mi.setStore_id(currentStore.getStore_id());
		mi.setMenu_item_id(menu_item_id);
		this.storeService.deleteMenu(mi);
		return new ModelAndView("redirect:/store/menuManager");
	}

	@PostMapping(value = "/store/menuDetail")
	public ModelAndView menuDetail(HttpSession session, Integer menu_item_id) {
		Store currentStore = (Store) session.getAttribute("currentStore");
		ModelAndView mav = new ModelAndView("owner/storeMain");
		MenuItem mi = new MenuItem();
		mi.setStore_id(currentStore.getStore_id());
		mi.setMenu_item_id(menu_item_id);
		MenuItem m2 = this.storeService.menuDetail(mi);
		mav.addObject("menuItem", m2);
		mav.addObject("BODY", "menuModify.jsp");
		return mav;
	}

	@PostMapping(value = "/store/menuModify")
	public ModelAndView menuModify(HttpSession session, Integer menu_item_id, MenuItem menuItem) {
		Store currentStore = (Store) session.getAttribute("currentStore");
		menuItem.setMenu_item_id(menu_item_id);
		menuItem.setStore_id(currentStore.getStore_id());
		this.storeService.menuModify(menuItem);
		return new ModelAndView("redirect:/store/menuManager");
	}

	@PostMapping(value = "/store/categoryDelete")
	public ModelAndView categoryDelete(Integer menu_category_id) {
		this.storeService.categoryDelete(menu_category_id);
		return new ModelAndView("redirect:/store/menuManager");
	}

	@PostMapping(value = "/store/categoryUpdate")
	public ModelAndView categoryUpdate(Integer menu_category_id, String menu_category_name) {
		MenuCategory mc = new MenuCategory();
		mc.setMenu_category_id(menu_category_id);
		mc.setMenu_category_name(menu_category_name);
		System.out.println("카테고리ID" + menu_category_id + "카테고리이름" + menu_category_name);
		this.storeService.categoryNameUpdate(mc);
		return new ModelAndView("redirect:/store/menuManager");
	}

	@GetMapping(value = "/store/optionManage")
	public ModelAndView optionManage(HttpSession session, Integer menu_item_id) {
		Store currentStore = (Store) session.getAttribute("currentStore");

		ModelAndView mav = new ModelAndView("owner/storeMain");
		MenuItem mi = new MenuItem();
		mi.setStore_id(currentStore.getStore_id());
		mi.setMenu_item_id(menu_item_id);
		MenuItem menuInfo = this.storeService.menuDetail(mi);
		OptionCategory oc = new OptionCategory();
		oc.setStore_id(currentStore.getStore_id());
		oc.setMenu_item_id(menu_item_id);
		List<OptionCategory> optionList = this.storeService.getMenuItemOptionList(oc);

		List<OptionSet> subOptionList = this.storeService.getSubOptionList();
		session.setAttribute("currentMenu", menuInfo);
		mav.addObject("menuInfo", menuInfo);
		mav.addObject("optionList", optionList);
		mav.addObject("subOptionList", subOptionList);
		mav.addObject("BODY", "optionRegister.jsp");
		return mav;
	}

	@PostMapping(value = "/store/addOption")
	public ModelAndView addOption(HttpSession session, String category_name, String selection_type) {
		Store currentStore = (Store) session.getAttribute("currentStore");
		MenuItem currentMenu = (MenuItem) session.getAttribute("currentMenu"); // 세션에서 메뉴 정보 가져오기

		ModelAndView mav = new ModelAndView("owner/storeMain");
		OptionCategory oc = new OptionCategory();
		Integer maxCount = this.storeService.getOptionGroupMax();
		System.out.println("최대 카운트" + maxCount);
		if (maxCount == null) { // 값이 없으면 0을 설정
			maxCount = 0;
		}

		Integer subOptionMaxCount = this.storeService.getSubOptionMax();
		if (subOptionMaxCount == null) {
			subOptionMaxCount = 0;
		}

		oc.setOption_group_id(maxCount + 1);
		oc.setOption_group_name(category_name);
		oc.setMenu_item_id(currentMenu.getMenu_item_id());
		System.out.println("카테고리 이름" + category_name);
		oc.setStore_id(currentStore.getStore_id());
		oc.setSelection_type(selection_type);
		this.storeService.addOption(oc);

		// 옵션 없음을 디폴트로 넣기
		SubOption so = new SubOption();
		so.setMenu_item_id(currentMenu.getMenu_item_id());
		so.setOption_group_id(maxCount + 1);
		so.setOption_price(0);
		so.setOption_id(subOptionMaxCount + 1);
		so.setOption_name("옵션없음");
		so.setStore_id(currentStore.getStore_id());
		this.storeService.addSubOption(so);

		return new ModelAndView("redirect:/store/optionManage?menu_item_id=" + currentMenu.getMenu_item_id());
	}

	@PostMapping(value = "/store/addSubOption")
	public ModelAndView addSubOption(Integer option_group_id, String option_name, Integer option_price,
			HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/storeMain");
		Store currentStore = (Store) session.getAttribute("currentStore");
		MenuItem currentMenu = (MenuItem) session.getAttribute("currentMenu");
		Integer maxCount = this.storeService.getSubOptionMax();
		if (maxCount == null) {
			maxCount = 0;
		}
		SubOption so = new SubOption();
		so.setOption_id(maxCount + 1);
		so.setOption_name(option_name);
		so.setOption_price(option_price);
		so.setOption_group_id(option_group_id);
		so.setStore_id(currentStore.getStore_id());
		so.setMenu_item_id(currentMenu.getMenu_item_id());

		this.storeService.addSubOption(so);

		return new ModelAndView("redirect:/store/optionManage?menu_item_id=" + currentMenu.getMenu_item_id());
	}

	@PostMapping(value = "/store/deleteSubOption")
	public ModelAndView deleteSubOption(Integer option_group_id, Integer option_id, HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/storeMain");
		Store currentStore = (Store) session.getAttribute("currentStore");
		MenuItem currentMenu = (MenuItem) session.getAttribute("currentMenu");
		OptionSet os = new OptionSet();
		os.setStore_id(currentStore.getStore_id());
		os.setMenu_item_id(currentMenu.getMenu_item_id());
		os.setOption_group_id(option_group_id);
		os.setOption_id(option_id);
		this.storeService.deleteSubOption(os);

		return new ModelAndView("redirect:/store/optionManage?menu_item_id=" + currentMenu.getMenu_item_id());

	}

	@GetMapping(value = "/store/goUpdateSubOption")
	public ModelAndView goUpdateSubOption(Integer option_group_id, Integer option_id, HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/storeMain");
		Store currentStore = (Store) session.getAttribute("currentStore");
		MenuItem currentMenu = (MenuItem) session.getAttribute("currentMenu");

		MenuItem mi = new MenuItem();
		mi.setStore_id(currentStore.getStore_id());
		mi.setMenu_item_id(currentMenu.getMenu_item_id());
		MenuItem menuInfo = this.storeService.menuDetail(mi); // 무슨 음식의 옵션 수정창인지 나타내기 위해 정보 가져오기

		OptionCategory oc = new OptionCategory();
		oc.setStore_id(currentStore.getStore_id());
		oc.setMenu_item_id(currentMenu.getMenu_item_id());
		List<OptionCategory> optionList = this.storeService.getMenuItemOptionList(oc); // 가맹점의 특정 음식이 가지고 있는 옵션 리스트 가져오기

		List<OptionSet> subOptionList = this.storeService.getSubOptionList(); // 특정 음식의 옵션의 하위 옵션 리스트 가져오기
		OptionSet os = new OptionSet();
		os.setStore_id(currentStore.getStore_id());
		os.setMenu_item_id(currentMenu.getMenu_item_id());
		os.setOption_group_id(option_group_id);
		os.setOption_id(option_id);

		OptionSet targetOs = this.storeService.getUpdateSubOptionTarget(os); // 사업자가 수정 버튼을 누른 옵션을 가져오기

		mav.addObject("menuInfo", menuInfo);
		mav.addObject("optionList", optionList);
		mav.addObject("subOptionList", subOptionList);
		mav.addObject("target", targetOs);
		mav.addObject("BODY", "subOptionUpdate.jsp");
		return mav;
	}

	@PostMapping(value = "/store/updateSubOption")
	public ModelAndView updateSubOption(String option_name, Integer option_price, Integer option_group_id,
			Integer option_id, HttpSession session) {
		Store currentStore = (Store) session.getAttribute("currentStore");
		MenuItem currentMenu = (MenuItem) session.getAttribute("currentMenu");
		OptionSet os = new OptionSet();
		os.setOption_name(option_name);
		os.setOption_price(option_price);
		os.setStore_id(currentStore.getStore_id());
		os.setMenu_item_id(currentMenu.getMenu_item_id());
		os.setOption_group_id(option_group_id);
		os.setOption_id(option_id);

		this.storeService.updateSubOption(os);

		return new ModelAndView("redirect:/store/optionManage?menu_item_id=" + currentMenu.getMenu_item_id());

	}

	@GetMapping(value = "/store/goUpdateOptionCategory")
	public ModelAndView goUpdateOptinoCategory(HttpSession session, Integer option_group_id) {

		Store currentStore = (Store) session.getAttribute("currentStore");
		MenuItem currentMenu = (MenuItem) session.getAttribute("currentMenu");

		ModelAndView mav = new ModelAndView("owner/storeMain");
		MenuItem mi = new MenuItem();
		mi.setStore_id(currentStore.getStore_id());
		mi.setMenu_item_id(currentMenu.getMenu_item_id());
		MenuItem menuInfo = this.storeService.menuDetail(mi);
		OptionCategory oc = new OptionCategory();
		oc.setStore_id(currentStore.getStore_id());
		oc.setMenu_item_id(currentMenu.getMenu_item_id());
		List<OptionCategory> optionList = this.storeService.getMenuItemOptionList(oc);

		List<OptionSet> subOptionList = this.storeService.getSubOptionList();
		session.setAttribute("currentMenu", menuInfo);
		mav.addObject("menuInfo", menuInfo);
		mav.addObject("optionList", optionList);
		mav.addObject("subOptionList", subOptionList);
		mav.addObject("target", option_group_id);
		mav.addObject("BODY", "updateOptionCategory.jsp");
		return mav;
	}

	@PostMapping(value = "/store/updateOptionCategory")
	public ModelAndView updateOptionCategory(Integer option_group_id, String option_group_name, String selection_type,
			HttpSession session) {
		Store currentStore = (Store) session.getAttribute("currentStore");
		MenuItem currentMenu = (MenuItem) session.getAttribute("currentMenu");
		OptionCategory oc = new OptionCategory();
		oc.setStore_id(currentStore.getStore_id());
		oc.setMenu_item_id(currentMenu.getMenu_item_id());
		oc.setOption_group_id(option_group_id);
		oc.setOption_group_name(option_group_name);
		oc.setSelection_type(selection_type);

		this.storeService.updateOptionCategory(oc);

		return new ModelAndView("redirect:/store/optionManage?menu_item_id=" + currentMenu.getMenu_item_id());
	}

	@PostMapping(value = "/store/deleteOptionCategory")
	public ModelAndView deleteOptionCategory(Integer option_group_id, HttpSession session) {
		Store currentStore = (Store) session.getAttribute("currentStore");
		MenuItem currentMenu = (MenuItem) session.getAttribute("currentMenu");
		OptionCategory oc = new OptionCategory();
		oc.setStore_id(currentStore.getStore_id());
		oc.setMenu_item_id(currentMenu.getMenu_item_id());
		oc.setOption_group_id(option_group_id);

		this.storeService.deleteSubOptionByGroupId(oc);
		this.storeService.deleteOptionCategory(oc);

		return new ModelAndView("redirect:/store/optionManage?menu_item_id=" + currentMenu.getMenu_item_id());

	}

	@PostMapping("/store/updateStatus")
	@ResponseBody
	public Map<String, Object> updateStoreStatus(@RequestParam String storeId, @RequestParam Integer status,
			HttpSession session) {
		Map<String, Object> response = new HashMap<>();

		try {
			// 현재 로그인한 업주 확인
			LoginOwner loginOwner = (LoginOwner) session.getAttribute("loginOwner");

			if (loginOwner != null) {
				// 해당 가게가 현재 로그인한 업주의 가게인지 확인
				Store store = storeService.getStore(storeId);

				if (store != null && store.getOwner_id().equals(loginOwner.getId())) {
					// 상태 업데이트
					storeService.updateStoreStatus(storeId, status);

					// 세션에 저장된 현재 가게 정보 업데이트
					Store currentStore = (Store) session.getAttribute("currentStore");
					if (currentStore != null && currentStore.getStore_id().equals(storeId)) {
						currentStore.setStore_status(status);
						session.setAttribute("currentStore", currentStore);
					}

					response.put("success", true);
					response.put("message", "가게 상태가 성공적으로 업데이트되었습니다.");
				} else {
					response.put("success", false);
					response.put("message", "해당 가게에 대한 권한이 없습니다.");
				}
			} else {
				response.put("success", false);
				response.put("message", "로그인 정보가 없습니다.");
			}
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "오류가 발생했습니다: " + e.getMessage());
		}

		return response;
	}

}