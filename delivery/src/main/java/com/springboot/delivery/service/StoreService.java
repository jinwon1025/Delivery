package com.springboot.delivery.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.StoreMapper;
import com.springboot.delivery.model.Store;

@Service
public class StoreService {

	
	@Autowired
	private StoreMapper storeMapper;
	
	public Integer idcheck(String store_id) {
		return this.storeMapper.idcheck(store_id);
	}
	
	public void storeRegister(Store store) {
		this.storeMapper.storeRegister(store);
	}
}
