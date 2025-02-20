package com.springboot.delivery.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MenuItem {
	private Integer menu_item_id;
	@NotBlank(message="이름을 입력해주세요")
	private String menu_name;
	private Integer menu_category_id;
	private String store_id;
	@NotNull(message="가격을 입력해주세요")
	private Integer price;
	private String image_name;
	@NotBlank(message="메뉴 설명을 입력해주세요")
	private String content;
}
