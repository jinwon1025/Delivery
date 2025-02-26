package com.springboot.delivery.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OptionCategory {
	
	private Integer option_group_id;
	private String option_group_name;
	private String store_id;
	private Integer menu_item_id;
	private String selection_type;
}
