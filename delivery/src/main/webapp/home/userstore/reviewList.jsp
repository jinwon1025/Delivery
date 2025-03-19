<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 리뷰 관리 페이지 -->
<div class="page-header">
    <h1 class="page-title">내 리뷰 관리</h1>
    <p class="page-subtitle">작성한 리뷰를 확인하고 관리할 수 있습니다.</p>
</div>

<div class="review-list-container">
    <div class="review-count-section">
        총 <span class="review-count">${fn:length(reviewList)}</span>개의 리뷰
    </div>
    
    <c:choose>
        <c:when test="${empty reviewList}">
            <div class="no-reviews">
                <i class="fas fa-comment-slash mb-3" style="font-size: 3rem; color: var(--gray-400);"></i>
                <p>작성한 리뷰가 없습니다.</p>
                <p class="text-muted">음식을 주문하고 리뷰를 남겨보세요!</p>
                <a href="<c:url value='/user/categoryStores'/>" class="btn btn-primary mt-3">가게 찾아보기</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="review-list">
                <c:forEach var="review" items="${reviewList}">
                    <div class="review-item">
                        <div class="review-store">${review.storeName}</div>
                        <div class="review-date">
                            <fmt:formatDate value="${review.replyDate}" pattern="yyyy.MM.dd" />
                        </div>
                        
                        <div class="rating">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-muted'}"></i>
                            </c:forEach>
                            <span class="rating-text">${review.rating}</span>
                        </div>
                        
                        <c:if test="${not empty review.reviewImageName}">
                            <div class="review-image">
                                <img src="${pageContext.request.contextPath}/upload/reviewProfile/${review.reviewImageNameE}" 
                                    alt="리뷰 이미지" />
                            </div>
                        </c:if>
                        
                        <p class="review-content">${review.reviewContent}</p>
                        
                        <div class="review-actions">
                            <a href="${pageContext.request.contextPath}/userstore/viewReview?orderId=${review.orderId}" 
                               class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-eye"></i> 상세보기
                            </a>
                            <button type="button" class="btn btn-outline-danger btn-sm" 
                                    onclick="if(confirm('리뷰를 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/userstore/deleteReview?reviewId=${review.reviewId}'">
                                <i class="fas fa-trash-alt"></i> 삭제
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
.review-list-container {
    max-width: 800px;
    margin: 0 auto;
}

.review-count-section {
    font-size: 16px;
    font-weight: 500;
    margin-bottom: 20px;
    color: #444;
}

.review-count {
    font-weight: 700;
    color: #ff6b6b;
}

.review-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.review-item {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    padding: 20px;
    position: relative;
    transition: transform 0.2s;
}

.review-item:hover {
    transform: translateY(-3px);
}

.review-store {
    font-size: 18px;
    font-weight: 600;
    color: #333;
    margin-bottom: 5px;
}

.review-date {
    position: absolute;
    top: 20px;
    right: 20px;
    color: #888;
    font-size: 14px;
}

.rating {
    display: flex;
    align-items: center;
    margin: 10px 0;
}

.fa-star {
    font-size: 16px;
    margin-right: 2px;
}

.text-warning {
    color: #ffcc00 !important;
}

.text-muted {
    color: #ccc !important;
}

.rating-text {
    margin-left: 5px;
    font-weight: 600;
}

.review-content {
    margin: 15px 0;
    line-height: 1.6;
    color: #555;
}

.review-image {
    margin: 15px 0;
}

.review-image img {
    max-width: 100%;
    max-height: 200px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.review-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 15px;
}

.btn-sm {
    padding: 5px 10px;
    font-size: 14px;
}

.no-reviews {
    text-align: center;
    padding: 50px 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.no-reviews i {
    display: block;
    margin-bottom: 15px;
}

.no-reviews p {
    margin-bottom: 5px;
    font-size: 16px;
}

.no-reviews .text-muted {
    color: #888 !important;
    font-size: 14px;
}

.no-reviews .btn {
    margin-top: 20px;
}
</style>