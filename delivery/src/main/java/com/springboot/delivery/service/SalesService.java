package com.springboot.delivery.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.SalesMapper;

@Service
public class SalesService {

	
	@Autowired
	private SalesMapper salesMapper;
	
	public Integer getUserCount() {
		return this.salesMapper.getUserCount();
	}
}
