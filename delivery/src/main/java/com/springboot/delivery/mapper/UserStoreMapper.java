package com.springboot.delivery.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;

@Mapper
public interface UserStoreMapper {
	List<MenuCategory> storeCategory(String store_id);
	List<MenuItem> menuList(Integer menu_category_id);
}	