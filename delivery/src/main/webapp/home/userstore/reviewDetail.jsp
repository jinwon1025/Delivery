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
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f0f2f5;
    margin: 0;
    padding: 20px;
    color: #333;
    line-height: 1.6;
}

.review-container {
    max-width: 800px;
    margin: 30px auto;
    padding: 30px;
    background-color: #fff;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.review-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 20px;
    border-bottom: 2px solid #f0f0f0;
    margin-bottom: 25px;
}

.review-title {
    font-size: 1.8rem;
    font-weight: 700;
    color: #222;
}

.order-id {
    color: #666;
    font-size: 0.95rem;
    margin-top: 5px;
}

.rating-container {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    background-color: #fffaf0;
    padding: 12px 15px;
    border-radius: 10px;
    border-left: 4px solid #ffd700;
}

.rating-stars {
    margin-right: 15px;
}

.rating-value {
    font-weight: 700;
    font-size: 1.3rem;
    color: #ff6b6b;
}

.review-content {
    background-color: #f9f9f9;
    padding: 25px;
    border-radius: 10px;
    line-height: 1.7;
    margin-bottom: 25px;
    min-height: 100px;
    box-shadow: inset 0 0 5px rgba(0, 0, 0, 0.05);
    color: #444;
    font-size: 1.05rem;
}

.review-image {
    margin: 25px 0;
    text-align: center;
}

.review-image img {
    max-width: 100%;
    max-height: 450px;
    border-radius: 10px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
}

.review-footer {
    display: flex;
    justify-content: space-between;
    color: #777;
    font-size: 0.9rem;
    padding: 15px 0;
    border-top: 1px solid #eee;
}

.review-date {
    font-style: italic;
}

.btn-container {
    text-align: center;
    margin-top: 35px;
}

.btn {
    display: inline-block;
    padding: 12px 25px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 600;
    margin: 0 10px;
    transition: all 0.2s ease;
}

.btn-back {
    background-color: #f0f0f0;
    color: #444;
    border: 1px solid #ddd;
}

.btn-back:hover {
    background-color: #e4e4e4;
}

.btn-edit {
    background-color: #ff6b6b;
    color: white;
    border: 1px solid #ff6b6b;
}

.btn-edit:hover {
    background-color: #ff5252;
}

/* 별점 표시 */
.stars {
    display: inline-block;
    font-size: 1.6rem;
    margin-right: 12px;
    letter-spacing: 3px;
}

.stars span {
    color: #ddd;
}

.stars span.filled {
    color: #ffcc00;
    text-shadow: 0 0 1px rgba(0, 0, 0, 0.3);
}

/* 답변 스타일 - 말풍선 형태로 변경 */
.reply-container {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    margin-top: 30px;
    margin-bottom: 20px;
    background-color: #f8fbff;
    padding: 20px;
    border-radius: 15px;
    position: relative;
}

.reply-container:before {
    content: '사장님 답변';
    position: absolute;
    top: -12px;
    right: 20px;
    background-color: #4a90e2;
    color: white;
    padding: 4px 12px;
    border-radius: 15px;
    font-size: 0.8rem;
    font-weight: 600;
}

.reply-header {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    margin-bottom: 10px;
    width: 100%;
}

.reply-header img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-left: 12px;
    border: 2px solid #fff;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
}

.reply-title {
    font-weight: 700;
    margin-right: 10px;
    color: #4a90e2;
}

.reply-date {
    color: #888;
    font-size: 0.85rem;
    margin-right: 10px;
}

.reply-bubble {
    position: relative;
    background-color: #e8f4ff;
    border-radius: 15px;
    padding: 18px;
    width: 85%;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
    margin-left: auto;
    border: 1px solid #d1e6ff;
}

.reply-bubble:after {
    content: '';
    position: absolute;
    top: 15px;
    right: -12px;
    border-width: 10px 0 10px 12px;
    border-style: solid;
    border-color: transparent transparent transparent #e8f4ff;
}

.reply-content {
    line-height: 1.7;
    color: #333;
    word-break: break-word;
    font-size: 1.05rem;
}

.owner-info {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    margin-bottom: 10px;
}

.owner-name {
    font-size: 1rem;
    color: #4a90e2;
    font-weight: 600;
    margin-right: 10px;
}

.no-review {
    text-align: center;
    padding: 80px 0;
    color: #999;
    font-size: 1.3rem;
    background-color: #f9f9f9;
    border-radius: 10px;
}

.no-review p {
    margin: 0;
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
                    <div class="order-id">주문 번호: ${review.orderId}</div>
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
            
            <!-- 사장님 답글 (있는 경우에만 표시) - 말풍선 형태로 변경 -->
            <c:if test="${review.replyId != null}">
                <div class="reply-container">
                    <div class="owner-info">
                        <div class="owner-name">${review.ownerName} 사장님</div>
                        <c:if test="${not empty review.ownerImageName}">
                            <img src="${pageContext.request.contextPath}/upload/ownerProfile/${review.ownerImageName}" 
                                alt="사장님 이미지" style="width: 36px; height: 36px; border-radius: 50%;">
                        </c:if>
                    </div>
                    <div class="reply-bubble">
                        <div class="reply-content">
                            ${review.replyContent}
                        </div>
                    </div>
                    <div class="reply-date" style="text-align: right; margin-top: 8px;">
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