package com.springboot.delivery.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OptionSet {

	private Integer option_id;
	private String option_name;
	private Integer option_price;
	private String store_id;
	private Integer menu_item_id;  //b_option_tbl;
	private Integer option_group_id; // 조인
	private String option_groupt_name; //b_option_group_tbl;
	
	
	
}
