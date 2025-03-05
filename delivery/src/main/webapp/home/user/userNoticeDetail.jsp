<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="page-header">
    <h1 class="page-title">공지사항</h1>
    <p class="page-subtitle">금베달리스트의 중요 소식을 확인하세요</p>
    
    <!-- 간단한 브레드크럼 -->
    <nav class="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/user/index'/>">홈</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/user/notice'/>">공지사항</a></li>
            <li class="breadcrumb-item active">상세 보기</li>
        </ol>
    </nav>
</div>

<div class="notice-detail-container">
    <div class="card">
        <div class="card-body">
            <!-- 공지사항 헤더 -->
            <div class="notice-detail-header">
                <div class="notice-detail-subject">
                    <c:if test="${notice.important == 'Y'}">
                        <span class="notice-badge">중요</span>
                    </c:if>
                    ${notice.title}
                </div>
                <div class="notice-detail-info">
                    <span>
                        <i class="fas fa-user mr-1"></i> ${notice.writer}
                    </span>
                    <span>
                        <i class="fas fa-calendar mr-1"></i> 
                        <fmt:formatDate value="${notice.reg_date}" pattern="yyyy-MM-dd HH:mm"/>
                    </span>
                    <span>
                        <i class="fas fa-eye mr-1"></i> 조회수: ${notice.view_count}
                    </span>
                </div>
            </div>
            
            <!-- 공지사항 내용 -->
            <div class="notice-detail-content">
                ${notice.content}
            </div>
            
            <!-- 이전/다음 글 (선택적) -->
            <c:if test="${not empty prevNextNotices}">
                <div class="notice-nav mt-4 pt-3 border-top">
                    <c:if test="${not empty prevNextNotices.prev}">
                        <div class="notice-nav-item d-flex mb-2">
                            <span class="mr-2 text-muted"><i class="fas fa-chevron-up"></i> 이전글:</span>
                            <a href="<c:url value='/user/notice/${prevNextNotices.prev.notice_id}'/>" class="notice-link">
                                ${prevNextNotices.prev.title}
                            </a>
                        </div>
                    </c:if>
                    <c:if test="${not empty prevNextNotices.next}">
                        <div class="notice-nav-item d-flex">
                            <span class="mr-2 text-muted"><i class="fas fa-chevron-down"></i> 다음글:</span>
                            <a href="<c:url value='/user/notice/${prevNextNotices.next.notice_id}'/>" class="notice-link">
                                ${prevNextNotices.next.title}
                            </a>
                        </div>
                    </c:if>
                </div>
            </c:if>
            
            <!-- 하단 버튼 영역 -->
            <div class="notice-detail-buttons mt-4 text-center">
                <a href="<c:url value='/user/notice'/>" class="btn btn-outline-gold">
                    <i class="fas fa-list mr-1"></i> 목록으로
                </a>
            </div>
        </div>
    </div>
</div>