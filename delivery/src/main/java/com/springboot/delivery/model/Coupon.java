package com.springboot.delivery.model;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Coupon {
    private Integer owner_coupon_id;    
    private String cp_name;             
    private Integer sale_price;
    private Integer minimum_purchase;
    private String owner_id;           
    private String store_id;
    private String issued_date;        
    private String expire_date;         
    private Integer total_quantity;
    private Integer remaining_quantity; // 추가된 필드      
    private String store_name; // 추가된 필드
    private Integer store_used_quantity;
    private Integer user_used_quantity;
    
    
   
    
}
