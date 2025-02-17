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
		MultipartFile multiFile = store.getImage(); // 파일을 읽어온다 (업로드한 파일을 서버에서 받기 위해)
		String fileName = null;
		String path = null;
		OutputStream out = null;
		if (multiFile.getOriginalFilename() == "") {
			fileName = "none";
		} else {
			fileName = store.getStore_id() + "_" + multiFile.getOriginalFilename(); // 업로드된 원본 파일명 가져오기
		}

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

	@PostMapping(value = "/store/delete")
	public ModelAndView deleteStore(String store_id, HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		LoginOwner loginOwner = (LoginOwner) session.getAttribute("loginOwner");
		Store store = new Store();
		store.setStore_id(store_id);
		store.setOwner_id(loginOwner.getId());
		this.storeService.deleteStore(store);
		mav.setViewName("/store/storeList");
		return mav;
	}

	@GetMapping(value = "/store/storeMain")
	public ModelAndView storeMain(String store_id) {
		ModelAndView mav = new ModelAndView("owner/storeMain");
		Store store = this.storeService.getStore(store_id);
		mav.addObject("store", store);
		mav.addObject("BODY", "menuRegister.jsp");
		return mav;
	}

	@GetMapping(value = "/store/goStoreModify")
	public ModelAndView goStoreModify(String store_id) {
		ModelAndView mav = new ModelAndView("owner/storeMain");
		Store store = this.storeService.getStore(store_id);
		mav.addObject(store);
		mav.addObject("BODY", "storeModify.jsp");
		return mav;
	}

	@PostMapping(value = "/store/modify")
	public ModelAndView modify(Store store, HttpSession session) {

		ModelAndView mav = new ModelAndView("owner/storeMain");
		MultipartFile multiFile = store.getImage();// 선택한 파일을 불러온다.
		String fileName = null;
		if (!multiFile.getOriginalFilename().equals("")) {// 파일이름이 존재하는 경우,즉 이미지 변경
			String path = null;
			OutputStream os = null;
			fileName = multiFile.getOriginalFilename();// 이미지 파일의 이름을 획득
			ServletContext ctx = session.getServletContext();// ServletContext 생성
			path = ctx.getRealPath("/upload/storeProfile/" + fileName);// upload폴더의 절대경로를 획득
			System.out.println("변경된 이미지 경로:" + path);
			try {
				os = new FileOutputStream(path);// upload 폴더에 파일 생성
				BufferedInputStream bis = new BufferedInputStream(multiFile.getInputStream());// 선택한 파일을 연다.
				byte[] buffer = new byte[8156];// 8K 크기로 배열 생성(한번에 8K씩 복사가 진행)
				int read = 0;// 실제로 읽은 바이트 수
				while ((read = bis.read(buffer)) > 0) {// 원본 파일에서 읽은 바이트 수가 0이상인 동안 반복
					os.write(buffer, 0, read);// 원본파일에서 읽은 데이터를 upload폴더의 파일에 출력
				}
			} catch (Exception e) {
				System.out.println("변경된 이미지 업로드 중 문제발생!");
			} finally {
				try {
					if (os != null)
						os.close();
				} catch (Exception e) {
				}
			} // 업로드 종료
		} else {
			fileName = "none";// 이미지 파일의 이름을 획득
		}
		store.setStore_image_name(fileName);// Imagebbs의 파일이름을 새 파일이름으로 설정
		this.storeService.updateStore(store);// DB에서 이미지 게시글을 수정한다.
		mav.addObject("BODY", "menuRegister.jsp");
		return mav;
	}

}
