package com.springboot.delivery.model;

import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class User {
	@NotBlank(message="아이디를 입력하세요")
	private String user_id;
	@NotBlank(message="이름을 입력하세요")
	private String user_name;
	@NotBlank(message="이메일을 입력하세요")
	private String email;
	@NotBlank(message="비밀번호를 입력하세요")
	private String password;
	@NotBlank(message="비밀번호를 다시 입력하세요")
	private String passwordcheck;
	@NotEmpty(message="전화번호를 입력하세요")
	private String user_phone;
	private String image_name;
	private Integer point;
	@NotEmpty(message="생일을 선택하세요")
	private String birth;
	private String city_id;
	private String distinct_id;
	private String street_id;
	private String detail_addr;
	@AssertTrue(message = "비밀번호 불일치")
    public boolean isPasswordsMatch() {
		 if (password == null || passwordcheck == null) {
	            return false;
	        }
	        return password.equals(passwordcheck);
	    }
}