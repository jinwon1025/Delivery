<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배달사이트</title>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 0;
}

.container {
	width: 90%;
	max-width: 1200px;
	margin: 20px auto;
}

.store-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr); /* 한 줄에 2개의 가게 배치 */
	gap: 15px;
}

.store-item {
	display: flex;
	padding: 15px;
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	position: relative;
	align-items: center;
	transition: all 0.2s ease;
	cursor: pointer;
}

.store-logo {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	margin-right: 15px;
	overflow: hidden;
	flex-shrink: 0;
	border: 2px solid #f0f0f0;
}

.store-logo img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.store-info {
	flex: 1;
	display: flex;
	flex-direction: column;
	min-width: 0; /* 텍스트 오버플로우 방지를 위한 설정 */
}

.store-name {
	font-weight: bold;
	font-size: 18px;
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	color: #333;
	letter-spacing: -0.5px;
}

.store-type {
	font-size: 12px;
	color: #777;
	margin-left: 5px;
	white-space: nowrap;
	background-color: #f0f0f0;
	padding: 2px 6px;
	border-radius: 10px;
	font-weight: normal;
}

.store-details {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 5px;
	width: 100%;
}

.min-order {
	color: #555;
	font-size: 14px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	flex: 1;
}

.min-order-label {
	color: #888;
	font-weight: 500;
}

.min-order-value {
	font-weight: 600;
	color: #333;
}

.delivery-time {
	color: #333;
	font-size: 14px;
	text-align: right;
	white-space: nowrap;
	margin-left: 10px;
	font-weight: bold;
	background-color: #f9f9f9;
	padding: 3px 8px;
	border-radius: 4px;
}

.coupon-tag {
	display: inline-block;
	background-color: #e74c3c;
	color: white;
	font-size: 12px;
	padding: 2px 6px;
	border-radius: 3px;
	margin-left: 5px;
	white-space: nowrap;
	font-weight: bold;
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}

.location {
	position: absolute;
	top: 15px;
	right: 50px; /* 즐겨찾기 버튼 왼쪽으로 이동 */
	color: #999;
	font-size: 13px;
	background-color: #f9f9f9;
	padding: 3px 8px;
	border-radius: 12px;
}

.btn-group {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
}

.edit-btn {
	display: block;
	width: 120px;
	padding: 12px;
	text-align: center;
	background-color: #ff6b6b;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	text-decoration: none;
	font-weight: bold;
	transition: all 0.2s ease;
}

.edit-btn:hover {
	background-color: #e74c3c;
	transform: translateY(-2px);
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.store-item:hover {
	background-color: #f8f9fa;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	transform: translateY(-2px);
}

.category-title {
	text-align: center;
	margin-bottom: 25px;
	color: #333;
	font-size: 28px;
	font-weight: bold;
	position: relative;
}

.category-title:after {
	content: '';
	display: block;
	width: 50px;
	height: 3px;
	background-color: #ff6b6b;
	margin: 10px auto 0;
}

.no-stores {
	text-align: center;
	padding: 50px 0;
	color: #666;
	font-size: 18px;
	background-color: white;
	border-radius: 8px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

/* 즐겨찾기 버튼 스타일 */
.favorite-btn {
    position: absolute;
    top: 10px;
    right: 15px; 
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
    padding: 5px;
    border-radius: 50%;
    z-index: 10;
    color: #ccc;
    transition: all 0.3s ease;
}

.favorite-btn:hover {
    transform: scale(1.1);
    color: #ffdd57;
}

.favorite-btn.active {
    color: #FFD700;
    text-shadow: 0 0 5px rgba(255, 215, 0, 0.5);
}

/* 반응형 디자인 */
@media ( max-width : 768px) {
	.store-grid {
		grid-template-columns: 1fr; /* 모바일에서는 한 줄에 하나만 */
	}
	
	.location {
	    right: 50px; /* 모바일에서 위치 조정 */
	}
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<div class="container">
		<h1 class="category-title">${categoryName}</h1>

		<c:choose>
			<c:when test="${not empty storeList}">
				<div class="store-grid">
					<c:forEach items="${storeList}" var="store" varStatus="status">
						<div class="store-item">
							<div class="store-logo">
								<c:choose>
									<c:when test="${not empty store.store_image_name}">
										<img
											src="${pageContext.request.contextPath}/upload/storeProfile/${store.store_image_name}"
											alt="${store.store_name}">
									</c:when>
									<c:otherwise>
										<img
											src="${pageContext.request.contextPath}/image/noStoreProfile.png"
											alt="기본 이미지">
									</c:otherwise>
								</c:choose>
							</div>
							<div class="store-info" onclick="goToStoreDetail('${store.store_id}')">
								<div class="store-name">
									${store.store_name} <span class="store-type">배달</span>
								</div>
								<div class="store-details">
									<div class="min-order">
										<span class="min-order-label">최소주문금액:</span> <span
											class="min-order-value">${store.last_price}원</span> 이상 배달
										<c:if test="${store.last_price > 12000}">
											<span class="coupon-tag">쿠폰할인</span>
										</c:if>
									</div>
									<div class="delivery-time">${empty store.delivery_time ? '20-30분' : store.delivery_time}
									</div>
								</div>
							</div>
							
							<div class="location">
								${empty store.store_address ? '지구' : store.store_address}
							</div>
							
							<!-- 즐겨찾기 버튼 - 가게 컨테이너 오른쪽 상단에 위치 -->
							<button class="favorite-btn" onclick="bookmarkStore(event, '${store.store_id}');">★</button>
						</div>
					</c:forEach>
				</div>
			</c:when>
			<c:otherwise>
				<div class="no-stores">해당 카테고리에 등록된 가게가 없습니다.</div>
			</c:otherwise>
		</c:choose>

		<div class="btn-group">
			<a href="<c:url value='/user/categoryStores'/>" class="edit-btn">전체보기</a>
			<a href="<c:url value='/user/index'/>" class="edit-btn">홈으로</a>
		</div>
	</div>

	<!-- 가게 상세 페이지로 이동하기 위한 숨겨진 폼 -->
	<form id="storeDetailForm" action="<c:url value='/userstore/detail'/>">
		<input type="hidden" id="store_id" name="store_id" value="">
	</form>

	<!-- 즐겨찾기 처리를 위한 숨겨진 폼 -->
	<form id="bookmarkForm" action="<c:url value='/userstore/bookmark'/>" method="post">
		<input type="hidden" id="bookmark_store_id" name="store_id" value="">
	</form>

	<script>
	function bookmarkStore(event, storeId) {
		event.stopPropagation(); // 이벤트 버블링 방지
		
		// 버튼 토글 효과 유지
		event.target.classList.toggle('active');
		
		// 폼의 store_id 값을 설정하고 제출
		document.getElementById('bookmark_store_id').value = storeId;
		document.getElementById('bookmarkForm').submit();
	}
	
	function goToStoreDetail(storeId) {
		// 폼의 store_id 값을 설정하고 제출
		document.getElementById('store_id').value = storeId;
		document.getElementById('storeDetailForm').submit();
	}
	</script>

</body>
</html>