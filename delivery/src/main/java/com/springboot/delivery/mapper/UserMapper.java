package com.springboot.delivery.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.BookMarkStore;
import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.User;
import com.springboot.delivery.model.UserCard;
import com.springboot.delivery.model.UserCoupon;

@Mapper
public interface UserMapper {
	void registerUser(User user);

	LoginUser loginUser(LoginUser loginuser);

	User getUserById(String user_id);

	void updateUserInfo(User user);

	Integer idcheck(String user_id);

	List<Store> getAllStore();

	List<Store> getStoresByCategory(Integer main_category_id);

	Integer getMaxBookMarkStore();

	void insertBookMarkStore(BookMarkStore bms);

	List<BookMarkStore> getBookMarkStoreByUserId(String user_id);

	void deleteBookMarkStore(BookMarkStore bms);

	List<String> getBookMarkList(String user_id);

	void userCardRegister(UserCard uc);

	List<UserCard> userCardList(String user_id);

	void deleteCard(Integer pay_id);

	Integer getPayPassword(String user_id);

	void payPasswordRegister(User user);
	
	Integer getOrderStatus(String orderId);
	
	Integer getMaxUserCouponId();
	
	// 쿠폰 다운로드
	void downloadCoupon(UserCoupon userCoupon);
	
	void increaseStoreCouponQuantity(Integer storeCouponId);
	void increaseOwnerCouponQuantity(Integer ownerCouponId);
	
	boolean hasStoreCoupons(String storeId);

}