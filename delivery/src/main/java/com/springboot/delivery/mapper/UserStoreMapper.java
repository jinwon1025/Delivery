package com.springboot.delivery.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionSet;
import com.springboot.delivery.model.OrderCart;

@Mapper
public interface UserStoreMapper {
	List<MenuCategory> storeCategory(String store_id);
	List<MenuItem> menuList(Integer menu_category_id);
	MenuItem menuItemDetail(Integer menu_item_id);
	List<OptionSet> optionDetail(Integer menu_item_id);
	void insertOrder(OrderCart orderCart);
	void insertOrderDetail(OrderCart orderCart);
	void insertOrderOption(OrderCart orderCart);
	String storeAddress(String store_id);
	OrderCart getOrderByUserId(String user_id);
	OrderCart getOrderStatusByOrderId(String order_id);
	List<Map<String, Object>> getCartMenuDetails(String user_id);

}	