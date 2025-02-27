package com.springboot.delivery.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.BookMarkStore;
import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.Store;
import com.springboot.delivery.model.User;

@Mapper
public interface UserMapper {
		void registerUser(User user);
		LoginUser loginUser(LoginUser loginuser);
		User getUserById(String user_id);
    void updateUserInfo(User user);
    Integer idcheck(String user_id);
    List<Store> getAllStore();
    List<Store> getStoresByCategory(Integer main_category_id);
    
    Integer getMaxBookMarkStore();
	void insertBookMarkStore(BookMarkStore bms);
	
	List<BookMarkStore> getBookMarkStoreByUserId(String user_id);
}	