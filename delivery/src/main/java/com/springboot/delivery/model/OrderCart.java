package com.springboot.delivery.model;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderCart {
    private String order_id;
    private String user_id;
    private String order_time;
    private Integer user_cp_id;
    private Integer order_detail_id;
    private String store_id;
    private Integer pay_id;
    private String store_address;
    private String toowner;
    private String torider;
    private Integer order_status;
    private Integer order_option_id;
    private Integer menu_item_id;
    private Integer option_id;        // 이 필드 추가
    private Integer option_group_id;  // 이 필드 추가
    private List<OptionOrder> options;
}