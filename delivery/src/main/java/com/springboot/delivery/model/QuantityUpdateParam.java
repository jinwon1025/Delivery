package com.springboot.delivery.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuantityUpdateParam {
	private Integer orderOptionId;
    private String orderId;
    private Integer additionalQuantity;
}
