package com.springboot.delivery.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

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
import com.springboot.delivery.model.UserCoupon;

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
	void deleteItemInCart(OrderCart oc);
	Integer checkCountInCart(String order_id);
	void deleteOrderDetail(String order_id);
	void deleteOrder(String order_id);
	Integer getMaxCountOrderOption();
	void insertOrderItemQuantity(OrderQuantity oq);
	String isMenuInCart(String user_id);
	Integer getOrderOptionId(String order_id);
	Integer findMatchingOptionId(MatchingOptionParam mop);
	void increaseQuantity(QuantityUpdateParam qup);
	String findOrderByUserId(OrderCart oc);
	String findStoreByMenuItemInCart(OrderCart oc);
	void deleteOrderQuantityInCart(String order_id);
	void deleteOrderOptionInCart(String order_id);
	void deleteQuantityInCart(OrderCart oc);
	Integer getDeliveryFee(String store_id);
	CartUser cartUserData(String user_id);
	void insertPay(OrderCart oc);
	void updateOrderStore(OrderCart oc);
	String checkOrder(String user_id);
	// 사용자별 주문 목록 조회
	List<Map<String, Object>> getOrderListByUserId(String user_id);

	// 주문 상세 정보 조회
	Map<String, Object> getOrderInfoByOrderId(String orderId);

	// 주문의 메뉴 항목 조회
	List<Map<String, Object>> getOrderItemsByOrderId(String orderId);
	void registerReview(Review review);	
	Integer getMaxReviewId();
	
	// 사용자의 리뷰 목록 조회
	List<Map<String, Object>> getMyReviewList(String user_id);

	// 리뷰 삭제
	void deleteReview(Integer review_id);

	OrderCart getOrderInfoWithAddress(String orderId);
	
	// 가게별 사용 가능한 쿠폰 목록 조회
	List<Map<String, Object>> getStoreCouponList(StoreCoupon sc);

	List<Map<String, Object>> getUserCoupons(String userId);
	
	List<MenuItem> getAllMenusByStoreId(String store_id);
	
	Integer checkReviewExists(String order_id);
	
	Review getReviewDetail(String orderId);
	
}	