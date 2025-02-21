package com.springboot.delivery.service;

import java.util.List;
import com.springboot.delivery.model.User;
import com.springboot.delivery.model.Coupon;

public interface AdminService {
    List<User> getAllUsers();
    List<Coupon> getAllCoupons();
    void issueCouponToUser(String userId, Integer couponId);
    void deleteUser(String userId);
    List<Coupon> getUserCoupons(String userId);
    void createCoupon(Coupon coupon);
}