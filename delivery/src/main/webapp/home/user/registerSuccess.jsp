<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="auth-container text-center">
    <div class="success-icon mb-4">
        <i class="fas fa-check-circle" style="font-size: 5rem; color: var(--primary-color);"></i>
    </div>
    
    <h2 class="auth-title mb-3">회원가입 완료!</h2>
    <p class="mb-4">금베달리스트 회원으로 가입되었습니다. 이제 다양한 맛집을 주문해보세요!</p>
    
    <div class="d-flex justify-content-center">
        <a href="<c:url value='/user/index'/>" class="btn btn-primary">
            <i class="fas fa-sign-in-alt mr-1"></i> 로그인하기
        </a>
    </div>
</div>