package com.springboot.delivery.model;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Coupon {
    private Integer cp_id;
    private String co_name;
    private Integer sale_price;
    private String created_date;
    private String end_date;     
    private Integer minimum_purchase;
    private String store_id;
}