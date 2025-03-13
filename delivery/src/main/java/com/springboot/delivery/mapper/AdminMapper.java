package com.springboot.delivery.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.Coupon;
import com.springboot.delivery.model.Maincategory;
import com.springboot.delivery.model.Owner;
import com.springboot.delivery.model.User;

@Mapper 
public interface AdminMapper {
    List<User> getAllUsers();
    List<Coupon> getAllCoupons();
	List<Maincategory> getAllMaincategory();
    void issueCouponToUser(String userId, Integer couponId);
    void deleteUser(String userId);
	void createCoupon(Coupon coupon);
	void deleteCoupon(Integer cp_id);
	void createMaincategory(Maincategory maincategory);
	void deleteMaincategory(Integer main_category_id);
	Integer getUserCount();
	Integer getMaxCouponId();
	
	List<Owner> getAllOwner();
	void pointRate(Float point_rate);
	Float getpointRate();
}