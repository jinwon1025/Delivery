package com.springboot.delivery.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.UserMapper;
import com.springboot.delivery.model.User;

@Service
public class UserService {
	@Autowired
	private UserMapper userMapper;
	
	public void registerUser(User user) {
		this.userMapper.registerUser(user);
	}
}
