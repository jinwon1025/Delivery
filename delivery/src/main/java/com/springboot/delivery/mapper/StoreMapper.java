package com.springboot.delivery.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.Store;

@Mapper
public interface StoreMapper {

	Integer idcheck(String store_id);
	void storeRegister(Store store);
	
	List<Store> storeList(String owner_id);
	void deleteStore(Store store);
	Store getStore(String store_id);
	void updateStore(Store store);
	List<MenuCategory> getAllMenu(String store_id);
	Integer getMaxMenuCount();
	void insertMenu(MenuCategory mc);
	void deleteMenuCategory(MenuCategory mc);
	void menuRegister(MenuItem mi);
	Integer getMenuCount();
	List<MenuItem> getMenuList(String store_id);
	void deleteMenu(MenuItem mi);
	MenuItem menuDetail(MenuItem mi); 
	void menuModify(MenuItem mi);
}
