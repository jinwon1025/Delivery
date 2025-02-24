package com.springboot.delivery.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.springboot.delivery.model.User;
import com.springboot.delivery.model.Coupon;

@Mapper 
public interface AdminMapper {
    List<User> getAllUsers();
    List<Coupon> getAllCoupons();
    void issueCouponToUser(String userId, Integer couponId);
    void deleteUser(String userId);
	void createCoupon(Coupon coupon);
	void deleteCoupon(Integer cp_id);
}