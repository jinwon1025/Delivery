package com.springboot.delivery.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.OwnerMapper;
import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.Owner;
import com.springboot.delivery.model.Store;

@Service
public class OwnerService {
	
	@Autowired
	private OwnerMapper ownerMapper;
	
	public void registerOwner(Owner owner) {
		this.ownerMapper.registerOwner(owner);
	}
	
	public Integer idCheck(String user_id) {
		return this.ownerMapper.idCheck(user_id);
	}
	
	public LoginOwner login(LoginOwner loginOwner) {
		return this.ownerMapper.login(loginOwner);
	}
	
	public Owner getOwnerInfo(String owner_id) {
		return this.ownerMapper.getOwnerInfo(owner_id);
	}
	
	public void updateInfo(Owner owner) {
		this.ownerMapper.updateInfo(owner);
	}
	
	public List<Store> getOwnerStores(String owner_id) {
	    return this.ownerMapper.getOwnerStores(owner_id);
	}

	public List<Map<String, Object>> getOrderList(String owner_id) {
	    return this.ownerMapper.getOrderList(owner_id);
	}

	public List<Map<String, Object>> getOrderItems(String orderId, String storeId) {
	    return this.ownerMapper.getOrderItems(orderId, storeId);
	}

	public Map<String, Object> getOrderInfo(String orderId) {
	    return this.ownerMapper.getOrderInfo(orderId);
	}

	public void updateOrderStatus(String orderId, int status) {
	    this.ownerMapper.updateOrderStatus(orderId, status);
	}

}
