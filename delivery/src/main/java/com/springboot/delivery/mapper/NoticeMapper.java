package com.springboot.delivery.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.delivery.model.OwnerNotice;
import com.springboot.delivery.model.StartEnd;
import com.springboot.delivery.model.UserNotice;

@Mapper
public interface NoticeMapper {
    // 사용자 공지사항
    List<UserNotice> getAllUserNotices(StartEnd se);
    UserNotice getUserNoticeById(Integer notice_id);
    void createUserNotice(UserNotice notice);
    void updateUserNotice(UserNotice notice);
    void deleteUserNotice(Integer notice_id);
    void increaseUserNoticeViewCount(Integer notice_id);
    
    // 사업자 공지사항
    List<OwnerNotice> getAllOwnerNotices(StartEnd se);
    OwnerNotice getOwnerNoticeById(Integer notice_id);
    void createOwnerNotice(OwnerNotice notice);
    void updateOwnerNotice(OwnerNotice notice);
    void deleteOwnerNotice(Integer notice_id);
    void increaseOwnerNoticeViewCount(Integer notice_id);
    
    Integer getMaxCountFromUserNotice();
    Integer getMaxCountFromOwnerNotice();
    
    Integer getMaxCountFromUserNotice2();
    Integer getMaxCountFromOwnerNotice2();
}