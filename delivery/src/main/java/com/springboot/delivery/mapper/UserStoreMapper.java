package com.springboot.delivery.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.MenuCategory;

@Mapper
public interface UserStoreMapper {
	List<MenuCategory> storeCategory(String store_id);
}	