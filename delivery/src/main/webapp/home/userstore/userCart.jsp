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
        .quantity-container {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 10px 0;
    }
    .quantity-input {
        width: 50px;
        height: 40px;
        text-align: center;
        font-size: 18px;
        border: 1px solid #ddd;
        border-radius: 4px;
        margin: 0 10px;
        -webkit-appearance: none;
        -moz-appearance: textfield;
    }
    .quantity-input::-webkit-outer-spin-button,
    .quantity-input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
    .quantity-btn {
        width: 40px;
        height: 40px;
        background-color: #f1f1f1;
        border: none;
        border-radius: 50%;
        font-size: 20px;
        cursor: pointer;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .quantity-btn:hover {
        background-color: #ddd;
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
                   data-quantity="${item.QUANTITY}"
                   checked
                   onchange="updateTotalPrice()">
            
            <img src="${pageContext.request.contextPath}/upload/menuItemProfile/${item.IMAGE_NAME}" 
                 alt="${item.MENU_NAME}" class="menu-image">
            
            <div class="cart-item-details">
                <div class="cart-item-name">${item.MENU_NAME}</div>
                <div class="cart-item-options">
                    <c:forEach items="${cartDetails}" var="option">
                        <c:if test="${option.MENU_ITEM_ID == item.MENU_ITEM_ID}">
                            <div class="option-item">
                                ${option.OPTION_NAMES}
                                <c:if test="${not empty option.OPTION_PRICES}">
                                    (+${option.OPTION_PRICES}원)
                                </c:if>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            
            <div class="cart-item-actions">
                <div class="quantity-container">
                    <button type="button" class="quantity-btn" onclick="decreaseQuantity(this)">-</button>
                    <input type="number" name="quantity" class="quantity-input" value="${empty item.QUANTITY ? 1 : item.QUANTITY}" min="1" max="10">
                    <button type="button" class="quantity-btn" onclick="increaseQuantity(this)">+</button>
                </div>
                
                <div class="cart-item-price">
                    <fmt:formatNumber value="${item.MENU_PRICE * (empty item.QUANTITY ? 1 : item.QUANTITY)}" type="number"/>원
                </div>
                
                <form action="/userstore/deleteItemInCart" method="post" 
                      onsubmit="return deleteCheck()">
                    <input type="hidden" name="menu_item_id" value="${item.MENU_ITEM_ID}"/>
                    <input type="hidden" name="order_id" value="${item.ORDER_ID}"/>
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
                            <c:set var="itemQuantity" value="${empty item.QUANTITY ? 1 : item.QUANTITY}"/>
                            <c:set var="totalPrice" value="${totalPrice + (item.MENU_PRICE * itemQuantity)}"/>
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
                            <input type="hidden" name="itemQuantities" value="${empty item.QUANTITY ? 1 : item.QUANTITY}" class="itemQuantities-hidden">
                        </c:if>
                    </c:forEach>
                    <button type="submit" class="btn">주문하기</button>
                </form>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<script>
//전체 선택 체크박스 동작 함수
//전체 선택 체크박스 동작 함수
function selectAll(source) {
    const checkboxes = document.getElementsByName('selectedItems');
    for (let i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = source.checked;
        
        // 체크박스 상태 변경 시 해당 아이템의 가격 정보도 갱신
        const cartItem = checkboxes[i].closest('.cart-item');
        const quantityInput = cartItem.querySelector('.quantity-input');
        const quantity = Number(quantityInput.value);
        const itemPrice = Number(checkboxes[i].getAttribute('data-price'));
        
        // 선택된 체크박스만 계산에 포함
        checkboxes[i].setAttribute('data-quantity', quantity);
    }
    
    // 모든 체크박스 상태 변경 후 총 가격 업데이트
    updateTotalPrice();
}//전체 선택 체크박스 동작 함수
function selectAll(source) {
    const checkboxes = document.getElementsByName('selectedItems');
    for (let i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = source.checked;
        
        // 체크박스 상태 변경 시 해당 아이템의 가격 정보도 갱신
        const cartItem = checkboxes[i].closest('.cart-item');
        const quantityInput = cartItem.querySelector('.quantity-input');
        const quantity = Number(quantityInput.value);
        const itemPrice = Number(checkboxes[i].getAttribute('data-price'));
        
        // 선택된 체크박스만 계산에 포함
        checkboxes[i].setAttribute('data-quantity', quantity);
    }
    
    // 모든 체크박스 상태 변경 후 총 가격 업데이트
    updateTotalPrice();
}

// 개별 체크박스 변경 시 전체선택 체크박스 상태 업데이트
function updateSelectAllCheckbox() {
    const checkboxes = document.getElementsByName('selectedItems');
    const selectAllCheckbox = document.getElementById('selectAll');
    
    let allChecked = true;
    for (let i = 0; i < checkboxes.length; i++) {
        if (!checkboxes[i].checked) {
            allChecked = false;
            break;
        }
    }
    
    selectAllCheckbox.checked = allChecked;
}

// 총 가격 업데이트 함수
function updateTotalPrice() {
    const checkboxes = document.getElementsByName('selectedItems');
    let totalPrice = 0;
    
    for (let i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            const cartItem = checkboxes[i].closest('.cart-item');
            const quantityInput = cartItem.querySelector('.quantity-input');
            
            const itemPrice = Number(checkboxes[i].getAttribute('data-price'));
            const quantity = Number(quantityInput.value);
            
            totalPrice += itemPrice * quantity;
        }
    }
    
    document.getElementById('totalPriceDisplay').innerText = totalPrice.toLocaleString() + '원';
    document.getElementById('hiddenTotalPrice').value = totalPrice;
    document.getElementById('orderTotalPrice').value = totalPrice;
    
    updateSelectedItemsHidden();
    // 체크박스 상태 변경 시 전체선택 체크박스도 업데이트
    updateSelectAllCheckbox();
}

// 주문에 포함할 숨겨진 input 필드 업데이트
function updateSelectedItemsHidden() {
    const checkboxes = document.getElementsByName('selectedItems');
    const hiddenInputs = document.getElementsByClassName('selectedItems-hidden');
    const quantityInputs = document.getElementsByClassName('itemQuantities-hidden');
    
    // 모든 hidden input을 초기에 비활성화
    for (let i = 0; i < hiddenInputs.length; i++) {
        hiddenInputs[i].disabled = true;
        if (quantityInputs[i]) {
            quantityInputs[i].disabled = true;
        }
    }
    
    // 체크된 체크박스에 해당하는 hidden input 활성화
    for (let i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            const cartItem = checkboxes[i].closest('.cart-item');
            const quantityInput = cartItem.querySelector('.quantity-input');
            
            for (let j = 0; j < hiddenInputs.length; j++) {
                if (hiddenInputs[j].value === checkboxes[i].value) {
                    hiddenInputs[j].disabled = false;
                    if (quantityInputs[j]) {
                        quantityInputs[j].disabled = false;
                        quantityInputs[j].value = quantityInput.value;
                    }
                    break;
                }
            }
        }
    }
}

// 주문 전 양식 유효성 검사
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

// 삭제 확인
function deleteCheck() {
    return confirm('선택한 메뉴를 장바구니에서 삭제하시겠습니까?');
}

// 수량 증가 함수
function increaseQuantity(button) {
    const quantityInput = button.parentElement.querySelector('.quantity-input');
    const currentValue = parseInt(quantityInput.value);
    if (currentValue < 10) {
        quantityInput.value = currentValue + 1;
        updateItemPrice(quantityInput);
    }
}

// 수량 감소 함수
function decreaseQuantity(button) {
    const quantityInput = button.parentElement.querySelector('.quantity-input');
    const currentValue = parseInt(quantityInput.value);
    if (currentValue > 1) {
        quantityInput.value = currentValue - 1;
        updateItemPrice(quantityInput);
    }
}

// 개별 아이템 가격 업데이트
function updateItemPrice(quantityInput) {
    const cartItem = quantityInput.closest('.cart-item');
    const checkbox = cartItem.querySelector('input[type="checkbox"]');
    
    // 숫자 형식으로 변환 보장
    const originalPrice = Number(checkbox.getAttribute('data-price'));
    const quantity = Number(quantityInput.value);
    
    const calculatedPrice = originalPrice * quantity;
    
    const priceElement = cartItem.querySelector('.cart-item-price');
    priceElement.textContent = calculatedPrice.toLocaleString() + '원';
    
    // 체크박스의 data-quantity 속성도 업데이트
    checkbox.setAttribute('data-quantity', quantity);
    
    updateTotalPrice();
}

// 페이지 로드 시 실행할 초기화 함수
window.onload = function() {
    // 개별 체크박스에 이벤트 리스너 추가
    const checkboxes = document.getElementsByName('selectedItems');
    for (let i = 0; i < checkboxes.length; i++) {
        checkboxes[i].addEventListener('change', updateTotalPrice);
    }
    
    // hidden 입력 필드 업데이트
    updateSelectedItemsHidden();
    
    // 초기 전체선택 체크박스 상태 업데이트
    updateSelectAllCheckbox();
    
    // 수량 입력 필드에 변경 이벤트 리스너 추가
    const quantityInputs = document.querySelectorAll('.quantity-input');
    for (let i = 0; i < quantityInputs.length; i++) {
        quantityInputs[i].addEventListener('change', function() {
            updateItemPrice(this);
        });
    }
}
</script>
</body>
</html>