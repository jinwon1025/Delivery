<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴목록</title>
<style>
.menu-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	margin-top: 20px;
}

.menu-item {
	width: 250px;
	border: 1px solid #ddd;
	border-radius: 10px;
	padding: 10px;
	text-align: center;
	box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
}

.menu-item img {
	width: 100%;
	height: 150px;
	object-fit: cover;
	border-radius: 10px;
}

.menu-name {
	font-size: 18px;
	font-weight: bold;
	margin: 10px 0;
}

.menu-content {
	font-size: 14px;
	color: #666;
	margin-bottom: 10px;
}

.menu-price {
	font-size: 16px;
	color: #e74c3c;
	font-weight: bold;
}

.menu-item {
	cursor: pointer;
	transition: all 0.2s ease;
}

.category-section {
	margin-bottom: 30px;
	width: 100%;
}

.category-title {
	font-size: 24px;
	font-weight: bold;
	margin: 20px 0 15px 0;
	padding-bottom: 8px;
	border-bottom: 2px solid #3a4cb4;
	color: #333;
}

/* 쿠폰 관련 개선된 스타일 */
.coupon-section {
	margin-bottom: 30px;
	border: 1px solid #e0e0e0;
	border-radius: 10px;
	padding: 20px;
	background-color: #f5f7fa;
}

.coupon-title {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 15px;
	color: #333;
	display: flex;
	align-items: center;
}

.coupon-title:before {
	content: '🎫';
	margin-right: 8px;
	font-size: 22px;
}

.coupon-container {
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
}

.coupon-item {
	position: relative;
	width: 300px; /* 너비 증가 */
	height: 140px; /* 높이 증가 */
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 0;
	display: flex;
	color: #333;
	box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	transition: transform 0.2s ease;
}

.coupon-item:hover {
	transform: translateY(-3px);
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
}

/* 쿠폰 왼쪽 부분 (컬러 영역) */
.coupon-left {
	width: 90px; /* 너비 증가 */
	background: #3a4cb4; /* 더 깊고 전문적인 파란색 */
	color: #fff;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	position: relative;
}

.coupon-left:after {
	content: '';
	position: absolute;
	right: -8px;
	top: 0;
	bottom: 0;
	width: 16px;
	background-image: radial-gradient(circle at 0 50%, transparent 8px, #fff 8px);
	background-size: 16px 16px;
	background-repeat: repeat-y;
}

.coupon-discount {
	font-size: 24px; /* 폰트 크기 증가 */
	font-weight: bold;
	margin-bottom: 5px;
	text-align: center;
	line-height: 1;
}

.coupon-unit {
	font-size: 14px;
	margin-top: 2px;
}

/* 쿠폰 오른쪽 부분 (내용 영역) */
.coupon-content {
	flex: 1;
	padding: 15px;
	padding-left: 20px;
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: space-between; /* 공간 균등 배분 */
	padding-bottom: 50px; /* 버튼을 위한 공간 확보 */
}

.coupon-info {
	margin-bottom: 5px; /* 텍스트 간격 조정 */
}

.coupon-name {
	font-size: 16px;
	font-weight: bold;
	margin-bottom: 8px; /* 간격 증가 */
	color: #333;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	max-width: 180px; /* 텍스트 길이 제한 */
}

.coupon-min-order {
	font-size: 13px; /* 폰트 크기 증가 */
	color: #666;
	margin-bottom: 6px; /* 간격 증가 */
}

.coupon-expire {
	font-size: 12px; /* 폰트 크기 증가 */
	color: #888;
	display: flex;
	align-items: center;
}

.coupon-expire:before {
	content: '⏱️';
	margin-right: 4px;
	font-size: 12px;
}

.coupon-download {
	position: absolute;
	bottom: 12px;
	right: 12px;
	background-color: #3a4cb4;
	border: none;
	border-radius: 4px;
	padding: 6px 12px; /* 패딩 증가 */
	font-size: 13px; /* 폰트 크기 증가 */
	font-weight: bold;
	color: #fff;
	cursor: pointer;
	transition: all 0.2s ease;
}

.coupon-download:hover {
	background-color: #2a3b9f;
}

.coupon-download[disabled] {
	background-color: #a0a9d8;
	cursor: not-allowed;
}

/* 다운로드 완료 쿠폰 스타일 */
.downloaded-coupon .coupon-left {
	background: #2e7d32; /* 더 진한 녹색 */
}

.downloaded-coupon .coupon-download {
	background-color: #2e7d32;
}

.downloaded-coupon:before {
	content: '✓';
	position: absolute;
	top: 10px;
	right: 10px;
	width: 20px;
	height: 20px;
	background: #fff;
	color: #2e7d32;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	font-weight: bold;
	font-size: 12px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	z-index: 2;
}

/* 만료된 쿠폰 스타일 */
.expired-coupon .coupon-left {
	background: #757575;
}

.expired-coupon .coupon-content {
	opacity: 0.7;
}

.no-coupon {
	text-align: center;
	color: #666;
	padding: 15px;
	background-color: #fff;
	border-radius: 8px;
	border: 1px dashed #ccc;
}

.login-button {
	display: inline-block;
	background-color: #3a4cb4;
	color: white;
	padding: 8px 15px;
	border-radius: 4px;
	text-decoration: none;
	margin-top: 10px;
	font-weight: bold;
	transition: background-color 0.2s ease;
}

.login-button:hover {
	background-color: #2a3b9f;
}
</style>
</head>
<body>

	<!-- 쿠폰 섹션 추가 -->
	<div class="coupon-section">
		<h2 class="coupon-title">사용 가능한 쿠폰</h2>

		<c:choose>
			<c:when test="${empty loginUser}">
				<div class="no-coupon">
					쿠폰 다운로드는 로그인 후 이용 가능합니다. <br> <a href="/user/loginForm"
						class="login-button">로그인하러 가기</a>
				</div>
			</c:when>
			<c:when test="${empty availableCoupons}">
				<div class="no-coupon">현재 사용 가능한 쿠폰이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<div class="coupon-container">
					<c:forEach var="coupon" items="${availableCoupons}">
						<div
							class="coupon-item ${coupon.ISDOWNLOADED == 1 ? 'downloaded-coupon' : ''}">
							<div class="coupon-left">
								<div class="coupon-discount">
									<fmt:formatNumber value="${coupon.SALE_PRICE}" pattern="#,###" />
								</div>
								<div class="coupon-unit">원</div>
							</div>
							<div class="coupon-content">
								<div class="coupon-info">
									<div class="coupon-name">${coupon.CP_NAME}</div>
									<div class="coupon-min-order">
										최소주문금액:
										<fmt:formatNumber value="${coupon.MINIMUM_PURCHASE}"
											pattern="#,###" />
										원
									</div>
									<div class="coupon-expire">
										<fmt:parseDate value="${coupon.EXPIRE_DATE}"
											pattern="yyyy-MM-dd" var="expireDate" />
										<fmt:formatDate value="${expireDate}"
											pattern="yyyy.MM.dd까지 사용 가능" />
									</div>
								</div>

								<c:choose>
									<c:when test="${coupon.ISDOWNLOADED == 1}">
										<button class="coupon-download" disabled>다운로드 완료</button>
									</c:when>
									<c:otherwise>
										<button class="coupon-download"
											data-coupon-id="${coupon.STORE_COUPON_ID}"
											data-coupon-name="${coupon.CP_NAME}"
											data-owner-id="${coupon.OWNER_COUPON_ID}"
											data-expire-date="${coupon.EXPIRE_DATE}"
											data-min-purchase="${coupon.MINIMUM_PURCHASE}"
											onclick="downloadCouponFromElement(this)">다운로드</button>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<h2>메뉴 목록</h2>

	<!-- 카테고리별 메뉴 표시 -->
	<c:forEach var="category" items="${categorizedMenus}">
		<div class="category-section">
			<h3 class="category-title">${category.value.categoryName}</h3>
			<div class="menu-container">
				<c:forEach var="menu" items="${category.value.menuItems}">
					<div class="menu-item"
						onclick="location.href='/userstore/menuDetail?menu_item_id=${menu.MENU_ITEM_ID}'"
						style="cursor: pointer;">
						<img
							src="${pageContext.request.contextPath}/upload/menuItemProfile/${menu.IMAGE_NAME}"
							alt="${menu.IMAGE_NAME}">
						<div class="menu-name">${menu.MENU_NAME}</div>
						<div class="menu-content">${menu.CONTENT}</div>
						<div class="menu-price">
							<fmt:formatNumber value="${menu.PRICE}" pattern="#,###" />
							원
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</c:forEach>

	<!-- 쿠폰 다운로드 스크립트 -->
	<script>
function downloadCouponFromElement(buttonElement) {
    const couponId = buttonElement.getAttribute('data-coupon-id');
    const couponName = buttonElement.getAttribute('data-coupon-name');
    const ownerCouponId = buttonElement.getAttribute('data-owner-id');
    const expireDate = buttonElement.getAttribute('data-expire-date');
    const minimumPurchase = buttonElement.getAttribute('data-min-purchase');
    
    // 일반 문자열 연결 방식으로 변경
    if(confirm('"' + couponName + '" 쿠폰을 다운로드하시겠습니까?')) {
        fetch('/user/downloadCoupon', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                storeCouponId: couponId,
                ownerCouponId: ownerCouponId,
                expireDate: expireDate,
                minimumPurchase: minimumPurchase
            })
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                // 일반 문자열 연결 방식으로 변경
                alert('"' + couponName + '" 쿠폰이 다운로드되었습니다.');
                window.location.reload();
            } else {
                alert(data.message || '쿠폰 다운로드에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('쿠폰 다운로드 중 오류가 발생했습니다.');
        });
    }
    }
    </script>
</body>
</html>