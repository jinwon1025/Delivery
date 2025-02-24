package com.springboot.delivery.service;

import java.util.List;
import java.util.Locale.Category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springboot.delivery.mapper.AdminMapper;
import com.springboot.delivery.model.User;
import com.springboot.delivery.model.Coupon;
import com.springboot.delivery.model.Maincategory;

@Service  
public class AdminServiceImpl implements AdminService {
    
    @Autowired
    private AdminMapper adminMapper;

    @Override
    public void createCoupon(Coupon coupon) {
        adminMapper.createCoupon(coupon);
    }
    @Override
    public void createMaincategory(Maincategory maincategory) {
        adminMapper.createMaincategory(maincategory);
    }
    @Override
    public List<User> getAllUsers() {
        return adminMapper.getAllUsers();
    }

    @Override
    public List<Coupon> getAllCoupons() {
        return adminMapper.getAllCoupons();
    }
    
    @Override
    public List<Maincategory> getAllMaincategory() {
        return adminMapper.getAllMaincategory();
    }

    @Override
    public void issueCouponToUser(String userId, Integer couponId) {
        adminMapper.issueCouponToUser(userId, couponId);
    }

    @Override
    public void deleteUser(String userId) {
        adminMapper.deleteUser(userId);
    }
    
    @Override
    public void deleteCoupon(Integer cp_id) {
        adminMapper.deleteCoupon(cp_id);
    }
    @Override
    public void deleteMaincategory(Integer main_category_id) {
        adminMapper.deleteMaincategory(main_category_id);
    }
    
}