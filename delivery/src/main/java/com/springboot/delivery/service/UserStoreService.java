package com.springboot.delivery.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.UserStoreMapper;
import com.springboot.delivery.model.CartUser;
import com.springboot.delivery.model.MatchingOptionParam;
import com.springboot.delivery.model.MenuCategory;
import com.springboot.delivery.model.MenuItem;
import com.springboot.delivery.model.OptionSet;
import com.springboot.delivery.model.OrderCart;
import com.springboot.delivery.model.OrderQuantity;
import com.springboot.delivery.model.QuantityUpdateParam;
import com.springboot.delivery.model.Review;
import com.springboot.delivery.model.StoreCoupon;

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
	
	public void deleteItemInCart(OrderCart oc) {
		this.userStoreMapper.deleteItemInCart(oc);
	}
	
	public Integer checkCountInCart(String order_id) {
		return this.userStoreMapper.checkCountInCart(order_id);
	}
	
	public void deleteOrderDetail(String order_id) {
		this.userStoreMapper.deleteOrderDetail(order_id);
	}
	
	public void deleteOrder(String order_id) {
		this.userStoreMapper.deleteOrder(order_id);
	}
	
	public Integer getMaxCountOrderOption() {
		
		return this.userStoreMapper.getMaxCountOrderOption();
	}
	
	public void insertOrderItemQuantity(OrderQuantity oq) {
		this.userStoreMapper.insertOrderItemQuantity(oq);
	}
	
	public String isMenuInCart(String user_id) {
		return this.userStoreMapper.isMenuInCart(user_id);
	}
	
	public Integer getOrderOptionId(String order_id) {
		return this.userStoreMapper.getOrderOptionId(order_id);
	}
	
	public Integer findMatchingOptionId(MatchingOptionParam mop) {

	    
	    return this.userStoreMapper.findMatchingOptionId(mop);
	}

	public void increaseQuantity(QuantityUpdateParam qup) {  
	    this.userStoreMapper.increaseQuantity(qup);
	}
	
	public String findOrderByUserId(OrderCart oc) {
		return this.userStoreMapper.findOrderByUserId(oc);
	}
	
	public String findStoreByMenuItemInCart(OrderCart oc) {
		return this.userStoreMapper.findStoreByMenuItemInCart(oc);
	}
	
	public void deleteOrderQuantityInCart(String order_id) {
		this.userStoreMapper.deleteOrderQuantityInCart(order_id);
	}
	
	public void deleteOrderOptionInCart(String order_id) {
		this.userStoreMapper.deleteOrderOptionInCart(order_id);
	}
	
	public void deleteQuantityInCart(OrderCart oc) {
		this.userStoreMapper.deleteQuantityInCart(oc);
	}
	
	public Integer getDeliveryFee(String store_id) {
		return this.userStoreMapper.getDeliveryFee(store_id);
	}
	
	public CartUser cartUserData(String user_id) {
		return this.userStoreMapper.cartUserData(user_id);
	}
	
	public void insertPay(OrderCart oc) {
		this.userStoreMapper.insertPay(oc);
	}
	
	public void updateOrderStore(OrderCart oc) {
		this.userStoreMapper.updateOrderStore(oc);
	}
	
	public String checkOrder(String user_id) {
		return this.userStoreMapper.checkOrder(user_id);
	}
	
	// 사용자별 주문 목록 조회
	public List<Map<String, Object>> getOrderListByUserId(String user_id) {
	    return this.userStoreMapper.getOrderListByUserId(user_id);
	}

	// 주문 상세 정보 조회
	public Map<String, Object> getOrderInfoByOrderId(String orderId) {
	    return this.userStoreMapper.getOrderInfoByOrderId(orderId);
	}

	// 주문의 메뉴 항목 조회
	public List<Map<String, Object>> getOrderItemsByOrderId(String orderId) {
	    return this.userStoreMapper.getOrderItemsByOrderId(orderId);
	}
	
	public void registerReview(Review review) {
		this.userStoreMapper.registerReview(review);
	}

	public Integer getMaxReviewId() {
		return this.userStoreMapper.getMaxReviewId();
	}
	
	public List<Map<String, Object>> getMyReviewList(String userId) {
	    return userStoreMapper.getMyReviewList(userId);
	}

	public void deleteReview(int reviewId) {
	    userStoreMapper.deleteReview(reviewId);
	}
	public OrderCart getOrderInfoWithAddress(String orderId) {
        return userStoreMapper.getOrderInfoWithAddress(orderId);
    }
	
	public List<Map<String, Object>> getStoreCouponList(StoreCoupon sc) {
	    return this.userStoreMapper.getStoreCouponList(sc);
	}
	public List<Map<String, Object>> getUserCoupons(String userId) {
	    return this.userStoreMapper.getUserCoupons(userId);
	}
	
	public List<MenuItem> getAllMenusByStoreId(String store_id) {
	    return this.userStoreMapper.getAllMenusByStoreId(store_id);
	}
	

}
