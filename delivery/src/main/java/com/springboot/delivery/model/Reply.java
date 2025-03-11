package com.springboot.delivery.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Reply {

	
	private Integer reply_id;
	private String store_id;
	private String owner_id;
	private String order_id;
	private String reply_content;
	private String write_date;
}
