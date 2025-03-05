<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="page-header">
    <h1 class="page-title">공지사항</h1>
    <p class="page-subtitle">금베달리스트의 중요 소식을 확인하세요</p>
</div>

<div class="notice-container">
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
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
                                <td colspan="5" class="text-center py-5">
                                    <div class="d-flex flex-column align-items-center">
                                        <i class="fas fa-exclamation-circle mb-3" style="font-size: 2rem; color: var(--gray-400);"></i>
                                        <p>등록된 공지사항이 없습니다.</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        
                        <c:forEach var="notice" items="${noticeList}">
                            <tr class="${notice.important == 'Y' ? 'notice-important' : ''}">
                                <td>${notice.notice_id}</td>
                                <td>
                                    <a href="<c:url value='/user/notice/${notice.notice_id}'/>" class="notice-link">
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
        </div>
    </div>
    
    <!-- 페이지네이션 (필요시 추가) -->
    <c:if test="${not empty pagination}">
    <div class="d-flex justify-content-center mt-4">
        <ul class="pagination">
            <!-- 이전 페이지 -->
            <c:if test="${pagination.currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="<c:url value='/user/notice?page=${pagination.currentPage - 1}'/>">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </li>
            </c:if>
            
            <!-- 페이지 번호 -->
            <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="pageNum">
                <li class="page-item ${pageNum == pagination.currentPage ? 'active' : ''}">
                    <a class="page-link" href="<c:url value='/user/notice?page=${pageNum}'/>">${pageNum}</a>
                </li>
            </c:forEach>
            
            <!-- 다음 페이지 -->
            <c:if test="${pagination.currentPage < pagination.totalPages}">
                <li class="page-item">
                    <a class="page-link" href="<c:url value='/user/notice?page=${pagination.currentPage + 1}'/>">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </li>
            </c:if>
        </ul>
    </div>
    </c:if>
    
    <!-- 돌아가기 버튼 -->
    <div class="text-center mt-4">
        <a href="<c:url value='/user/index'/>" class="btn btn-outline-gold">
            <i class="fas fa-home mr-1"></i> 홈으로
        </a>
    </div>
</div>