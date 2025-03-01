<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            padding-left: 10px;
            display: block;
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
<!-- 장바구니가 비어있는지 여부에 따라 다른 내용 표시 -->
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
    <c:if test="${status.index == 0 || cartDetails[status.index-1].MENU_ITEM_ID != item.MENU_ITEM_ID || cartDetails[status.index-1].ORDER_OPTION_ID != item.ORDER_OPTION_ID}">
        <div class="cart-item">
            <input type="checkbox" name="selectedItems" class="cart-checkbox" 
                   value="${item.MENU_ITEM_ID}"
                   data-price="${item.MENU_PRICE}"
                   data-quantity="${item.QUANTITY}"
                   data-order-option-id="${item.ORDER_OPTION_ID}"
                   checked
                   onchange="updateTotalPrice()">
            
            <img src="${pageContext.request.contextPath}/upload/menuItemProfile/${item.IMAGE_NAME}"
                 alt="${item.MENU_NAME}" class="menu-image">
            
            <div class="cart-item-details">
                <div class="cart-item-name">${item.MENU_NAME}</div>
                <div class="cart-item-options">
                    <c:forEach items="${cartDetails}" var="option">
                        <c:if test="${option.MENU_ITEM_ID == item.MENU_ITEM_ID && option.ORDER_OPTION_ID == item.ORDER_OPTION_ID}">
                            <c:set var="optionNames" value="${fn:split(option.OPTION_NAMES, ', ')}" />
                            <c:set var="optionPrices" value="${fn:split(option.OPTION_PRICES, ', ')}" />
                            
                            <c:forEach items="${optionNames}" var="name" varStatus="optStatus">
                                <div class="option-item">
                                    ${name}
                                    <c:if test="${not empty optionPrices[optStatus.index]}">
                                        (+${optionPrices[optStatus.index]}원)
                                    </c:if>
                                </div>
                            </c:forEach>
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
                    <input type="hidden" name="order_option_id" value="${item.ORDER_OPTION_ID}"/>
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
                    <c:set var="processedItems" value=""/>
                    <c:forEach items="${cartDetails}" var="item">
                        <c:set var="itemKey" value="${item.MENU_ITEM_ID}-${item.ORDER_OPTION_ID}"/>
                        <c:if test="${!fn:contains(processedItems, itemKey)}">
                            <c:set var="itemQuantity" value="${empty item.QUANTITY ? 1 : item.QUANTITY}"/>
                            <c:set var="totalPrice" value="${totalPrice + (item.MENU_PRICE * itemQuantity)}"/>
                            <c:set var="processedItems" value="${processedItems},${itemKey}"/>
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
                        <c:if test="${status.index == 0 || cartDetails[status.index-1].MENU_ITEM_ID != item.MENU_ITEM_ID || cartDetails[status.index-1].ORDER_OPTION_ID != item.ORDER_OPTION_ID}">
                            <input type="hidden" name="selectedItems" value="${item.MENU_ITEM_ID}" class="selectedItems-hidden">
                            <input type="hidden" name="itemQuantities" value="${empty item.QUANTITY ? 1 : item.QUANTITY}" class="itemQuantities-hidden">
                            <input type="hidden" name="orderOptionIds" value="${item.ORDER_OPTION_ID}" class="orderOptionIds-hidden">
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
function selectAll(source) {
    const checkboxes = document.getElementsByName('selectedItems'); // 모든 아이템 체크박스 가져오기
    for (let i = 0; i < checkboxes.length; i++) { // 모든 체크박스 순회
        checkboxes[i].checked = source.checked; // 전체 선택 체크박스 상태에 따라 개별 체크박스 상태 변경
        
        // 체크박스 상태 변경 시 해당 아이템의 가격 정보도 갱신
        const cartItem = checkboxes[i].closest('.cart-item'); // 현재 체크박스가 속한 아이템 요소 찾기
        const quantityInput = cartItem.querySelector('.quantity-input'); // 수량 입력 필드 찾기
        const quantity = Number(quantityInput.value); // 현재 수량 값 가져오기
        const itemPrice = Number(checkboxes[i].getAttribute('data-price')); // 아이템 단가 가져오기
        
        // 선택된 체크박스만 계산에 포함하기 위해 data-quantity 속성 업데이트
        checkboxes[i].setAttribute('data-quantity', quantity);
    }
    
    // 모든 체크박스 상태 변경 후 총 가격 업데이트
    updateTotalPrice();
}

// 개별 체크박스 변경 시 전체선택 체크박스 상태 업데이트 함수
function updateSelectAllCheckbox() {
    const checkboxes = document.getElementsByName('selectedItems'); // 모든 아이템 체크박스 가져오기
    const selectAllCheckbox = document.getElementById('selectAll'); // 전체 선택 체크박스 요소 가져오기
    
    let allChecked = true; // 모든 체크박스가 선택되었는지 추적하는 플래그
    for (let i = 0; i < checkboxes.length; i++) { // 모든 체크박스 순회
        if (!checkboxes[i].checked) { // 선택되지 않은 체크박스가 있으면
            allChecked = false; // 플래그 false로 설정
            break; // 반복 중단
        }
    }
    
    selectAllCheckbox.checked = allChecked; // 모든 체크박스 상태에 따라 전체 선택 체크박스 상태 설정
}

// 총 가격 업데이트 함수
function updateTotalPrice() {
    const checkboxes = document.getElementsByName('selectedItems'); // 모든 아이템 체크박스 가져오기
    let totalPrice = 0; // 총 가격 변수 초기화
    
    for (let i = 0; i < checkboxes.length; i++) { // 모든 체크박스 순회
        if (checkboxes[i].checked) { // 선택된 체크박스만 처리
            const cartItem = checkboxes[i].closest('.cart-item'); // 현재 체크박스가 속한 아이템 요소 찾기
            const quantityInput = cartItem.querySelector('.quantity-input'); // 수량 입력 필드 찾기
            
            const itemPrice = Number(checkboxes[i].getAttribute('data-price')); // 아이템 단가 가져오기
            const quantity = Number(quantityInput.value); // 현재 수량 값 가져오기
            
            totalPrice += itemPrice * quantity; // 단가 × 수량을 총 가격에 더하기
        }
    }
    
    document.getElementById('totalPriceDisplay').innerText = totalPrice.toLocaleString() + '원'; // 화면에 총 가격 표시 (천 단위 구분자 포함)
    document.getElementById('hiddenTotalPrice').value = totalPrice; // 숨겨진 총 가격 입력 필드 업데이트
    document.getElementById('orderTotalPrice').value = totalPrice; // 주문 총 가격 입력 필드 업데이트
    updateSelectedItemsHidden(); // 선택된 아이템에 대한 숨겨진 입력 필드 업데이트
    // 체크박스 상태 변경 시 전체선택 체크박스도 업데이트
    updateSelectAllCheckbox(); // 전체 선택 체크박스 상태 업데이트
}

// 주문에 포함할 숨겨진 input 필드 업데이트 함수
function updateSelectedItemsHidden() {
    const checkboxes = document.getElementsByName('selectedItems'); // 모든 아이템 체크박스 가져오기
    const hiddenInputs = document.getElementsByClassName('selectedItems-hidden'); // 메뉴 아이템 ID에 대한 숨겨진 입력 필드들 가져오기
    const quantityInputs = document.getElementsByClassName('itemQuantities-hidden'); // 수량에 대한 숨겨진 입력 필드들 가져오기
    const orderOptionInputs = document.getElementsByClassName('orderOptionIds-hidden'); // 주문 옵션 ID에 대한 숨겨진 입력 필드들 가져오기
    
    // 모든 hidden input을 초기에 비활성화 - 선택되지 않은 아이템은 제출되지 않도록 함
    for (let i = 0; i < hiddenInputs.length; i++) {
        hiddenInputs[i].disabled = true; // 메뉴 아이템 ID 입력 필드 비활성화
        if (quantityInputs[i]) {
            quantityInputs[i].disabled = true; // 수량 입력 필드 비활성화
        }
        if (orderOptionInputs[i]) {
            orderOptionInputs[i].disabled = true; // 주문 옵션 ID 입력 필드 비활성화
        }
    }
    
    // 체크된 체크박스에 해당하는 hidden input 활성화 - 선택된 아이템만 제출
    for (let i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) { // 선택된 체크박스만 처리
            const cartItem = checkboxes[i].closest('.cart-item'); // 현재 체크박스가 속한 아이템 요소 찾기
            const quantityInput = cartItem.querySelector('.quantity-input'); // 수량 입력 필드 찾기
            const orderOptionId = checkboxes[i].getAttribute('data-order-option-id'); // 주문 옵션 ID 가져오기
            
            for (let j = 0; j < hiddenInputs.length; j++) {
                if (hiddenInputs[j].value === checkboxes[i].value && 
                    orderOptionInputs[j].value === orderOptionId) { // 체크박스 값과 주문 옵션 ID가 일치하는지 확인
                    hiddenInputs[j].disabled = false; // 해당 메뉴 아이템 ID 입력 필드 활성화
                    if (quantityInputs[j]) {
                        quantityInputs[j].disabled = false; // 해당 수량 입력 필드 활성화
                        quantityInputs[j].value = quantityInput.value; // 현재 화면에 표시된 수량 값으로 업데이트
                    }
                    if (orderOptionInputs[j]) {
                        orderOptionInputs[j].disabled = false; // 해당 주문 옵션 ID 입력 필드 활성화
                    }
                    break; // 일치하는 항목을 찾았으면 내부 반복 중단
                }
            }
        }
    }
}

// 주문 전 양식 유효성 검사 함수
function validateForm() {
    const checkboxes = document.getElementsByName('selectedItems'); // 모든 아이템 체크박스 가져오기
    let atLeastOneChecked = false; // 최소 하나 이상 선택되었는지 추적하는 플래그
    
    for (let i = 0; i < checkboxes.length; i++) { // 모든 체크박스 순회
        if (checkboxes[i].checked) { // 선택된 체크박스가 있으면
            atLeastOneChecked = true; // 플래그 true로 설정
            break; // 반복 중단
        }
    }
    
    if (!atLeastOneChecked) { // 선택된 항목이 없으면
        alert('최소 하나 이상의 메뉴를 선택해주세요.'); // 경고 메시지 표시
        return false; // 폼 제출 취소
    }
    
    return true; // 유효한 경우 폼 제출 허용
}

// 삭제 확인 함수
function deleteCheck() {
    return confirm('선택한 메뉴를 장바구니에서 삭제하시겠습니까?'); // 삭제 전 확인 대화상자 표시
}

// 수량 증가 함수
function increaseQuantity(button) {
    const quantityInput = button.parentElement.querySelector('.quantity-input'); // 수량 입력 필드 찾기
    const currentValue = parseInt(quantityInput.value); // 현재 수량 값을 정수로 변환
    if (currentValue < 10) { // 최대값(10)보다 작은 경우에만 증가
        quantityInput.value = currentValue + 1; // 수량 증가
        updateItemPrice(quantityInput); // 아이템 가격 업데이트
    }
}

// 수량 감소 함수
function decreaseQuantity(button) {
    const quantityInput = button.parentElement.querySelector('.quantity-input'); // 수량 입력 필드 찾기
    const currentValue = parseInt(quantityInput.value); // 현재 수량 값을 정수로 변환
    if (currentValue > 1) { // 최소값(1)보다 큰 경우에만 감소
        quantityInput.value = currentValue - 1; // 수량 감소
        updateItemPrice(quantityInput); // 아이템 가격 업데이트
    }
}

// 개별 아이템 가격 업데이트 함수
function updateItemPrice(quantityInput) {
    const cartItem = quantityInput.closest('.cart-item'); // 현재 수량 입력 필드가 속한 아이템 요소 찾기
    const checkbox = cartItem.querySelector('input[type="checkbox"]'); // 체크박스 요소 찾기
    
    // 숫자 형식으로 변환 보장
    const originalPrice = Number(checkbox.getAttribute('data-price')); // 아이템 단가 가져오기
    const quantity = Number(quantityInput.value); // 현재 수량 값 가져오기
    
    const calculatedPrice = originalPrice * quantity; // 단가 × 수량으로 계산된 가격
    
    const priceElement = cartItem.querySelector('.cart-item-price'); // 가격 표시 요소 찾기
    priceElement.textContent = calculatedPrice.toLocaleString() + '원'; // 계산된 가격 표시 (천 단위 구분자 포함)
    
    // 체크박스의 data-quantity 속성도 업데이트
    checkbox.setAttribute('data-quantity', quantity); // 수량 데이터 속성 업데이트
    
    updateTotalPrice(); // 총 가격 업데이트
}

// 페이지 로드 시 실행할 초기화 함수
window.onload = function() {
    // 개별 체크박스에 이벤트 리스너 추가
    const checkboxes = document.getElementsByName('selectedItems'); // 모든 아이템 체크박스 가져오기
    for (let i = 0; i < checkboxes.length; i++) { // 모든 체크박스 순회
        checkboxes[i].addEventListener('change', updateTotalPrice); // 체크박스 변경 시 총 가격 업데이트 함수 호출
    }
    
    // hidden 입력 필드 업데이트
    updateSelectedItemsHidden(); // 선택된 아이템에 대한 숨겨진 입력 필드 초기화
    
    // 초기 전체선택 체크박스 상태 업데이트
    updateSelectAllCheckbox(); // 전체 선택 체크박스 상태 초기화
    
    // 수량 입력 필드에 변경 이벤트 리스너 추가
    const quantityInputs = document.querySelectorAll('.quantity-input'); // 모든 수량 입력 필드 가져오기
    for (let i = 0; i < quantityInputs.length; i++) { // 모든 수량 입력 필드 순회
        quantityInputs[i].addEventListener('change', function() { // 수량 변경 시 실행할 이벤트 리스너 추가
            updateItemPrice(this); // 아이템 가격 업데이트 함수 호출
        });
    }
}
</script>
</body>
</html>