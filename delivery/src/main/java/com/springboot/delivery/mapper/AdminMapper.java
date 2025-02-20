package com.springboot.delivery.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.springboot.delivery.model.User;
import com.springboot.delivery.model.Coupon;

@Mapper  // 이 어노테이션이 중요합니다!
public interface AdminMapper {
    List<User> getAllUsers();
    List<Coupon> getAllCoupons();
    void issueCouponToUser(String userId, Integer couponId);
    List<Coupon> getUserCoupons(String userId);
    void deleteUser(String userId);
}