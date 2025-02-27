package com.springboot.delivery.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.UserStoreMapper;
import com.springboot.delivery.model.BookMarkStore;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionSet;
import com.springboot.delivery.model.OrderCart;

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
	public void insertOrder(OrderCart orderCart) {
		this.userStoreMapper.insertOrder(orderCart);
	}
	public void insertOrderDetail(OrderCart orderCart) {
		this.userStoreMapper.insertOrderDetail(orderCart);
	}
	public void insertOrderOption(OrderCart orderCart) {
		this.userStoreMapper.insertOrderOption(orderCart);
	}
	public String storeAddress(String store_id) {
		return this.userStoreMapper.storeAddress(store_id);
	}
	
	public OrderCart getOrderByUserId(String user_id) {
		return this.userStoreMapper.getOrderByUserId(user_id);
	}
	
	public OrderCart getOrderStatusByOrderId(String order_id) {
		return this.userStoreMapper.getOrderByUserId(order_id);
	}
	
	public List<Map<String, Object>> getCartMenuDetails(String user_id){
		return this.userStoreMapper.getCartMenuDetails(user_id);
	}
	
}
