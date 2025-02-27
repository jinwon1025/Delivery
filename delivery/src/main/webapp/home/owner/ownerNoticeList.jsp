<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
    .notice-container {
        width: 90%;
        max-width: 900px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .notice-title {
        font-size: 24px;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 2px solid #1a237e;
        color: #1a237e;
    }
    
    .notice-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    
    .notice-table th, .notice-table td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }
    
    .notice-table th {
        background-color: #f5f7fa;
        font-weight: bold;
    }
    
    .notice-table tr:hover {
        background-color: #f9f9f9;
    }
    
    .notice-important {
        background-color: #fff3f3;
    }
    
    .notice-badge {
        display: inline-block;
        padding: 3px 8px;
        border-radius: 50px;
        font-size: 12px;
        font-weight: bold;
        color: white;
        background-color: #f44336;
    }
    
    .notice-link {
        color: #333;
        text-decoration: none;
    }
    
    .notice-link:hover {
        color: #1e88e5;
        text-decoration: underline;
    }
    
    .notice-date {
        color: #777;
        font-size: 0.9em;
    }
    
    .notice-view-count {
        color: #777;
        font-size: 0.9em;
        text-align: center;
    }
</style>

<div class="notice-container">
    <h2 class="notice-title">사업자 공지사항</h2>
    
    <table class="notice-table">
        <thead>
            <tr>
                <th style="width: 10%">번호</th>
                <th style="width: 55%">제목</th>
                <th style="width: 15%">작성자</th>
                <th style="width: 15%">작성일</th>
                <th style="width: 5%">조회</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty noticeList}">
                <tr>
                    <td colspan="5" style="text-align: center;">등록된 공지사항이 없습니다.</td>
                </tr>
            </c:if>
            
            <c:forEach var="notice" items="${noticeList}">
                <tr class="${notice.important == 'Y' ? 'notice-important' : ''}">
                    <td>${notice.notice_id}</td>
                    <td>
                        <a href="/owner/notice/${notice.notice_id}" class="notice-link">
                            <c:if test="${notice.important == 'Y'}">
                                <span class="notice-badge">중요</span>
                            </c:if>
                            ${notice.title}
                        </a>
                    </td>
                    <td>${notice.writer}</td>
                    <td class="notice-date">
                        <fmt:formatDate value="${notice.reg_date}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td class="notice-view-count">${notice.view_count}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>