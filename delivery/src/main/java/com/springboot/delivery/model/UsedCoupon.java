package com.springboot.delivery.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UsedCoupon {

	private Integer used_cp_id;
	private String order_id;
	private String user_id;
	private String used_date;
	private Integer store_coupon_id;
	private Integer owner_coupon_id;
	private Integer user_cp_id;
	
}
