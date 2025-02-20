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
    private Date created_date;
    private Date end_date;
    private Integer minimum_purchase;
    private String store_id;
}