package com.springboot.delivery.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springboot.delivery.mapper.UserMapper;
import com.springboot.delivery.model.LoginUser;
import com.springboot.delivery.model.User;

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

}
