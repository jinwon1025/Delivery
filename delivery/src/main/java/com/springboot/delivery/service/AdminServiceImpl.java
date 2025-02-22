package com.springboot.delivery.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springboot.delivery.mapper.AdminMapper;
import com.springboot.delivery.model.User;
import com.springboot.delivery.model.Coupon;

@Service  
public class AdminServiceImpl implements AdminService {
    
    @Autowired
    private AdminMapper adminMapper;

    @Override
    public void createCoupon(Coupon coupon) {
        adminMapper.createCoupon(coupon);
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
    public void issueCouponToUser(String userId, Integer couponId) {
        adminMapper.issueCouponToUser(userId, couponId);
    }

    @Override
    public List<Coupon> getUserCoupons(String userId) {
        return adminMapper.getUserCoupons(userId);
    }

    @Override
    public void deleteUser(String userId) {
        adminMapper.deleteUser(userId);
    }
}