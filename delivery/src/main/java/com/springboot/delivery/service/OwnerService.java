package com.springboot.delivery.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.OwnerMapper;
import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.Owner;

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
	
	public Owner getOwner(LoginOwner loginOwner) {
		return this.ownerMapper.getOwner(loginOwner);
	}

}
