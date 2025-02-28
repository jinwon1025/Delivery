<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 환영 배너 -->
<div class="welcome-banner bg-gradient-gold rounded p-4 text-white mb-4">
    <div class="d-flex align-items-center">
        <div class="mr-3">
            <i class="fas fa-check-circle" style="font-size: 2.5rem;"></i>
        </div>
        <div>
            <h2 class="font-bold mb-1">로그인 성공!</h2>
            <p class="mb-0">${sessionScope.loginUser.user_name}님 환영합니다. 금베달리스트와 함께 맛있는 배달을 즐겨보세요!</p>
        </div>
    </div>
</div>

<!-- 추천 카테고리 섹션 -->
<div class="section-title mb-4">
    <h2>추천 카테고리</h2>
</div>

<div class="category-cards mb-5">
    <c:forEach var="category" items="${maincategoryList}" varStatus="status" begin="0" end="3">
        <a href="<c:url value='/user/categoryStores?categoryId=${category.main_category_id}'/>" class="category-card">
            <div class="category-img" style="background-image: url('${pageContext.request.contextPath}/image/categories/${category.main_category_id}.jpg')"></div>
            <div class="category-info">
                <h3 class="category-name">${category.main_category_name}</h3>
                <p class="category-count">가게 ${category.storeCount}개</p>
            </div>
        </a>
    </c:forEach>
</div>

<!-- 추천 가게 섹션 -->
<div class="section-title mb-4">
    <h2>인기 가게</h2>
</div>

<div class="store-list">
    <c:forEach var="popular" items="${popularStores}" varStatus="status" begin="0" end="2">
        <div class="store-item">
            <div class="store-logo">
                <c:choose>
                    <c:when test="${not empty popular.store_image_name}">
                        <img src="${pageContext.request.contextPath}/upload/storeProfile/${popular.store_image_name}" alt="${popular.store_name}">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/image/noStoreProfile.png" alt="기본 이미지">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="store-info" onclick="location.href='<c:url value='/userstore/detail?store_id=${popular.store_id}'/>'">
                <div class="store-name">
                    ${popular.store_name} <span class="store-type">배달</span>
                </div>
                <div class="store-details">
                    <div class="min-order">
                        <span class="min-order-label">최소주문금액:</span> 
                        <span class="min-order-value">${popular.last_price}원</span> 이상 배달
                        <c:if test="${popular.last_price > 12000}">
                            <span class="coupon-tag">쿠폰할인</span>
                        </c:if>
                    </div>
                    <div class="delivery-time">${empty popular.delivery_time ? '20-30분' : popular.delivery_time}</div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<!-- CTA 섹션 -->
<div class="text-center mt-5">
    <a href="<c:url value='/user/categoryStores'/>" class="btn btn-lg btn-primary">모든 가게 보기</a>
</div>