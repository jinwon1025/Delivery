package com.springboot.delivery.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.service.StoreService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class StoreController {

   @Autowired
   private StoreService storeService;

   @GetMapping(value = "/store/goRegister")
   public ModelAndView storeRegister() {
      ModelAndView mav = new ModelAndView("owner/ownerMain");
      mav.addObject("BODY", "storeRegister.jsp");
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
      mav.addObject("storeList", storeList);
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
      return mav;
   }

   @GetMapping(value = "/store/goStoreModify")
   public ModelAndView goStoreModify(HttpSession session) {
      ModelAndView mav = new ModelAndView("owner/storeMain");
      // 세션에서 현재 가게 정보 가져오기
      Store store = (Store) session.getAttribute("currentStore");
      mav.addObject("store", store);
      mav.addObject("BODY", "storeModify.jsp");
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
         if (existingImageName != null && !existingImageName.isEmpty()) {
            String existingPath = ctx.getRealPath("/upload/storeProfile/" + existingImageName);
            File existingFile = new File(existingPath);
            if (existingFile.exists()) {
               existingFile.delete();
            }
         }
         store.setStore_image_name("");
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

         // store 삭제
         this.storeService.deleteStore(store);
      }

      return new ModelAndView("redirect:../store/storeList");
   }

  

   @PostMapping(value = "/store/categoryRegister")
   public ModelAndView menuRegister(@Valid MenuCategory menucategory, BindingResult br, String menu_category_name, HttpSession session) {
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
      // MenuCategory 객체 생성 및 설정
      Integer maxCount = this.storeService.getMaxMenuCount();
      MenuCategory mc = new MenuCategory();
      mc.setMenu_category_id(maxCount + 1);
      mc.setMenu_category_name(menu_category_name);
      mc.setStore_id(currentStore.getStore_id()); // Store ID 설정

      // 메뉴 카테고리 저장
      this.storeService.insertMenu(mc);
   
      // 메뉴 관리자 페이지로 리다이렉트
      return new ModelAndView("redirect:/store/menuManager");
   }
   
   @PostMapping(value="/store/categoryDelete")
   public ModelAndView menuDelete(String menu_category_name, HttpSession session) {
      
      Store currentStore = (Store) session.getAttribute("currentStore");
      MenuCategory mc = new MenuCategory();
      System.out.println("메뉴카테고리삭제ID:"+menu_category_name);
      mc.setMenu_category_name(menu_category_name);
      mc.setStore_id(currentStore.getStore_id());
      this.storeService.deleteMenuCategory(mc);
      
      return new ModelAndView("redirect:/store/menuManager");
   }
   
   @PostMapping(value="/store/menuInsert")
   public ModelAndView menuInsert(Integer menu_category_id, HttpSession session) {
	   ModelAndView mav = new ModelAndView("owner/storeMain");
	   MenuItem menu = new MenuItem();
	   session.setAttribute("menu_category_id", menu_category_id);
	   mav.addObject("menuItem", menu);
	   mav.addObject("BODY", "menuRegister.jsp");
	   return mav;
   }
   @PostMapping(value="/store/menuRegister")
   public ModelAndView menuRegister(@Valid MenuItem menu, BindingResult br, HttpSession session) {
	   ModelAndView mav = new ModelAndView("owner/storeMain");
	   Store currentStore = (Store) session.getAttribute("currentStore");
	   if(br.hasErrors()) {
		   mav.getModel().putAll(br.getModel());
		   mav.addObject("BODY","menuRegister.jsp");
		   br.getFieldErrors().forEach(error -> {
	            System.out.println("Field: " + error.getField() + ", Error: " + error.getDefaultMessage());
	         });
		   return mav;
	   }
	   MultipartFile multiFile = menu.getImage();
	   String fileName = null;
	   String path = null;
	   OutputStream out = null;
	   if(multiFile.getOriginalFilename() == "") {
		   fileName="";
	   } else {
		   fileName=menu.getMenu_name()+"_"+multiFile.getOriginalFilename();
	   }
	   if(!fileName.equals("")) {
		   ServletContext ctx = session.getServletContext();
		   path = ctx.getRealPath("/upload/menuItemProfile/"+fileName);
		   System.out.println("업로드 위치:"+path);
		   BufferedInputStream bis = null;
		   try {
			   out = new FileOutputStream(path);
			   bis = new BufferedInputStream(multiFile.getInputStream());
			   byte[] buffer = new byte[8192];
			   int read = 0;
			   while((read = bis.read(buffer)) > 0) {
				   out.write(buffer, 0, read);
			   }
		   } catch (Exception e) {
			   e.printStackTrace();
		   } finally {
			   try {
				   if(out != null) out.close();
				   if(bis != null) bis.close();
			   } catch(Exception e) {
			   }
		   }
	   }
	   menu.setImage_name(fileName);
	   Integer menu_category_id = (Integer) session.getAttribute("menu_category_id");	
	   Integer count = this.storeService.getMenuCount();
	   menu.setMenu_category_id(menu_category_id);
	   menu.setStore_id(currentStore.getStore_id());
	   menu.setMenu_item_id(count+1);
	   
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
      mav.addObject("menuItemList",menuItemList);
      mav.addObject("BODY", "menuManager.jsp");
      mav.addObject(new MenuCategory());
      return mav;
   }
   
   
   
   
   
}