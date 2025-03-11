<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>리뷰 상세</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<style>
.review-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.review-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
    margin-bottom: 20px;
}

.review-title {
    font-size: 1.5rem;
    font-weight: 700;
    color: #333;
}

.order-id {
    color: #666;
    font-size: 0.9rem;
}

.rating-container {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
}

.rating-stars {
    color: #ff6b6b;
    font-size: 1.5rem;
    margin-right: 10px;
}

.rating-value {
    font-weight: 700;
    font-size: 1.2rem;
}

.review-content {
    background-color: #f9f9f9;
    padding: 20px;
    border-radius: 5px;
    line-height: 1.6;
    margin-bottom: 20px;
    min-height: 100px;
}

.review-image {
    margin: 20px 0;
    text-align: center;
}

.review-image img {
    max-width: 100%;
    max-height: 400px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.review-footer {
    display: flex;
    justify-content: space-between;
    color: #888;
    font-size: 0.9rem;
}

.review-date {
    font-style: italic;
}

.btn-container {
    text-align: center;
    margin-top: 30px;
}

.btn {
    display: inline-block;
    padding: 10px 20px;
    border-radius: 5px;
    text-decoration: none;
    font-weight: 500;
    margin: 0 10px;
}

.btn-back {
    background-color: #f0f0f0;
    color: #333;
    border: 1px solid #ddd;
}

.btn-edit {
    background-color: #ff6b6b;
    color: white;
    border: 1px solid #ff6b6b;
}

/* 별점 표시 */
.stars {
    display: inline-block;
}

.stars span {
    color: #ddd;
}

.stars span.filled {
    color: #ffcc00;
}

/* 답변 스타일 - 말풍선 형태로 변경 */
.reply-container {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    margin-top: 20px;
    margin-bottom: 20px;
}

.reply-header {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    margin-bottom: 8px;
    width: 100%;
}

.reply-header img {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    margin-left: 10px;
}

.reply-title {
    font-weight: 700;
    margin-right: 10px;
}

.reply-date {
    color: #888;
    font-size: 0.8rem;
    margin-right: 10px;
}

.reply-bubble {
    position: relative;
    background-color: #e8f4ff;
    border-radius: 15px;
    padding: 15px;
    max-width: 80%;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    margin-left: auto;
}

.reply-bubble:after {
    content: '';
    position: absolute;
    top: 10px;
    right: -10px;
    border-width: 10px 0 10px 10px;
    border-style: solid;
    border-color: transparent transparent transparent #e8f4ff;
}

.reply-content {
    line-height: 1.6;
    color: #333;
    word-break: break-word;
}

.owner-info {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    margin-bottom: 5px;
}

.owner-name {
    font-size: 0.9rem;
    color: #666;
    margin-right: 10px;
}

.no-review {
    text-align: center;
    padding: 50px 0;
    color: #999;
    font-size: 1.2rem;
}
</style>
</head>
<body>
<c:choose>
    <c:when test="${empty review}">
        <div class="review-container">
            <div class="no-review">
                <p>등록된 리뷰가 없습니다.</p>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="review-container">
            <div class="review-header">
                <div>
                    <div class="review-title">리뷰 상세</div>
                    <div class="order-id">주문번호: ${review.orderId}</div>
                </div>
            </div>

            <div class="rating-container">
                <div class="stars">
                    <c:forEach begin="1" end="5" var="i">
                        <span class="${i <= review.rating ? 'filled' : ''}">★</span>
                    </c:forEach>
                </div>
                <div class="rating-value">${review.rating}/5</div>
            </div>

            <div class="review-content">${review.reviewContent}</div>

            <!-- 리뷰 이미지 (있는 경우에만 표시) -->
            <c:if test="${not empty review.reviewImageName}">
                <div class="review-image">
                    <img src="${pageContext.request.contextPath}/upload/reviewProfile/${review.reviewImageName}" 
                         alt="리뷰 이미지">
                </div>
            </c:if>

            <div class="review-footer">
                <div class="review-date">작성일: <fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd HH:mm" /></div>
            </div>
            
            <!-- 사업자 답글 (있는 경우에만 표시) - 말풍선 형태로 변경 -->
            <c:if test="${review.replyId != null}">
                <div class="reply-container">
                    <div class="owner-info">
                        <div class="owner-name">${review.ownerName} 사장님</div>
                        <c:if test="${not empty review.ownerImageName}">
                            <img src="${pageContext.request.contextPath}/upload/ownerProfile/${review.ownerImageName}" 
                                alt="사장님 이미지" style="width: 30px; height: 30px; border-radius: 50%;">
                        </c:if>
                    </div>
                    <div class="reply-bubble">
                        <div class="reply-content">
                            ${review.replyContent}
                        </div>
                    </div>
                    <div class="reply-date" style="text-align: right; margin-top: 5px;">
                        <fmt:formatDate value="${review.replyDate}" pattern="yyyy-MM-dd HH:mm" />
                    </div>
                </div>
            </c:if>
        </div>
    </c:otherwise>
</c:choose>

<!-- Map 형식의 데이터에 맞게 수정된 스크립트 -->
<script>
    // 디버깅용: 리뷰 객체 내용 확인
    console.log("리뷰 정보:", ${not empty review ? 'true' : 'false'});
</script>
</body>
</html>