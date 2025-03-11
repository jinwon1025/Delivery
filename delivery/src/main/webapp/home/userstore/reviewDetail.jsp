<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>리뷰 상세</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
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

/* 별점  표시 */
.stars {
	display: inline-block;
}

.stars span {
	color: #ddd;
}

.stars span.filled {
	color: #ffcc00;
}
</style>
</head>
<body>
	<div class="review-container">
		<div class="review-header">
			<div>
				<div class="review-title">리뷰 상세</div>
				<div class="order-id">주문번호: ${review.order_id}</div>
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

		<div class="review-content">${review.review_content}</div>

		<div class="review-footer">
			<div class="review-date">작성일: ${review.write_date}</div>
		</div>

	</div>
</body>
</html>