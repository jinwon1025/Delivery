package com.springboot.delivery.model;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MenuCategory {

	private Integer menu_category_id;
	@NotBlank(message="제목을입력하세요")
	private String menu_category_name;
	private String store_id;
}
