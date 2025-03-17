package com.springboot.delivery.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springboot.delivery.mapper.NoticeMapper;
import com.springboot.delivery.model.UserNotice;
import com.springboot.delivery.model.OwnerNotice;
import com.springboot.delivery.model.StartEnd;

@Service
public class NoticeService {
    
    @Autowired
    private NoticeMapper noticeMapper;
    
    // 사용자 공지사항
    public List<UserNotice> getAllUserNotices(StartEnd se) {
        return noticeMapper.getAllUserNotices(se);
    }
    
    public UserNotice getUserNoticeById(Integer notice_id) {
        return noticeMapper.getUserNoticeById(notice_id);
    }
    

    public void createUserNotice(UserNotice notice) {
        noticeMapper.createUserNotice(notice);
    }
        public void updateUserNotice(UserNotice notice) {
        noticeMapper.updateUserNotice(notice);
    }
    
 
    public void deleteUserNotice(Integer notice_id) {
        noticeMapper.deleteUserNotice(notice_id);
    }
    

    public void increaseUserNoticeViewCount(Integer notice_id) {
        noticeMapper.increaseUserNoticeViewCount(notice_id);
    }
    
    // 사업자 공지사항

    public List<OwnerNotice> getAllOwnerNotices() {
        return noticeMapper.getAllOwnerNotices();
    }
    

    public OwnerNotice getOwnerNoticeById(Integer notice_id) {
        return noticeMapper.getOwnerNoticeById(notice_id);
    }

    public void createOwnerNotice(OwnerNotice notice) {
        noticeMapper.createOwnerNotice(notice);
    }

    public void updateOwnerNotice(OwnerNotice notice) {
        noticeMapper.updateOwnerNotice(notice);
    }
 
    public void deleteOwnerNotice(Integer notice_id) {
        noticeMapper.deleteOwnerNotice(notice_id);
    }
  
    public void increaseOwnerNoticeViewCount(Integer notice_id) {
        noticeMapper.increaseOwnerNoticeViewCount(notice_id);
    }
    
    public Integer getMaxCountFromUserNotice() {
    	return this.noticeMapper.getMaxCountFromUserNotice();
    }
}