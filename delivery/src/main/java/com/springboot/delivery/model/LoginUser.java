package com.springboot.delivery.model;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginUser {
	@NotBlank(message="아이디를 입력하세요")
	private String user_id;
	@NotBlank(message="비밀번호를 입력하세요")
	private String password;
	private String image_name;
	private String user_name;
}
