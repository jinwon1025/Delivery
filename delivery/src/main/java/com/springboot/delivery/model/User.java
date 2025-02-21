package com.springboot.delivery.model;

import org.springframework.web.multipart.MultipartFile;

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
	
	//아이디 체크
	private String idchecked;
	
	private String phone1;
	@NotBlank(message="전화번호 중간자리를 입력하세요")
	private String phone2;
	@NotBlank(message="전화번호 마지막자리를 입력하세요")
	private String phone3;
	
	@Size(min = 6, max = 15, message="아이디는 6자 이상15자 이하로 입력해주세요")
	private String user_id;
	
	@NotBlank(message="이름을 입력하세요")
	private String user_name;
	
	@NotEmpty(message="이메일을 입력하세요")
	@Email(message="이메일 형식으로 입력하세요")
	private String email;
	
	@Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,15}$", message = "비밀번호는 8~15자 이내로 영문자와 특수문자를 포함해야 합니다.")
	private String password;
	
	@NotBlank(message="비밀번호를 다시 입력하세요")
	private String passwordcheck;
	
	// user_phone 필드는 lombok에 의해 기본 getter/setter가 생성되지만
	// 아래에서 커스텀 메소드로 재정의합니다
	private String user_phone;
	
	private String image_name;
	private MultipartFile image;
	private Integer point;
	
	@NotEmpty(message="생일을 선택하세요")
	private String birth;
	
	private String user_address;
	

	public String getUser_phone() {
		// DB에서 불러온 경우 (user_phone 값이 있는 경우)
		if (user_phone != null && !user_phone.isEmpty()) {
			return user_phone;
		}
		
		// 회원가입/수정 폼에서 입력한 경우 (phone1, phone2, phone3 조합)
		String p1 = (phone1 != null) ? phone1 : "";
		String p2 = (phone2 != null) ? phone2 : "";
		String p3 = (phone3 != null) ? phone3 : "";
		return p1 + p2 + p3;
	}
	
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
		
		// user_phone 값이 있을 경우 phone1, phone2, phone3로 분리
		if (user_phone != null && !user_phone.isEmpty()) {
			try {
				if (user_phone.startsWith("010") && user_phone.length() >= 11) {
					this.phone1 = "010";
					this.phone2 = user_phone.substring(3, 7);
					this.phone3 = user_phone.substring(7);
				} else {
					// 다른 형식의 전화번호인 경우
					// 필요에 따라 다른 분리 로직 추가
				}
			} catch (Exception e) {
				// 분리 실패 시 오류 처리
				System.out.println("전화번호 분리 오류: " + e.getMessage());
			}
		}
	}
	
	@AssertTrue(message = "비밀번호 불일치")
	public boolean isPasswordsMatch() {
		if (password == null || passwordcheck == null) {
			return false;
		}
		return password.equals(passwordcheck);
	}
}