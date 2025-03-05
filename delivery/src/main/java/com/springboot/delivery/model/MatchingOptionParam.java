package com.springboot.delivery.model;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MatchingOptionParam {
	private String orderId;
    private Integer menuItemId;
    private List<OptionOrder> optionList;
    private int optionCount;
}
