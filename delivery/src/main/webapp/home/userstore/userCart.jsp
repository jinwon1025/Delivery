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
            align-items: flex-start;
            justify-content: space-between;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        .cart-checkbox {
            margin-right: 15px;
            transform: scale(1.2);
            margin-top: 5px;
        }
        .cart-item-details {
            flex-grow: 1;
            margin-left: 15px;
        }
        .cart-item-name {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 10px;
        }
        .cart-item-options {
            color: #777;
            font-size: 14px;
            margin-bottom: 5px;
        }
        .option-group {
            margin-bottom: 8px;
        }
        .cart-item-price {
            font-weight: bold;
            color: #333;
            margin-right: 15px;
            text-align: right;
        }
        .cart-item-actions {
            display: flex;
            align-items: center;
        }
        .delete-btn {
            background-color: #ff6b6b;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }
        .delete-btn:hover {
            background-color: #ff4757;
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
            border: none;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #ff4757;
        }
        .option-item {
            margin-bottom: 5px;
        }
        .select-all-container {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .select-all-checkbox {
            margin-right: 8px;
            transform: scale(1.2);
        }
        .select-all-label {
            font-weight: bold;
        }
        .menu-image {
            width: 80px;
            height: 80px;
            border-radius: 5px;
            object-fit: cover;
            margin-right: 15px;
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
            
            <div class="select-all-container">
                <input type="checkbox" id="selectAll" class="select-all-checkbox" onclick="selectAll(this)" checked>
                <label for="selectAll" class="select-all-label">전체 선택</label>
            </div>
            
            <%-- 메뉴 아이템 출력 --%>
            <c:forEach items="${cartDetails}" var="item" varStatus="status">
                <c:if test="${status.index == 0 || cartDetails[status.index-1].MENU_ITEM_ID != item.MENU_ITEM_ID}">
                    <div class="cart-item">
                        <input type="checkbox" name="selectedItems" class="cart-checkbox" 
                               value="${item.MENU_ITEM_ID}" 
                               data-price="${item.MENU_PRICE}"
                               checked
                               onchange="updateTotalPrice()">
                        
                        <img src="${pageContext.request.contextPath}/upload/menuItemProfile/${item.IMAGE_NAME}" alt="${item.MENU_NAME}" class="menu-image">
                        
                        <div class="cart-item-details">
                            <div class="cart-item-name">${item.MENU_NAME}</div>
                            <div class="cart-item-options">
                                <c:forEach items="${cartDetails}" var="option">
                                    <c:if test="${option.MENU_ITEM_ID == item.MENU_ITEM_ID}">
                                        <div class="option-item">
                                            ${option.OPTION_NAMES}
                                                (+<fmt:formatNumber value="${option.OPTION_PRICES}" type="number"/>원)
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <div class="cart-item-actions">
                            <div class="cart-item-price">
                                <fmt:formatNumber value="${item.MENU_PRICE}" type="number"/>원
                            </div>
                            <form action="/userstore/deleteItemInCart" method="post" 
                                  onsubmit="return deleteCheck()">
                                <input type="hidden" name="menu_item_id" value="${item.MENU_ITEM_ID}"/>
                                <input type="hidden" name="order_id" value="${item.ORDER_ID }"/>
                                <input type="submit" value="삭제" class="delete-btn"/>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
            
            <div class="cart-total">
                <div class="cart-total-text">총 주문 금액</div>
                <div class="cart-total-price">
                    <c:set var="totalPrice" value="0"/>
                    <c:set var="processedMenuItems" value=""/>
                    <c:forEach items="${cartDetails}" var="item">
                        <c:if test="${!fn:contains(processedMenuItems, item.MENU_ITEM_ID)}">
                            <c:set var="totalPrice" value="${totalPrice + item.MENU_PRICE}"/>
                            <c:set var="processedMenuItems" value="${processedMenuItems},${item.MENU_ITEM_ID}"/>
                        </c:if>
                    </c:forEach>
                    <span id="totalPriceDisplay"><fmt:formatNumber value="${totalPrice}" type="number"/>원</span>
                    <input type="hidden" id="hiddenTotalPrice" name="totalPrice" value="${totalPrice}">
                </div>
            </div>
            
            <div class="cart-actions">
                <a href="/userstore/returnToStore?store_id=${cartDetails[0].STORE_ID}" class="btn">메뉴 추가</a>
                <form action="/order/proceed" method="post" onsubmit="return validateForm()">
                    <input type="hidden" id="orderTotalPrice" name="totalPrice" value="${totalPrice}">
                    <c:forEach items="${cartDetails}" var="item" varStatus="status">
                        <c:if test="${status.index == 0 || cartDetails[status.index-1].MENU_ITEM_ID != item.MENU_ITEM_ID}">
                            <input type="hidden" name="selectedItems" value="${item.MENU_ITEM_ID}" class="selectedItems-hidden">
                        </c:if>
                    </c:forEach>
                    <button type="submit" class="btn">주문하기</button>
                </form>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<script>
    function selectAll(source) {
        const checkboxes = document.getElementsByName('selectedItems');
        for (let i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
        updateTotalPrice();
    }
    
    function updateTotalPrice() {
        const checkboxes = document.getElementsByName('selectedItems');
        let totalPrice = 0;
        
        for (let i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                const itemPrice = parseInt(checkboxes[i].getAttribute('data-price'));
                totalPrice += itemPrice;
            }
        }
        
        document.getElementById('totalPriceDisplay').innerText = totalPrice.toLocaleString() + '원';
        document.getElementById('hiddenTotalPrice').value = totalPrice;
        document.getElementById('orderTotalPrice').value = totalPrice;
        
        // 체크박스 상태에 따라 hidden input 업데이트
        updateSelectedItemsHidden();
    }
    
    function updateSelectedItemsHidden() {
        const checkboxes = document.getElementsByName('selectedItems');
        const hiddenInputs = document.getElementsByClassName('selectedItems-hidden');
        
        // 모든 hidden input을 초기에 비활성화
        for (let i = 0; i < hiddenInputs.length; i++) {
            hiddenInputs[i].disabled = true;
        }
        
        // 체크된 체크박스에 해당하는 hidden input 활성화
        for (let i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                for (let j = 0; j < hiddenInputs.length; j++) {
                    if (hiddenInputs[j].value === checkboxes[i].value) {
                        hiddenInputs[j].disabled = false;
                        break;
                    }
                }
            }
        }
    }

    function validateForm() {
        const checkboxes = document.getElementsByName('selectedItems');
        let atLeastOneChecked = false;
        
        for (let i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                atLeastOneChecked = true;
                break;
            }
        }
        
        if (!atLeastOneChecked) {
            alert('최소 하나 이상의 메뉴를 선택해주세요.');
            return false;
        }
        
        return true;
    }
    
    function deleteCheck() {
        return confirm('선택한 메뉴를 장바구니에서 삭제하시겠습니까?');
    }
    
    // 페이지 로드 시 hidden input 업데이트
    window.onload = function() {
        updateSelectedItemsHidden();
    };
</script>
</body>
</html>