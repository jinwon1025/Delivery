<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="page-header text-center mb-4">
    <h2 class="page-title">리뷰 관리</h2>
    <p class="page-subtitle text-muted">내가 작성한 리뷰를 확인하고 관리할 수 있습니다.</p>
</div>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h3 class="card-title mb-0">내가 작성한 리뷰</h3>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty reviewList}">
                    <div class="text-center py-5">
                        <p class="mb-0">작성한 리뷰가 없습니다.</p>
                        <p class="text-muted">음식을 주문하고 리뷰를 남겨보세요!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="review-list">
                        <c:forEach var="review" items="${reviewList}">
                            <div class="review-item mb-4 border rounded p-3">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h5 class="store-name">${review.STORE_NAME}</h5>
                                    <span class="text-muted small">
                                        <fmt:formatDate value="${review.WRITE_DATE}" pattern="yyyy.MM.dd" />
                                    </span>
                                </div>
                                
                                <div class="rating mb-2">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="fas fa-star ${i <= review.RATING ? 'text-warning' : 'text-muted'}"></i>
                                    </c:forEach>
                                </div>
                                
                                <c:if test="${not empty review.REVIEW_IMAGE_NAME}">
                                    <div class="review-image mb-2">
                                        <img src="${pageContext.request.contextPath}/upload/reviewProfile/${review.REVIEW_IMAGE_NAME}" 
                                            alt="리뷰 이미지" class="img-fluid rounded" style="max-height: 150px;" />
                                    </div>
                                </c:if>
                                
                                <p class="review-content mb-3">${review.REVIEW_CONTENT}</p>
                                
                                <div class="d-flex justify-content-end">
                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                            onclick="if(confirm('리뷰를 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/userstore/deleteReview?reviewId=${review.REVIEW_ID}'">
                                        삭제
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<style>
    .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 0 15px;
    }
    
    .page-title {
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 8px;
    }
    
    .card {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        overflow: hidden;
        margin-bottom: 20px;
    }
    
    .card-header {
        padding: 15px 20px;
        border-bottom: 1px solid #eee;
    }
    
    .card-body {
        padding: 20px;
    }
    
    .text-warning {
        color: #ffcc00 !important;
    }
    
    .review-item {
        background-color: #fff;
        transition: all 0.2s;
    }
    
    .review-item:hover {
        box-shadow: 0 3px 6px rgba(0,0,0,0.1);
    }
    
    .store-name {
        font-weight: 600;
        color: #333;
    }
</style>