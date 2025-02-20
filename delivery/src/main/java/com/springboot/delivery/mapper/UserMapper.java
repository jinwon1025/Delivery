package com.springboot.delivery.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.User;

@Mapper
public interface UserMapper {
	void registerUser(User user);
	LoginUser loginUser(LoginUser loginuser);
	
	User getUserById(String user_id);
    void updateUserInfo(User user);

}
