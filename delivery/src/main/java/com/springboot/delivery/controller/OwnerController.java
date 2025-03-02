package com.springboot.delivery.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.Owner;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.service.OwnerService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class OwnerController {

	@Autowired
	private OwnerService ownerSerivce;

	@GetMapping(value = "/owner/index")
	public ModelAndView ownerIndex() {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		mav.addObject("BODY", "ownerLogin.jsp");
		mav.addObject(new LoginOwner());
		return mav;
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
	    if(multiFile.getOriginalFilename() == "") {
	    	fileName="";
	    } else {
	    fileName = owner.getOwner_id() + "_"+multiFile.getOriginalFilename(); // 업로드된 원본 파일명 가져오기
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
	                if (out != null) out.close();
	                if (bis != null) bis.close();
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
	        mav.addObject("BODY","ownerLogin.jsp");
	        mav.addObject("BBODY","loginResult.jsp");
	        mav.addObject("FAIL","YES");
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
	    session.invalidate();  // 세션 무효화
	    
	    // ModelAndView 객체 생성하고 리다이렉트 사용
	    ModelAndView mav = new ModelAndView();
	    
	    // 리다이렉트 경로 설정
	    mav.setViewName("redirect:/owner/index");
	    
	    return mav;  // 리다이렉트하여 "owner/index" 페이지로 이동
	}
	
	@GetMapping(value="/owner/goLogin")
	public ModelAndView goLogin() {
		
		return new ModelAndView("redirect:/owner/index");
	}
	
	@GetMapping(value="/owner/myPage")
	public ModelAndView myPage(HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		LoginOwner loginOwner = (LoginOwner)session.getAttribute("loginOwner");
		Owner owner = this.ownerSerivce.getOwnerInfo(loginOwner.getId());
		String maskedPassword= owner.getOwner_password().replaceAll(".", "*"); // "." : 모든 문자
		owner.setOwner_password(maskedPassword);
		mav.addObject("BODY", "ownerMyPage.jsp");
		mav.addObject("owner", owner);
		return mav;
	}
	
	@GetMapping(value="/owner/goEdit")
	public ModelAndView goEdit(HttpSession session) {
		ModelAndView mav = new ModelAndView("owner/ownerMain");
		LoginOwner loginOwner = (LoginOwner)session.getAttribute("loginOwner");
		Owner owner = this.ownerSerivce.getOwnerInfo(loginOwner.getId());
		mav.addObject("owner", owner);
		mav.addObject("BODY", "ownerEditInfo.jsp");
		return mav;
	}
	
	@PostMapping(value="/owner/updateInfo")
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

			
}
