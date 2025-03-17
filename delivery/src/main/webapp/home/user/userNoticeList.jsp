<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="page-header">
    <h1 class="page-title">공지사항</h1>
    <p class="page-subtitle">금베달리스트의 중요 소식을 확인하세요</p>
</div>

<div class="notice-container">
    <div class="card shadow-sm">
        <div class="card-body p-0">
            <!-- 페이지 정보 표시 -->
            <div align="right" style="padding: 10px 20px;">
                ${START + 1}~${END - 1}/${TOTAL}
            </div>
            
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
                        <c:if test="${empty LIST}">
                            <tr>
                                <td colspan="5" class="text-center py-4">
                                    <div class="d-flex flex-column align-items-center">
                                        <i class="fas fa-bullhorn mb-2" style="font-size: 1.5rem; color: var(--gray-400);"></i>
                                        <p class="mb-0">등록된 공지사항이 없습니다.</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        
                        <c:forEach var="notice" items="${LIST}">
                            <tr class="${notice.important == 'Y' ? 'notice-important' : ''}">
                                <td class="text-center">${notice.notice_id}</td>
                                <td>
                                    <a href="<c:url value='/user/notice/${notice.notice_id}'/>" class="notice-link">
                                        <c:if test="${notice.important == 'Y'}">
                                            <span class="notice-badge">중요</span>
                                        </c:if>
                                        ${notice.title}
                                        <c:if test="${notice.reg_date >= yesterday}">
                                            <span class="badge badge-primary ml-2">NEW</span>
                                        </c:if>
                                    </a>
                                </td>
                                <td>${notice.writer}</td>
                                <td class="notice-date">
                                    <fmt:formatDate value="${notice.reg_date}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td class="notice-view-count text-center">${notice.view_count}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- 페이지네이션 (간소화된 버전) -->
    <div align="center" style="margin-top: 20px;">
        <c:set var="currentPage" value="${currentPage}"/>
        <c:set var="pageCount" value="${(TOTAL + 4) / 5}"/>
        <c:set var="startPage" value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1}"/>
        <c:set var="endPage" value="${startPage + 9}"/>
        
        <c:if test="${endPage > pageCount}">
            <c:set var="endPage" value="${pageCount}"/>
        </c:if>
        
        <c:if test="${startPage > 10}">
            <a href="<c:url value='/user/notice?PAGE_NUM=${startPage - 1}'/>">[이전]</a>
        </c:if>
        
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <c:if test="${currentPage == i}">
                <font size="5">
            </c:if>
            <a href="<c:url value='/user/notice?PAGE_NUM=${i}'/>">${i}</a>
            <c:if test="${currentPage == i}">
                </font>
            </c:if>
        </c:forEach>
        
        <c:if test="${endPage < pageCount}">
            <a href="<c:url value='/user/notice?PAGE_NUM=${endPage + 1}'/>">[다음]</a>
        </c:if>
    </div>
    
    <!-- 돌아가기 버튼 -->
    <div class="text-center mt-3">
        <a href="<c:url value='/user/index'/>" class="btn btn-outline-gold btn-sm">
            <i class="fas fa-home mr-1"></i> 홈으로
        </a>
    </div>
</div>