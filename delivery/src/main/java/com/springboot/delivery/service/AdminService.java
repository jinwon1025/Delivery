package com.springboot.delivery.service;

import java.util.List;
import java.util.Locale.Category;

import com.springboot.delivery.model.User;

import lombok.Getter;
import lombok.Setter;

import com.springboot.delivery.model.Coupon;
import com.springboot.delivery.model.Maincategory;

public interface AdminService {
    List<User> getAllUsers();
    List<Coupon> getAllCoupons();
	List<Maincategory> getAllMaincategory();
    void issueCouponToUser(String userId, Integer couponId);
    void deleteUser(String userId);
    void createCoupon(Coupon coupon);
    void deleteCoupon(Integer cp_id);
    void createMaincategory(Maincategory maincategory);
    void deleteMaincategory(Integer main_category_id);

}

