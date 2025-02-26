package com.springboot.delivery.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionSet;

@Mapper
public interface UserStoreMapper {
	List<MenuCategory> storeCategory(String store_id);
	List<MenuItem> menuList(Integer menu_category_id);
	MenuItem menuItemDetail(Integer menu_item_id);
	List<OptionSet> optionDetail(Integer menu_item_id);
	
}	