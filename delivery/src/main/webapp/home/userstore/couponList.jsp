<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 쿠폰함</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        .coupon-container {
            max-width: 500px;
            margin: 0 auto;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .coupon-header {
            background-color: #4CAF50;
            color: white;
            padding: 15px 20px;
            text-align: center;
            font-size: 1.2em;
            font-weight: bold;
        }
        .coupon-list {
            padding: 10px;
        }
        .coupon-item {
            background-color: #f9f9f9;
            border-radius: 10px;
            margin-bottom: 15px;
            padding: 15px;
            position: relative;
            border: 1px solid #e0e0e0;
        }
        .coupon-title {
            font-size: 1.1em;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        .coupon-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            color: #7f8c8d;
        }
        .coupon-status {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.8em;
            font-weight: bold;
        }
        .status-used {
            background-color: #bdc3c7;
            color: white;
        }
        .status-expired {
            background-color: #e74c3c;
            color: white;
        }
        .status-active {
            background-color: #2ecc71;
            color: white;
        }
        .coupon-details {
            display: flex;
            flex-direction: column;
        }
        .coupon-price {
            font-size: 1.2em;
            color: #4CAF50;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .no-coupons {
            text-align: center;
            color: #7f8c8d;
            padding: 20px;
            font-size: 1em;
        }
    </style>
</head>
<body>
    <div class="coupon-container">
        <div class="coupon-header">
            내 쿠폰함 (<span class="coupon-count">${fn:length(couponList)}장</span>)
        </div>
        <div class="coupon-list">
            <c:choose>
                <c:when test="${not empty couponList}">
                    <c:forEach var="coupon" items="${couponList}">
                        <div class="coupon-item">
                            <div class="coupon-title">${coupon.cpName}</div>
                            
                            <c:choose>
                                <c:when test="${coupon.status == 0}">
                                    <div class="coupon-status status-used">사용 완료</div>
                                </c:when>
                                <c:when test="${coupon.expireDate < currentDate}">
                                    <div class="coupon-status status-expired">기간 만료</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="coupon-status status-active">사용 가능</div>
                                </c:otherwise>
                            </c:choose>

                            <div class="coupon-details">
                                <div class="coupon-price">최소 구매 ${coupon.minimumPurchase}원 할인</div>
                                <div class="coupon-info">
                                    <span>다운로드: <fmt:formatDate value="${coupon.downloadDate}" pattern="yyyy-MM-dd"/></span>
                                    <span>만료: <fmt:formatDate value="${coupon.expireDate}" pattern="yyyy-MM-dd"/></span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-coupons">현재 사용 가능한 쿠폰이 없습니다.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>	