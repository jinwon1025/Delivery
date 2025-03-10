package com.springboot.delivery.model;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StoreCoupon {
    
	
	private Integer store_coupon_id;
	private String store_id;
	private Integer owner_coupon_id;
	private Integer quantity;
	private String expire_date;
	private String owner_id;
	private String cp_name;
	private Integer minimum_purchase;
	private Integer used_quantity;
    
   
    
}
