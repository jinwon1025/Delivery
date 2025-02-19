package com.springboot.delivery.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.StoreMapper;
import com.springboot.delivery.model.MenuCategory;
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
	
	public List<Store> storeList(String owner_id) {
		return this.storeMapper.storeList(owner_id);
	}
	
	public void deleteStore(Store store) {
		this.storeMapper.deleteStore(store);
	}
	
	
	public Store getStore(String store_id) {
		return this.storeMapper.getStore(store_id);
	}
	
	public void updateStore(Store store) {
		this.storeMapper.updateStore(store);
	}
	
	public 	List<MenuCategory> getAllMenu(String store_id){
		return this.storeMapper.getAllMenu(store_id);
	}
	
	public Integer getMaxMenuCount() {
		return this.storeMapper.getMaxMenuCount();
	}
	
}
