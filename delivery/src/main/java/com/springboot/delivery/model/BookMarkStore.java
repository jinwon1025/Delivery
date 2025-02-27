package com.springboot.delivery.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BookMarkStore {

	
	private Integer bm_id;
	private String store_id;
	private String user_id;
	private String store_name;
	private String store_address;
	private Integer last_price;
	private String owner_id;
	private String store_phone;
	private String store_openHour;
	private Integer delivery_fee;
	private String made_in;
	private String store_image_name;
	private String delivery_time;
	
}
