package com.springboot.delivery.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SubOption {

	private Integer option_id;
	private String option_name;
	private Integer option_price;
	private Integer option_group_id;
	private String store_id;
	private Integer menu_item_id;
	
}
