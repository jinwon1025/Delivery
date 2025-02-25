package com.springboot.delivery.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.UserStoreMapper;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;

@Service
public class UserStoreService {
	@Autowired
    private UserStoreMapper userStoreMapper;
	
	public List<MenuCategory> storeCategory(String store_id){
		return this.userStoreMapper.storeCategory(store_id);
	}
	public List<MenuItem> menuList(Integer menu_category_id){
		return this.userStoreMapper.menuList(menu_category_id);
	}
}
