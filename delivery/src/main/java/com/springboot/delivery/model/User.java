package com.springboot.delivery.model;

import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class User {
	private String phone1;
	@NotBlank(message="전화번호를 입력하세요")
	private String phone2;
	@NotBlank(message="전화번호를 입력하세요")
	private String phone3;
	@NotBlank(message="아이디를 입력하세요")
	@Size(min = 6, max = 15, message="아이디는 6자이상15자이하로 입력해주세요")
	private String user_id;
	@NotBlank(message="이름을 입력하세요")
	private String user_name;
	@NotEmpty(message="이메일을 입력하세요")
	@Email(message="이메일 형식으로 입력하세요")
	private String email;
	@NotBlank(message="비밀번호를 입력하세요")
	@Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,15}$", message = "비밀번호는 8~15자 이내로 영문자와 특수문자를 포함해야 합니다.")
	private String password;
	@NotBlank(message="비밀번호를 다시 입력하세요")
	private String passwordcheck;
	private String user_phone;
	public String getUser_phone() {
		return phone1+phone2+phone3;
	}
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