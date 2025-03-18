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

/* 쿠폰 관련 스타일 */
.coupon-section {
    margin-bottom: 30px;
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    padding: 20px;
    background-color: #f9f9f9;
}
.coupon-title {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #333;
}
.coupon-container {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
}
.coupon-item {
    position: relative;
    width: 280px;
    height: 120px;
    background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
    border-radius: 10px;
    padding: 15px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    transition: transform 0.2s ease;
}

.coupon-item:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}

.coupon-item::before {
    content: '';
    position: absolute;
    left: -5px;
    top: 50%;
    transform: translateY(-50%);
    width: 10px;
    height: 20px;
    background-color: #f9f9f9;
    border-radius: 0 50% 50% 0;
}
.coupon-item::after {
    content: '';
    position: absolute;
    right: -5px;
    top: 50%;
    transform: translateY(-50%);
    width: 10px;
    height: 20px;
    background-color: #f9f9f9;
    border-radius: 50% 0 0 50%;
}
.coupon-name {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 8px;
}
.coupon-price {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 8px;
}
.coupon-min-order {
    font-size: 13px;
    opacity: 0.9;
}
.coupon-download {
    position: absolute;
    bottom: 15px;
    right: 15px;
    background-color: rgba(255, 255, 255, 0.4);
    border: none;
    border-radius: 20px;
    padding: 6px 12px;
    font-size: 13px;
    font-weight: bold;
    color: #fff;
    cursor: pointer;
    transition: all 0.2s ease;
}
.coupon-download:hover {
    background-color: rgba(255, 255, 255, 0.6);
}

.coupon-download[disabled] {
    background-color: rgba(255, 255, 255, 0.3);
    color: rgba(255, 255, 255, 0.7);
    cursor: not-allowed;
}

.expired-coupon {
    background: linear-gradient(135deg, #a9a9a9 0%, #d3d3d3 100%);
}
.downloaded-coupon {
    background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    border: 2px solid #007bff;
    position: relative;
}

.downloaded-coupon::before {
    content: '✓';
    position: absolute;
    top: 10px;
    right: 10px;
    width: 24px;
    height: 24px;
    background: #fff;
    color: #4facfe;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: bold;
    font-size: 14px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.coupon-expire {
    font-size: 12px;
    margin-top: 3px;
    opacity: 0.9;
}
.no-coupon {
    text-align: center;
    color: #666;
    padding: 15px;
    background-color: #fff;
    border-radius: 8px;
    border: 1px dashed #ccc;
}
</style>
</head>
<body>

<!-- 쿠폰 섹션 추가 -->
<div class="coupon-section">
    <h2 class="coupon-title">사용 가능한 쿠폰</h2>
    
    <c:if test="${empty availableCoupons}">
        <div class="no-coupon">
            현재 사용 가능한 쿠폰이 없습니다.
        </div>
    </c:if>
    
    <c:if test="${not empty availableCoupons}">
        <div class="coupon-container">
            <c:forEach var="coupon" items="${availableCoupons}">
                <div class="coupon-item ${coupon.ISDOWNLOADED == 1 ? 'downloaded-coupon' : ''}">
                    <div class="coupon-name">${coupon.CP_NAME}</div>
                    <div class="coupon-price">₩<fmt:formatNumber value="${coupon.SALE_PRICE}" pattern="#,###" /></div>
                    <div class="coupon-min-order">최소주문금액: ₩<fmt:formatNumber value="${coupon.MINIMUM_PURCHASE}" pattern="#,###" /></div>
                    <div class="coupon-expire">
                        <fmt:parseDate value="${coupon.EXPIRE_DATE}" pattern="yyyy-MM-dd" var="expireDate" />
                        <fmt:formatDate value="${expireDate}" pattern="yyyy년 MM월 dd일까지" />
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
            </c:forEach>
        </div>
    </c:if>
</div>

<h2>메뉴 목록</h2>
<div class="menu-container">
    <c:forEach var="menu" items="${menuList}">
        <div class="menu-item" onclick="location.href='/userstore/menuDetail?menu_item_id=${menu.menu_item_id}'" style="cursor: pointer;">
            <img src="${pageContext.request.contextPath}/upload/menuItemProfile/${menu.image_name}" alt="${menu.image_name}">
            <div class="menu-name">${menu.menu_name}</div>
            <div class="menu-content">${menu.content}</div>
            <div class="menu-price">${menu.price}원</div>
        </div>
    </c:forEach>
</div>

<!-- 쿠폰 다운로드 스크립트 -->
<script>
function downloadCouponFromElement(buttonElement) {
    const couponId = buttonElement.getAttribute('data-coupon-id');
    const couponName = buttonElement.getAttribute('data-coupon-name');
    const ownerCouponId = buttonElement.getAttribute('data-owner-id');
    const expireDate = buttonElement.getAttribute('data-expire-date');
    const minimumPurchase = buttonElement.getAttribute('data-min-purchase');
    
    if(confirm(`쿠폰을 다운로드하시겠습니까?`)) {
        // AJAX를 통한 쿠폰 다운로드 요청
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
                alert('쿠폰이 다운로드되었습니다.');
                // 페이지 새로고침하여 변경된 상태 반영
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