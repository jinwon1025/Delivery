<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 리뷰 관리</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        .review-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .review-header {
            background-color: #4CAF50;
            color: white;
            padding: 15px 20px;
            text-align: center;
            font-size: 1.2em;
            font-weight: bold;
        }
        .review-list {
            padding: 15px;
        }
        .review-item {
            background-color: #f9f9f9;
            border-radius: 10px;
            margin-bottom: 20px;
            padding: 20px;
            position: relative;
            border: 1px solid #e0e0e0;
            transition: all 0.2s;
        }
        .review-item:hover {
            box-shadow: 0 3px 6px rgba(0,0,0,0.1);
        }
        .review-store {
            font-size: 1.2em;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        .review-date {
            position: absolute;
            top: 20px;
            right: 20px;
            color: #7f8c8d;
            font-size: 0.9em;
        }
        .rating {
            margin-bottom: 15px;
        }
        .text-warning {
            color: #ffcc00 !important;
        }
        .text-muted {
            color: #bdc3c7 !important;
        }
        .review-content {
            margin-bottom: 15px;
            line-height: 1.5;
        }
        .review-image {
            margin-bottom: 15px;
        }
        .review-image img {
            max-height: 180px;
            border-radius: 5px;
        }
        .btn {
            padding: 5px 15px;
            border-radius: 5px;
            font-size: 0.9em;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-outline-danger {
            color: #e74c3c;
            background-color: transparent;
            border: 1px solid #e74c3c;
        }
        .btn-outline-danger:hover {
            color: #fff;
            background-color: #e74c3c;
        }
        .no-reviews {
            text-align: center;
            color: #7f8c8d;
            padding: 40px 20px;
            font-size: 1em;
        }
        .no-reviews p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <div class="review-container">
        <div class="review-header">
            내 리뷰 관리 (<span class="review-count">${fn:length(reviewList)}개</span>)
        </div>
        <div class="review-list">
            <c:choose>
                <c:when test="${empty reviewList}">
                    <div class="no-reviews">
                        <p>작성한 리뷰가 없습니다.</p>
                        <p class="text-muted">음식을 주문하고 리뷰를 남겨보세요!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="review" items="${reviewList}">
                        <div class="review-item">
                            <div class="review-store">${review.STORE_NAME}</div>
                            <div class="review-date">
                                <fmt:formatDate value="${review.WRITE_DATE}" pattern="yyyy.MM.dd" />
                            </div>
                            
                            <div class="rating">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fas fa-star ${i <= review.RATING ? 'text-warning' : 'text-muted'}"></i>
                                </c:forEach>
                            </div>
                            
                            <c:if test="${not empty review.REVIEW_IMAGE_NAME}">
                                <div class="review-image">
                                    <img src="${pageContext.request.contextPath}/upload/reviewProfile/${review.REVIEW_IMAGE_NAME}" 
                                        alt="리뷰 이미지" />
                                </div>
                            </c:if>
                            
                            <p class="review-content">${review.REVIEW_CONTENT}</p>
                            
                            <div style="text-align: right;">
                                <button type="button" class="btn btn-outline-danger" 
                                        onclick="if(confirm('리뷰를 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/userstore/deleteReview?reviewId=${review.REVIEW_ID}'">
                                    삭제
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>