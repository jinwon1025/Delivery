<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .cart-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ff6b6b;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        .cart-header h1 {
            color: #333;
            margin: 0;
            font-size: 24px;
        }
        .cart-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        .cart-item-details {
            flex-grow: 1;
            margin-left: 15px;
        }
        .cart-item-name {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 5px;
        }
        .cart-item-options {
            color: #777;
            font-size: 14px;
        }
        .cart-item-price {
            font-weight: bold;
            color: #333;
        }
        .cart-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 2px solid #ff6b6b;
        }
        .cart-total-text {
            font-size: 18px;
            font-weight: bold;
        }
        .cart-total-price {
            font-size: 22px;
            color: #ff6b6b;
            font-weight: bold;
        }
        .cart-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .btn {
            display: inline-block;
            padding: 12px 25px;
            background-color: #ff6b6b;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #ff4757;
        }
        .option-item {
            margin-bottom: 3px;
        }
    </style>
</head>
<body>
<c:choose>
    <c:when test="${isEmptyCart == 'empty'}">
        <div class="cart-container">
            <div class="cart-header">
                <h1>장바구니</h1>
            </div>
            <div style="text-align: center; padding: 50px 0;">
                <h2>장바구니에 아무것도 없어요.</h2>
                <p>맛있는 음식을 장바구니에 담아보세요!</p>
                <a href="/user/categoryStores" class="btn">메뉴 보러가기</a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="cart-container">
            <div class="cart-header">
                <h1>장바구니</h1>
            </div>
            
            <c:forEach items="${cartDetails}" var="item">
                <div class="cart-item">
                    <div class="cart-item-details">
                        <div class="cart-item-name">${item.MENU_NAME}</div>
                        <div class="cart-item-options">
                            <c:if test="${not empty item.OPTION_NAMES}">
                                <c:set var="optionNames" value="${fn:split(item.OPTION_NAMES, ', ')}" />
                                <c:set var="optionPrices" value="${fn:split(item.OPTION_PRICES, ', ')}" />
                                
                                <c:forEach var="i" begin="0" end="${fn:length(optionNames) - 1}">
                                    <div class="option-item">
                                        ${optionNames[i]} (+<fmt:formatNumber value="${optionPrices[i]}" type="number"/>원)
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                    <div class="cart-item-price">
                        <fmt:formatNumber value="${item.MENU_PRICE + item.TOTAL_OPTION_PRICE}" type="number"/>원
                    </div>
                </div>
            </c:forEach>
            
            <div class="cart-total">
                <div class="cart-total-text">총 주문 금액</div>
                <div class="cart-total-price">
                    <c:set var="totalPrice" value="0"/>
                    <c:forEach items="${cartDetails}" var="item">
                        <c:set var="totalPrice" value="${totalPrice + item.MENU_PRICE + item.TOTAL_OPTION_PRICE}"/>
                    </c:forEach>
                    <fmt:formatNumber value="${totalPrice}" type="number"/>원
                </div>
            </div>
            
            <div class="cart-actions">
    <form action="/userstore/returnToStore" method="get">
        <input type="hidden" name="store_id" value="${cartDetails[0].STORE_ID}">
        <button type="submit" class="btn">메뉴 추가</button>
    </form>
    <form action="/order/proceed" method="get">
        <button type="submit" class="btn">주문하기</button>
    </form>
</div>
    </c:otherwise>
</c:choose>
</body>
</html>