package com.springboot.delivery.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.Store;

@Mapper
public interface StoreMapper {

	Integer idcheck(String store_id);
	void storeRegister(Store store);
	
	List<Store> storeList(String owner_id);
	void deleteStore(Store store);

}
