package com.springboot.delivery.controller;

import java.io.BufferedInputStream;
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
import com.springboot.delivery.model.Store;
import com.springboot.delivery.service.OwnerService;
import com.springboot.delivery.service.StoreService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class StoreController {

	
	@Autowired
	private StoreService storeService;
	
	@GetMapping(value="/store/goRegister")
	public ModelAndView storeRegister() {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		mav.addObject("BODY", "storeRegister.jsp");
		mav.addObject(new Store());
		return mav;
	}
	
	@GetMapping(value="/store/idcheck")
	public ModelAndView idcheck(String store_id){
		
		ModelAndView mav = new ModelAndView("owner/storeIdcheck");
		Integer count = this.storeService.idcheck(store_id);
		if(count >0) {
			mav.addObject("DUP", "YES");
		} else {
			mav.addObject("DUP", "NO");
		}
		mav.addObject("store_id", store_id);
		return mav;
		
	}
	
	@PostMapping(value="/store/register")
	public ModelAndView register(@Valid Store store, BindingResult br
			, HttpSession session,
			HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		if(br.hasErrors()) {
			mav.getModel().putAll(br.getModel());
			mav.addObject("BODY", "storeRegister.jsp");
			 br.getFieldErrors().forEach(error -> {
		            System.out.println("Field: " + error.getField() + ", Error: " + error.getDefaultMessage());
		        });
			return mav;
		}
		MultipartFile multiFile = store.getImage(); // 파일을 읽어온다 (업로드한 파일을 서버에서 받기 위해)
		String fileName = null;
		String path = null;
		OutputStream out = null;
		fileName = store.getStore_id() + "_"+multiFile.getOriginalFilename(); // 업로드된 원본 파일명 가져오기
		if (!fileName.equals("")) { // 파일이 존재하는 경우, 이미지 파일을 변경
			ServletContext ctx = session.getServletContext();
			// 업로드된 파일을 특정 디렉토리에 저장하기 위해 파일의 경로를 알아야 하기 때문에 사용
			path = ctx.getRealPath("/upload/storeProfile/" + fileName);
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
					if (out != null) // 파일 쓰기에 대한 작업 종료
						out.close();
					if (bis != null) // 파일 읽기에 대한 작업 종료
						bis.close();
				} catch (Exception e) {
				}
			}
			store.setStore_image_name(fileName);
		}
		LoginOwner loginOwner = (LoginOwner)session.getAttribute("loginOwner");
		store.setOwner_id(loginOwner.getId());
		this.storeService.storeRegister(store);
		mav.addObject("BODY", "storeList.jsp");
		return mav;
	}
	
	@GetMapping(value="/store/storeList")
	public ModelAndView storeList(HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/ownerMain");	
		LoginOwner owner = (LoginOwner)session.getAttribute("loginOwner");
		List<Store> storeList = this.storeService.storeList(owner.getId());
		mav.addObject("storeList", storeList);
		mav.addObject("BODY", "storeList.jsp");
		return mav;
	}
}
