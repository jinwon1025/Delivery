package com.springboot.delivery.service;

import java.util.List;
import java.util.Locale.Category;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springboot.delivery.mapper.AdminMapper;
import com.springboot.delivery.model.User;
import com.springboot.delivery.model.Coupon;
import com.springboot.delivery.model.Maincategory;
import com.springboot.delivery.model.Owner;

@Service  
public class AdminService{
    
    @Autowired
    private AdminMapper adminMapper;

    public void createCoupon(Coupon coupon) {
        adminMapper.createCoupon(coupon);
    }
    public void createMaincategory(Maincategory maincategory) {
        adminMapper.createMaincategory(maincategory);
    }
    public List<User> getAllUsers() {
        return adminMapper.getAllUsers();
    }

    public List<Coupon> getAllCoupons() {
        return adminMapper.getAllCoupons();
    }
    
    public List<Maincategory> getAllMaincategory() {
        return adminMapper.getAllMaincategory();
    }


    public void issueCouponToUser(String userId, Integer couponId) {
        adminMapper.issueCouponToUser(userId, couponId);
    }


    public void deleteUser(String userId) {
        adminMapper.deleteUser(userId);
    }
    

    public void deleteCoupon(Integer cp_id) {
        adminMapper.deleteCoupon(cp_id);
    }
    
    public void deleteMaincategory(Integer main_category_id) {
        adminMapper.deleteMaincategory(main_category_id);
    }
    public Integer getUserCount() {
        return adminMapper.getUserCount();
    }
    
    public Integer getMaxCouponId() {
    	return adminMapper.getMaxCouponId();
    }
    
    public List<Owner> getAllOwner(){
    	return adminMapper.getAllOwner();
    }
    
    public void pointRate(Float point_rate) {
    	this.adminMapper.pointRate(point_rate);
    }
    
    public Float getpointRate() {
    	return this.adminMapper.getpointRate();
    }
    
    public Integer getOrderCount() {
    	return this.adminMapper.getOrderCount();
    }
    
    public Integer getUsedCouponCount() {
    	return this.adminMapper.getUsedCouponCount();
    }
    
}