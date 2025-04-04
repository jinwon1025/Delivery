package com.springboot.delivery.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.UserMapper;
import com.springboot.delivery.model.BookMarkStore;
import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.User;
import com.springboot.delivery.model.UserCard;
import com.springboot.delivery.model.UserCoupon;

@Service
public class UserService {
	@Autowired
    private UserMapper userMapper;

    public void registerUser(User user) {
        this.userMapper.registerUser(user);
    }

    public LoginUser loginUser(LoginUser user) {
        // 로그 추가
        System.out.println("UserService - loginUser 호출");
        System.out.println("입력된 ID: " + user.getUser_id());
        System.out.println("입력된 PW: " + user.getPassword());

        LoginUser result = this.userMapper.loginUser(user);

        // 결과 로그
        if(result != null) {
            System.out.println("로그인 성공 - 조회된 사용자:");
            System.out.println("ID: " + result.getUser_id());
            System.out.println("Role: " + result.getRole());
        } else {
            System.out.println("일치하는 사용자 없음");
        }

        return result;
    }
	
	//마이페이지
	public User getUserById(String user_id) {
        return this.userMapper.getUserById(user_id);
    }
    
    public void updateUserInfo(User user) {
        this.userMapper.updateUserInfo(user);
    }
    
    public Integer idcheck(String user_id) {
    	return this.userMapper.idcheck(user_id);
    }
    
    public List<Store> getAllStore(){
    	return this.userMapper.getAllStore();
    }
    
    public List<Store> getStoresByCategory(Integer main_category_id){
    	return this.userMapper.getStoresByCategory(main_category_id);
    }
    public Integer getMaxBookMarkStore() {
		return this.userMapper.getMaxBookMarkStore();
	}
	
	public void insertBookMarkStore(BookMarkStore bms) {
		this.userMapper.insertBookMarkStore(bms);
	}
	
	public List<BookMarkStore> getBookMarkStoreByUserId(String user_id){
		return this.userMapper.getBookMarkStoreByUserId(user_id);
	}
	
	public void deleteBookMarkStore(BookMarkStore bms) {
		this.userMapper.deleteBookMarkStore(bms);
	}
	
	
	public List<String> getBookMarkList(String user_id){
		return this.userMapper.getBookMarkList(user_id);
	}
	
	public void userCardRegister(UserCard uc) {
		this.userMapper.userCardRegister(uc);
	}
	
	public Integer getOrderStatus(String orderId) {
	    return userMapper.getOrderStatus(orderId);
	}
	
	
	public List<UserCard> userCardLIst(String user_id){
		return this.userMapper.userCardList(user_id);
	}
	public void deleteCard(Integer pay_id) {
		this.userMapper.deleteCard(pay_id);
	}
	
	public Integer getPayPassword(String user_id) {
		return this.userMapper.getPayPassword(user_id);
	}
	
	public void payPasswordRegister(User user) {
		this.userMapper.payPasswordRegister(user);
	}
	
	public Integer getMaxUserCouponId() {
		return this.userMapper.getMaxUserCouponId();
	}
	
	// 쿠폰 다운로드
	public void downloadCoupon(UserCoupon userCoupon) {
	    this.userMapper.downloadCoupon(userCoupon);
	}
	
	public void increaseStoreCouponQuantity(Integer storeCouponId) {
	    this.userMapper.increaseStoreCouponQuantity(storeCouponId);
	}
	
	public void increaseOwnerCouponQuantity(Integer ownerCouponId) {
		this.userMapper.increaseOwnerCouponQuantity(ownerCouponId);
	}
	
	public boolean hasStoreCoupons(String storeId) {
		return this.userMapper.hasStoreCoupons(storeId);	
	}
}
