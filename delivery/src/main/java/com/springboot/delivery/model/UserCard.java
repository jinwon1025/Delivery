package com.springboot.delivery.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserCard {
	private Integer pay_id;
	private String user_id;
	private String card_number;
	@NotBlank(message = "카드 소유자명을 입력해주세요.")
    @Size(max = 50, message = "소유자명은 최대 50자까지 가능합니다.")
	private String card_holder;
	@NotBlank(message = "유효기간을 입력해주세요.")
    @Pattern(regexp = "(0[1-9]|1[0-2])/(\\d{2})", message = "유효기간은 MM/YY 형식이어야 합니다.")
	private String expiry_date;
	@NotBlank(message = "카드 종류를 선택해주세요.")
	private String card_type;
	
	private String card_number_1;
	private String card_number_2;
	private String card_number_3;
	private String card_number_4;
}
