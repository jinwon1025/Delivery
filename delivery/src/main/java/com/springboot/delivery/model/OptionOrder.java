package com.springboot.delivery.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OptionOrder {
	private Integer option_group_id;
    private Integer option_id;
    private String option_name;
    private Integer option_price;
    private String option_group_name;
}
