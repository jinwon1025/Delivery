<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
    .notice-detail-container {
        width: 90%;
        max-width: 900px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .notice-detail-title {
        font-size: 24px;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid #1a237e;
        color: #1a237e;
    }
    
    .notice-detail-header {
        background-color: #f5f7fa;
        padding: 15px;
        border-radius: 5px;
        margin-bottom: 20px;
    }
    
    .notice-detail-subject {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 15px;
    }
    
    .notice-detail-info {
        display: flex;
        justify-content: space-between;
        color: #777;
        font-size: 0.9em;
    }
    
    .notice-detail-content {
        min-height: 300px;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background-color: white;
        margin-bottom: 20px;
        white-space: pre-line;
    }
    
    .notice-detail-buttons {
        text-align: center;
        margin-top: 20px;
    }
    
    .btn-back {
        display: inline-block;
        padding: 10px 20px;
        background-color: #1a237e;
        color: white;
        border-radius: 5px;
        text-decoration: none;
        font-weight: bold;
    }
    
    .btn-back:hover {
        background-color: #0e1858;
    }
    
    .notice-badge {
        display: inline-block;
        padding: 3px 8px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: bold;
        color: white;
        background-color: #f44336;
        margin-right: 10px;
    }
</style>

<div class="notice-detail-container">
    <h2 class="notice-detail-title">공지사항</h2>
    
    <div class="notice-detail-header">
        <div class="notice-detail-subject">
            <c:if test="${notice.important == 'Y'}">
                <span class="notice-badge">중요</span>
            </c:if>
            ${notice.title}
        </div>
        <div class="notice-detail-info">
            <span>작성자: ${notice.writer}</span>
            <span>작성일: <fmt:formatDate value="${notice.reg_date}" pattern="yyyy-MM-dd HH:mm"/></span>
            <span>조회수: ${notice.view_count}</span>
        </div>
    </div>
    
    <div class="notice-detail-content">
        ${notice.content}
    </div>
    
    <div class="notice-detail-buttons">
        <a href="/user/notice" class="btn-back">목록으로 돌아가기</a>
    </div>
</div>