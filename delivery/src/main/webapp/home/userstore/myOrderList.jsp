<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 주문 내역</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 0;
	color: #333;
}

.order-header {
	background-color: #fff;
	padding: 15px 20px;
	border-bottom: 1px solid #eee;
	position: sticky;
	top: 0;
	z-index: 100;
}

.order-header h1 {
	margin: 0;
	font-size: 20px;
	font-weight: 700;
}

.order-list {
	padding: 15px;
}

.order-item {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	margin-bottom: 15px;
	overflow: hidden;
}

.order-date {
	padding: 15px;
	border-bottom: 1px solid #eee;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.date {
	font-size: 14px;
	color: #666;
}

.status {
	font-size: 14px;
	font-weight: 500;
	padding: 5px 10px;
	border-radius: 15px;
	background-color: #e9ecef;
}

.status-completed {
	background-color: #d4edda;
	color: #155724;
}

.status-preparing {
	background-color: #cce5ff;
	color: #004085;
}

.status-delivering {
	background-color: #fff3cd;
	color: #856404;
}

.order-store {
	padding: 15px;
	display: flex;
	align-items: center;
	position: relative;
}

.store-image {
	width: 60px;
	height: 60px;
	border-radius: 8px;
	margin-right: 15px;
	background-color: #f8f9fa;
	overflow: hidden;
}

.store-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.store-info {
	flex: 1;
}

.store-name {
	font-size: 16px;
	font-weight: 700;
	margin-bottom: 5px;
	display: flex;
	align-items: center;
}

.store-name:after {
	content: "›";
	margin-left: 5px;
	color: #999;
	font-size: 18px;
}

.menu-name {
	color: #666;
	font-size: 14px;
	margin-bottom: 5px;
}

.price {
	font-size: 16px;
	font-weight: 500;
	color: #ff6b6b;
}

.price .discount {
	font-size: 13px;
	color: #939393;
	margin-left: 5px;
	text-decoration: line-through;
}

.buttons {
	padding: 15px;
	display: flex;
	border-top: 1px solid #eee;
}

.btn {
	flex: 1;
	padding: 12px 0;
	text-align: center;
	border-radius: 5px;
	font-size: 14px;
	font-weight: 500;
	cursor: pointer;
	text-decoration: none;
}

.btn-detail {
	background-color: #fff;
	color: #ff6b6b;
	border: 1px solid #ff6b6b;
	margin-right: 8px;
}

.btn-review {
	background-color: #3E90FF;
	color: #fff;
	border: 1px solid #3E90FF;
}

.btn-review-disabled {
	background-color: #cccccc;
	color: #666666;
	border: 1px solid #cccccc;
	cursor: not-allowed;
}

.btn-review-completed {
    background-color: #2e86de;  /* 밝은 파란색으로 변경 */
    color: #fff;
    border: 1px solid #2e86de;
    cursor: pointer;  /* 클릭 가능함을 나타내는 포인터 커서 */
}

.empty-orders {
	text-align: center;
	padding: 50px 20px;
}

.empty-icon {
	font-size: 48px;
	color: #ddd;
	margin-bottom: 20px;
}

.empty-text {
	color: #999;
	margin-bottom: 20px;
}

.btn-browse {
	display: inline-block;
	background-color: #ff6b6b;
	color: #fff;
	padding: 12px 30px;
	border-radius: 5px;
	text-decoration: none;
	font-weight: 500;
}
</style>
</head>
<body>
	<div class="order-header">
		<h1>주문 내역</h1>
	</div>

	<div class="order-list">
		<c:choose>
			<c:when test="${empty orderList}">
				<div class="empty-orders">
					<div class="empty-icon">🛵</div>
					<div class="empty-text">
						<p>주문 내역이 없습니다.</p>
						<p>맛있는 음식을 주문해보세요!</p>
					</div>
					<a href="/user/categoryStores" class="btn-browse">메뉴 보러가기</a>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach var="order" items="${orderList}">
					<div class="order-item">
						<div class="order-date">
							<div class="date">
								<fmt:formatDate value="${order.ORDER_TIME}" pattern="M.d (E)" />
								<span>•</span>
								<c:choose>
									<c:when test="${order.ORDER_STATUS == 4}">배달완료</c:when>
									<c:otherwise>배달중</c:otherwise>
								</c:choose>
							</div>
							<div
								class="status ${order.ORDER_STATUS == 4 ? 'status-completed' : order.ORDER_STATUS == 3 ? 'status-delivering' : 'status-preparing'}">
								<c:choose>
									<c:when test="${order.ORDER_STATUS == 1}">접수 완료</c:when>
									<c:when test="${order.ORDER_STATUS == 2}">준비 중</c:when>
									<c:when test="${order.ORDER_STATUS == 3}">배달 중</c:when>
									<c:when test="${order.ORDER_STATUS == 4}">배달 완료</c:when>
									<c:otherwise>상태 미정</c:otherwise>
								</c:choose>
							</div>
						</div>

						<div class="order-store">
							<div class="store-image">
								<img
									src="${pageContext.request.contextPath}/upload/	storeProfile/${order.STORE_IMAGE_NAME}"
									onerror="this.src='${pageContext.request.contextPath}/image/noImage.png'">
							</div>
							<div class="store-info">
								<div class="store-name">${order.STORE_NAME}</div>
								<div class="menu-name">
									${order.main_menu_name}
									<c:if test="${order.additional_menu_count > 0}">
                                        외 ${order.additional_menu_count}개
                                    </c:if>
								</div>
								<div class="price">
									<fmt:formatNumber value="${order.TOTALPRICE}" pattern="#,###원" />
								</div>
							</div>
						</div>

						<div class="buttons">
							<a
								href="${pageContext.request.contextPath}/userstore/orderDetail?orderId=${order.ORDER_ID}"
								class="btn btn-detail">주문 상세</a>

							<c:choose>
								<c:when test="${order.ORDER_STATUS == 4}">
									<c:choose>
										<c:when test="${order.HAS_REVIEW}">
											<a
												href="${pageContext.request.contextPath}/userstore/viewReview?orderId=${order.ORDER_ID}"
												class="btn btn-review-completed">리뷰 보기</a>
										</c:when>
										<c:otherwise>
											<a
												href="${pageContext.request.contextPath}/userstore/goWriteReview?orderId=${order.ORDER_ID}&storeId=${order.STORE_ID}"
												class="btn btn-review">리뷰쓰기</a>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<span class="btn btn-review-disabled"
										title="배달 완료 후 리뷰를 작성할 수 있습니다">리뷰쓰기</span>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>