package com.springboot.delivery.model;

import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginOwner {
	
	@NotEmpty(message="계정을 입력하세요.")
	private String id;
	@NotEmpty(message="계정을 입력하세요.")
	private String password;
	
	
}
