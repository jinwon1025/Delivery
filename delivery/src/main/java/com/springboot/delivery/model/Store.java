package com.springboot.delivery.model;

import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Store {
	
	private String idchecked;
	
	@NotEmpty(message="가게 아이디를 입력하세요.")
	private String store_id;
	
	@NotEmpty(message="가게명을 입력하세요.")
	private String store_name;
	
	@NotEmpty(message="가게 주소를 입력하세요.")
	private String store_address;
	
	@NotNull(message="최소주문금액을 입력하세요.")
	private Integer last_price;
	
	private String owner_id;
	
	private Integer main_category_Id;
	
	@NotEmpty(message="가게 전화번호를 입력하세요.")
	private String store_phone;
	
	@NotEmpty(message="가게 영업시간을 입력해하세요")
	private String store_openHour;
	
	@NotNull(message="배달요금을 입력하세요.")
	private Integer delivery_fee;
	
	private String made_in;
	
	private String store_image_name;
	
	private MultipartFile image;
	

}
