package com.springboot.delivery.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.Store;

@Mapper
public interface StoreMapper {

	Integer idcheck(String store_id);
	void storeRegister(Store store);
}
