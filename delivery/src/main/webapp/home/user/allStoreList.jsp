<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배달 사이트</title>
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
    grid-template-columns: repeat(1, 1fr);
    gap: 10px;
}

.store-item {
    display: flex;
    padding: 15px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    position: relative;
    align-items: center;
}

.store-logo {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    margin-right: 15px;
    overflow: hidden;
    flex-shrink: 0;
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
}

.store-name {
    font-weight: bold;
    font-size: 16px;
    margin-bottom: 8px;
    display: flex;
    align-items: center;
}

.store-type {
    font-size: 12px;
    color: #777;
    margin-left: 5px;
}

.store-details {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 5px;
}

.min-order {
    color: #666;
    font-size: 14px;
}

.delivery-time {
    color: #666;
    font-size: 14px;
    text-align: right;
}

.coupon-tag {
    display: inline-block;
    background-color: #e74c3c;
    color: white;
    font-size: 12px;
    padding: 2px 6px;
    border-radius: 3px;
    margin-left: 5px;
}

.location {
    position: absolute;
    top: 15px;
    right: 15px;
    color: #999;
    font-size: 13px;
}

.btn-group {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 20px;
}

.edit-btn {
    display: block;
    width: 100px;
    padding: 10px;
    text-align: center;
    background-color: #ff6b6b;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    text-decoration: none;
}

.edit-btn:hover {
    background-color: #e74c3c;
}
</style>
</head>
<body>

<div class="container">
    <div class="store-grid">
        <c:forEach items="${StoreList}" var="store" varStatus="status">
            <div class="store-item">
                <div class="store-logo">
                    <c:choose>
                        <c:when test="${not empty store.store_image_name}">
                            <img src="${pageContext.request.contextPath}/upload/storeProfile/${store.store_image_name}" alt="${store.store_name}">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/images/default-store.png" alt="기본 이미지">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="store-info">
                    <div class="store-name">
                        ${store.store_name}
                        <span class="store-type">배달</span>
                    </div>
                    <div class="store-details">
                        <div class="min-order">
                            최소주문금액: ${store.last_price}원 이상 배달
                            <c:if test="${status.index % 2 == 0}">
                                <span class="coupon-tag">쿠폰할인</span>
                            </c:if>
                        </div>
                        <div class="delivery-time">
                            20-30분
                        </div>
                    </div>
                </div>
                <div class="location">
                    지구
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="btn-group">
        <a href="<c:url value='/store/list'/>" class="edit-btn">전체보기</a>
        <a href="<c:url value='/user/index'/>" class="edit-btn">홈으로</a>
    </div>
</div>

</body>
</html>