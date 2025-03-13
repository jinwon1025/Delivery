package com.springboot.delivery.model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserCoupon {
	
	private Integer user_cp_id;
	private String user_id;
	private Integer owner_coupon_id;
	private String download_date;
	private Integer status;
	private Integer store_coupon_id;
	
	private String order_id;
	private Date expire_date;
}
