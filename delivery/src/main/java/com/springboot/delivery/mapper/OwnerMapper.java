package com.springboot.delivery.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.Owner;

@Mapper
public interface OwnerMapper {

	void registerOwner(Owner owner);
	Integer idCheck(String user_id);
	
	LoginOwner login(LoginOwner loginOwner);
}
