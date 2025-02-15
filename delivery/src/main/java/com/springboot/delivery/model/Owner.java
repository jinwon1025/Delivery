package com.springboot.delivery.model;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Owner {
	
	//아이디 체크
	private String idchecked;
	private String passwordchecked;
	
	@NotBlank(message="아이디를 입력하세요.")
	private String owner_id;
	
	@NotEmpty(message="이름을 입력하세요.")
	private String owner_name;
	
	@NotEmpty(message="이메일을 입력하세요.")
	private String owner_email;
	
	@NotEmpty(message="암호를 입력하세요.")
	private String owner_password;
	
	@NotEmpty(message="전화번호를 입력하세요.")
	private String owner_phone;
	private String owner_image_name;
	
	private MultipartFile image;

}
