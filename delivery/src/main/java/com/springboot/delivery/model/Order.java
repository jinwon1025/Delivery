package com.springboot.delivery.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Order {

	private String order_id;
	private Integer discount_amount;
	private Integer point_discount;
	private Integer coupon_discount;
	
}
