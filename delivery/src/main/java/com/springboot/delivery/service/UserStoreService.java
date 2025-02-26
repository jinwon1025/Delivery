package com.springboot.delivery.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.UserStoreMapper;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionSet;

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
	public MenuItem menuItemDetail(Integer menu_item_id){
		return this.userStoreMapper.menuItemDetail(menu_item_id);
	}
	public List<OptionSet> optionDetail(Integer menu_item_id){
		return this.userStoreMapper.optionDetail(menu_item_id);
	}
	
}
