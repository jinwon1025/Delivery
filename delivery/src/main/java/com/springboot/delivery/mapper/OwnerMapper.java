package com.springboot.delivery.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.delivery.model.Coupon;
import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.OrderCart;
import com.springboot.delivery.model.Owner;
import com.springboot.delivery.model.Review;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.StoreCoupon;

@Mapper
public interface OwnerMapper {

    void registerOwner(Owner owner);
    Integer idCheck(String user_id);
    
    LoginOwner login(LoginOwner loginOwner);
    Owner getOwnerInfo(String owner_id);
    void updateInfo(Owner owner);
    
    List<Store> getOwnerStores(String owner_id);
    List<Map<String, Object>> getOrderList(String owner_id);
    List<Map<String, Object>> getOrderItems(@Param("orderId") String orderId, @Param("storeId") String storeId);
    Map<String, Object> getOrderInfo(String orderId);
    void updateOrderStatus(@Param("orderId") String orderId, @Param("status") int status);
    
    // 사장님이 적용할 수 있는 쿠폰 목록 조회
    List<Coupon> getAvailableCoupons(String ownerId);
    
    // 쿠폰 업데이트
    void updateCoupon(Coupon coupon);
    
    // 쿠폰 생성
    void createCoupon(Coupon coupon);
    
    // 가게 소유권 확인
    int checkStoreOwnership(@Param("storeId") String storeId, @Param("ownerId") String ownerId);
    
 // 사장님이 이미 적용한 쿠폰 목록 조회
    List<Coupon> getAppliedCoupons(String ownerId);
    void deleteCoupon(Integer couponId);
    

    List<Review> getReviewList(OrderCart oc);
    
    Integer getMaxStoreCouponId();
    
    void registerCoupon(StoreCoupon sc);
    void updateOwnerCouponQuantity(Coupon c);
    List<Map<String, Object>> getAppliedStoreCoupons(String ownerId);
    Integer getMaxReviewId();
    
    void insertOwnerReply(Review r);
    
    List<Review> getReviewReplies(Review r);
}


