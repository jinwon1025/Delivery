package com.springboot.delivery.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.OwnerMapper;
import com.springboot.delivery.model.Coupon;
import com.springboot.delivery.model.LoginOwner;
import com.springboot.delivery.model.OrderCart;
import com.springboot.delivery.model.Owner;
import com.springboot.delivery.model.Reply;
import com.springboot.delivery.model.Review;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.StoreCoupon;

@Service
public class OwnerService {

	@Autowired
	private OwnerMapper ownerMapper;

	public void registerOwner(Owner owner) {
		this.ownerMapper.registerOwner(owner);
	}

	public Integer idCheck(String user_id) {
		return this.ownerMapper.idCheck(user_id);
	}

	public LoginOwner login(LoginOwner loginOwner) {
		return this.ownerMapper.login(loginOwner);
	}

	public Owner getOwnerInfo(String owner_id) {
		return this.ownerMapper.getOwnerInfo(owner_id);
	}

	public void updateInfo(Owner owner) {
		this.ownerMapper.updateInfo(owner);
	}

	public List<Store> getOwnerStores(String owner_id) {
		return this.ownerMapper.getOwnerStores(owner_id);
	}

	public List<Map<String, Object>> getOrderList(String owner_id) {
		return this.ownerMapper.getOrderList(owner_id);
	}

	public List<Map<String, Object>> getOrderItems(String orderId, String storeId) {
		return this.ownerMapper.getOrderItems(orderId, storeId);
	}

	public Map<String, Object> getOrderInfo(String orderId) {
		return this.ownerMapper.getOrderInfo(orderId);
	}

	public void updateOrderStatus(String orderId, int status) {
		this.ownerMapper.updateOrderStatus(orderId, status);
	}

	// 사장님이 적용할 수 있는 쿠폰 목록 조회
	public List<Coupon> getAvailableCoupons(String ownerId) {
		return this.ownerMapper.getAvailableCoupons(ownerId);
	}

	// 사장님이 쿠폰을 가게에 적용
	public void applyCouponToStore(Coupon coupon) {
		// 해당 가게가 사장님의 소유인지 확인
		if (!isStoreOwnedByOwner(coupon.getStore_id(), coupon.getOwner_id())) {
			throw new RuntimeException("가게의 소유자가 아닙니다.");
		}

		// 쿠폰 ID가 있으면 업데이트, 없으면 생성
		if (coupon.getOwner_coupon_id() != null) {
			this.ownerMapper.updateCoupon(coupon);
		} else {
			this.ownerMapper.createCoupon(coupon);
		}
	}

	// 가게가 해당 사장님의 소유인지 확인하는 헬퍼 메서드
	private boolean isStoreOwnedByOwner(String storeId, String ownerId) {
		return this.ownerMapper.checkStoreOwnership(storeId, ownerId) > 0;
	}

	// 사장님이 이미 적용한 쿠폰 목록 조회
	public List<Map<String, Object>> getAppliedStoreCoupons(String ownerId) {
	    return ownerMapper.getAppliedStoreCoupons(ownerId);
	}

	public void removeCouponFromStore(Integer couponId, String storeId, String ownerId) {
		// 해당 가게가 사장님의 소유인지 확인
		if (!isStoreOwnedByOwner(storeId, ownerId)) {
			throw new RuntimeException("가게의 소유자가 아닙니다.");
		}

		this.ownerMapper.deleteCoupon(couponId);
	}

	// OwnerService.java에 추가
	public Integer checkStoreOwnership(String storeId, String ownerId) {
		try {
			System.out.println("가게 소유권 확인 요청: storeId=" + storeId + ", ownerId=" + ownerId);
			return this.ownerMapper.checkStoreOwnership(storeId, ownerId);
		} catch (Exception e) {
			System.err.println("소유권 확인 중 오류: " + e.getMessage());
			e.printStackTrace();
			return 0;
		}
	}

	public void createCouponDirectly(Coupon coupon) {
	    try {
	        System.out.println("쿠폰 데이터베이스 삽입 시도: " + coupon.getCp_name());
	        this.ownerMapper.createCoupon(coupon);
	        System.out.println("쿠폰 데이터베이스 삽입 성공!");
	    } catch (Exception e) {
	        System.err.println("쿠폰 생성 중 오류: " + e.getMessage());
	        e.printStackTrace();
	        throw e;
	    }
	}

	public void updateCouponDirectly(Coupon coupon) {
		try {
			this.ownerMapper.updateCoupon(coupon);
		} catch (Exception e) {
			System.err.println("쿠폰 업데이트 중 오류: " + e.getMessage());
			throw e;
		}
	}
	
	public List<Review> getReviewList(OrderCart oc){
		return this.ownerMapper.getReviewList(oc);
	}
	
	public Integer getMaxStoreCouponId() {
		return this.ownerMapper.getMaxStoreCouponId();
	}
	
	public void registerCoupon(StoreCoupon sc) {
		this.ownerMapper.registerCoupon(sc);
	}
	
	public void updateOwnerCouponQuantity(Coupon c) {
		this.ownerMapper.updateOwnerCouponQuantity(c);
	}
	
	public Integer getMaxReviewId() {
		return this.ownerMapper.getMaxReviewId();
	}
	
	public void writeOwnerReply(Reply r) {
		this.ownerMapper.writeOwnerReply(r);
	}
	
	public Integer getMaxReplyId() {
		return this.ownerMapper.getMaxReplyId();
	}
	
	public List<Map<String, Object>> getStoreReviews(String storeId){
		return this.ownerMapper.getStoreReviews(storeId);
	}
	
	public String getUserId(String order_id) {
		return this.ownerMapper.getUserId(order_id);
	}
	
	public Integer getTotalPrice(String order_id) {
		return this.ownerMapper.getTotalPrice(order_id);
	}
}
