package com.springboot.delivery.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.OrderCart;
import com.springboot.delivery.model.Owner;
import com.springboot.delivery.model.Review;
import com.springboot.delivery.model.Store;

@Mapper
public interface OwnerMapper {

	void registerOwner(Owner owner);
	Integer idCheck(String user_id);
	
	LoginOwner login(LoginOwner loginOwner);
	Owner getOwnerInfo(String owner_id);
	void updateInfo(Owner owner);
	
	List<Store> getOwnerStores(String owner_id);
    List<Map<String, Object>> getOrderList(String owner_id);
    List<Map<String, Object>> getOrderItems(String orderId, String storeId);
    Map<String, Object> getOrderInfo(String orderId);
    void updateOrderStatus(String orderId, int status);
    List<Review> getReviewList(OrderCart oc);
}
