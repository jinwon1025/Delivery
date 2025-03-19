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
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
	padding: 15px 0;
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
	white-space: nowrap !important;
	overflow: hidden !important;
	text-overflow: ellipsis !important;
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

.quantity-input::-webkit-outer-spin-button, .quantity-input::-webkit-inner-spin-button
	{
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
/* 결제 금액 요약 박스 스타일 */
.payment-summary {
	background-color: #f9f9f9;
	border-radius: 8px;
	padding: 20px;
	margin: 20px 0;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.payment-summary-title {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 15px;
	color: #333;
}

.payment-summary-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
	font-size: 15px;
}

.payment-summary-total {
	display: flex;
	justify-content: space-between;
	margin-top: 15px;
	padding-top: 15px;
	border-top: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
}

.payment-summary-price {
	text-align: right;
}

.discount-price {
	color: #2E86C1;
}

.total-price {
	color: #ff6b6b;
}
/* 하단 주문 정보 및 버튼 컨테이너 */
.order-footer {
	margin-top: 20px;
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

.order-footer-right {
	display: flex;
	gap: 10px;
}

@media ( max-width : 680px) {
	.order-footer {
		flex-direction: column;
		gap: 15px;
	}
	.order-footer-right {
		width: 100%;
		justify-content: space-between;
	}
	.order-footer-right .btn {
		flex: 1;
	}
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
					<a href="/user/categoryStores" class="btn" onclick="return checkLogin()">메뉴 보러가기</a>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="cart-container">
				<div class="cart-header">
					<h1>장바구니</h1>
				</div>

				<%-- 메뉴 아이템 출력 --%>
				<c:forEach items="${cartDetails}" var="item" varStatus="status">
					<c:if
						test="${status.index == 0 || cartDetails[status.index-1].MENU_ITEM_ID != item.MENU_ITEM_ID || cartDetails[status.index-1].ORDER_OPTION_ID != item.ORDER_OPTION_ID}">
						<div class="cart-item" data-menu-id="${item.MENU_ITEM_ID}" 
							data-price="${item.MENU_PRICE}" 
							data-option-price="${item.TOTAL_OPTION_PRICE}" 
							data-quantity="${item.QUANTITY}" 
							data-order-option-id="${item.ORDER_OPTION_ID}">
							
							<img src="${pageContext.request.contextPath}/upload/menuItemProfile/${item.IMAGE_NAME}"
								alt="${item.MENU_NAME}" class="menu-image">

							<div class="cart-item-details">
								<div class="cart-item-name">${item.MENU_NAME}</div>
								<div class="cart-item-options">
									<c:forEach items="${cartDetails}" var="option">
										<c:if
											test="${option.MENU_ITEM_ID == item.MENU_ITEM_ID && option.ORDER_OPTION_ID == item.ORDER_OPTION_ID}">
											<c:set var="optionNames"
												value="${fn:split(option.OPTION_NAMES, ', ')}" />
											<c:set var="optionPrices"
												value="${fn:split(option.OPTION_PRICES, ', ')}" />

											<c:forEach items="${optionNames}" var="name"
												varStatus="optStatus">
												<div class="option-item">
													${name}
													<c:if
														test="${not empty optionPrices[optStatus.index] && optionPrices[optStatus.index] != '0'}">
                    (+${optionPrices[optStatus.index]}원)
                </c:if>
													<c:if
														test="${empty optionPrices[optStatus.index] || optionPrices[optStatus.index] == '0'}">
                    (+0원)
                </c:if>
												</div>
											</c:forEach>
										</c:if>
									</c:forEach>
								</div>
							</div>

							<div class="cart-item-actions">
								<div class="quantity-container">
									<button type="button" class="quantity-btn"
										data-menu-id="${item.MENU_ITEM_ID}"
										data-option-id="${item.ORDER_OPTION_ID}"
										data-order-id="${item.ORDER_ID}"
										onclick="decreaseQuantity(this)">-</button>
									<input type="number" name="quantity" class="quantity-input"
										value="${empty item.QUANTITY ? 1 : item.QUANTITY}" min="1"
										max="10" data-menu-id="${item.MENU_ITEM_ID}"
										data-option-id="${item.ORDER_OPTION_ID}"
										data-order-id="${item.ORDER_ID}">
									<button type="button" class="quantity-btn"
										data-menu-id="${item.MENU_ITEM_ID}"
										data-option-id="${item.ORDER_OPTION_ID}"
										data-order-id="${item.ORDER_ID}"
										onclick="increaseQuantity(this)">+</button>
								</div>

								<div class="cart-item-price">
									<fmt:formatNumber
										value="${(item.MENU_PRICE + item.TOTAL_OPTION_PRICE) * (empty item.QUANTITY ? 1 : item.QUANTITY)}"
										type="number" />
									원
								</div>

								<form action="/userstore/deleteItemInCart" method="post"
									onsubmit="return deleteCheck()">
									<input type="hidden" name="menu_item_id"
										value="${item.MENU_ITEM_ID}" /> <input type="hidden"
										name="order_id" value="${item.ORDER_ID}" /> <input
										type="hidden" name="order_option_id"
										value="${item.ORDER_OPTION_ID}" /> <input type="submit"
										value="삭제" class="delete-btn" />
								</form>
							</div>
						</div>
					</c:if>
				</c:forEach>

				<!-- 결제 금액 요약 박스 추가 -->
				<div class="payment-summary">
					<div class="payment-summary-title">결제금액을 확인해주세요</div>
					<div class="payment-summary-row">
						<div>메뉴금액</div>
						<div class="payment-summary-price">
							<span id="menuPriceDisplay"> <c:set var="totalPrice"
									value="0" /> <c:set var="processedItems" value="" /> <c:forEach
									items="${cartDetails}" var="item">
									<c:set var="itemKey"
										value="${item.MENU_ITEM_ID}-${item.ORDER_OPTION_ID}" />
									<c:if test="${!fn:contains(processedItems, itemKey)}">
										<c:set var="itemQuantity"
											value="${empty item.QUANTITY ? 1 : item.QUANTITY}" />
										<c:set var="totalPrice"
											value="${totalPrice + ((item.MENU_PRICE + item.TOTAL_OPTION_PRICE) * itemQuantity)}" />
										<c:set var="processedItems"
											value="${processedItems},${itemKey}" />
									</c:if>
								</c:forEach> <fmt:formatNumber value="${totalPrice}" type="number" />원
							</span>
						</div>
					</div>
					<div class="payment-summary-row">
						<div>배달팁</div>
						<div class="payment-summary-price">
							<span id="deliveryFeeDisplay"> <fmt:formatNumber
									value="${deliveryFee}" type="number" />원
							</span>
						</div>
					</div>
					<div class="payment-summary-total">
						<div>결제예정금액</div>
						<div class="payment-summary-price total-price">
							<span id="finalTotalPriceDisplay"> <fmt:formatNumber
									value="${totalPrice + deliveryFee}" type="number" />원
							</span> <input type="hidden" id="hiddenFinalTotalPrice"
								name="finalTotalPrice" value="${totalPrice + deliveryFee}">
						</div>
					</div>
				</div>

				<!-- 하단 주문 정보 및 버튼  컨테이너 -->
				<div class="order-footer">
					<div class="order-footer-right">

						<a
							href="/userstore/returnToStore?store_id=${cartDetails[0].STORE_ID}"
							class="btn" onclick="return checkLogin()">메뉴 추가</a>
						<form action="/userStore/startOrder" method="get" onsubmit="return checkLogin()">
							<input type="hidden" id="orderTotalPrice" name="totalPrice"
								value="${totalPrice}"> <input type="hidden"
								id="orderDeliveryFee" name="deliveryFee" value="${deliveryFee}">
							<input type="hidden" id="orderFinalTotalPrice"
								name="finalTotalPrice" value="${totalPrice + deliveryFee}">
							<input type="hidden" id="order_Id" name="order_Id"
								value="${cartDetails[0].ORDER_ID}">
							<c:forEach items="${cartDetails}" var="item" varStatus="status">
								<c:if
									test="${status.index == 0 || cartDetails[status.index-1].MENU_ITEM_ID != item.MENU_ITEM_ID || cartDetails[status.index-1].ORDER_OPTION_ID != item.ORDER_OPTION_ID}">
									<input type="hidden" name="selectedItems"
										value="${item.MENU_ITEM_ID}">
									<input type="hidden" name="itemQuantities"
										value="${empty item.QUANTITY ? 1 : item.QUANTITY}">
									<input type="hidden" name="orderOptionIds"
										value="${item.ORDER_OPTION_ID}">
								</c:if>
							</c:forEach>
							<button type="submit" class="btn">주문하기</button>
						</form>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>

	<script>
	    // 로그인 상태를 확인하고 로그인 페이지로 리다이렉트하는 함수
        function checkLogin() {
            if (${loginUser == null}) {
                // 로그인되지 않은 경우
                alert('로그인이 필요한 서비스입니다.');
                window.location.href = '/user/loginForm';
                return false;
            }
            return true;
        }
    
	    // 숫자에 천 단위 쉼표 추가하는 함수
        function formatNumberWithCommas(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
		
		// 삭제 확인 함수
		function deleteCheck() {
			return confirm('선택한 메뉴를 장바구니에서 삭제하시겠습니까?'); // 삭제 전 확인 대화상자 표시
		}
		
		// 개별 아이템 가격 업데이트 함수
        function updateItemPrice(quantityInput) {
            const cartItem = quantityInput.closest('.cart-item'); // 현재 수량 입력 필드가 속한 아이템 요소 찾기
            
            // 숫자 형식으로 변환 보장
            const originalPrice = Number(cartItem.getAttribute('data-price')); // 아이템 단가 가져오기
            const optionPrice = Number(cartItem.getAttribute('data-option-price') || 0); // 옵션 가격 가져오기
            const quantity = Number(quantityInput.value); // 현재 수량 값 가져오기

            const calculatedPrice = (originalPrice + optionPrice) * quantity; // (단가 + 옵션가격) × 수량으로 계산된 가격

            const priceElement = cartItem.querySelector('.cart-item-price'); // 가격 표시 요소 찾기
            priceElement.textContent = formatNumberWithCommas(calculatedPrice) + '원'; // 계산된 가격 표시 (천 단위 구분자 포함)

            // 수량 데이터 속성 업데이트
            cartItem.setAttribute('data-quantity', quantity);
            
            // 모든 항목의 합계 업데이트
            updateTotalPrice();
        }
        
     // 서버에 장바구니 수량 업데이트 요청 보내는 함수
        function updateCartQuantity(menuItemId, quantity, orderId, orderOptionId) {
            // 로그인 상태 체크
            if (!checkLogin()) {
                return false;
            }
            
            console.log("AJAX 요청 준비:", { menuItemId, quantity, orderId, orderOptionId });
            
            // AJAX 요청
            fetch('/userstore/updateCartQuantity', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                    'menu_item_id': menuItemId,
                    'quantity': quantity,
                    'order_id': orderId,
                    'order_option_id': orderOptionId
                })
            })
            .then(response => {
                console.log("응답 상태:", response.status);
                
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('서버 응답 오류: ' + response.status);
                }
            })
            .then(data => {
                console.log("응답 데이터:", data);
                if (data.success) {
                    console.log("수량 업데이트 성공!");
                }
            })
            .catch(error => {
                console.error("AJAX 오류:", error);
            });
        }

    	// 수량 증가 함수
    	function increaseQuantity(button) {
            // 로그인 상태 체크
            if (!checkLogin()) {
                return false;
            }
            
            console.log("증가 버튼 클릭됨");
            
            // 버튼에서 직접 데이터 가져오기
            const menuItemId = button.getAttribute('data-menu-id');
            const orderOptionId = button.getAttribute('data-option-id');
            const orderId = button.getAttribute('data-order-id');
            
            if (!menuItemId || !orderOptionId || !orderId) {
                console.error("필수 데이터가 없습니다:", { menuItemId, orderOptionId, orderId });
                return false;
            }
            
            const quantityInput = button.parentElement.querySelector('.quantity-input');
            const currentValue = parseInt(quantityInput.value);
            
            if (currentValue < 10) {
                // 수량 증가
                quantityInput.value = currentValue + 1;
                const newQuantity = currentValue + 1;
                
                // UI 업데이트
                updateItemPrice(quantityInput);
                
                // AJAX 요청 전송
                updateCartQuantity(menuItemId, newQuantity, orderId, orderOptionId);
            }
            
            return false; // 기본 이벤트 방지
        }

    	// 수량 감소 함수
    	function decreaseQuantity(button) {
            // 로그인 상태 체크
            if (!checkLogin()) {
                return false;
            }
            
            console.log("감소 버튼 클릭됨");
            
            // 버튼에서 직접 데이터 가져오기
            const menuItemId = button.getAttribute('data-menu-id');
            const orderOptionId = button.getAttribute('data-option-id');
            const orderId = button.getAttribute('data-order-id');
            
            if (!menuItemId || !orderOptionId || !orderId) {
                console.error("필수 데이터가 없습니다:", { menuItemId, orderOptionId, orderId });
                return false;
            }
            
            const quantityInput = button.parentElement.querySelector('.quantity-input');
            const currentValue = parseInt(quantityInput.value);
            
            if (currentValue > 1) {
                // 수량 감소
                quantityInput.value = currentValue - 1;
                const newQuantity = currentValue - 1;
                
                // UI 업데이트
                updateItemPrice(quantityInput);
                
                // AJAX 요청 전송
                updateCartQuantity(menuItemId, newQuantity, orderId, orderOptionId);
            }
            
            return false; // 기본 이벤트 방지
        }
        
        // 수량 입력 필드 직접 변경 시 호출되는 함수
        function handleQuantityChange(input) {
            // 로그인 상태 체크
            if (!checkLogin()) {
                return false;
            }
            
            console.log("수량 직접 입력됨");
            
            // 입력값 범위 검증 (1~10)
            let value = parseInt(input.value);
            if (isNaN(value) || value < 1) {
                value = 1;
                input.value = 1;
            } else if (value > 10) {
                value = 10;
                input.value = 10;
            }
            
            // 데이터 가져오기
            const menuItemId = input.getAttribute('data-menu-id');
            const orderOptionId = input.getAttribute('data-option-id');
            const orderId = input.getAttribute('data-order-id');
            
            if (!menuItemId || !orderOptionId || !orderId) {
                console.error("필수 데이터가 없습니다:", { menuItemId, orderOptionId, orderId });
                return;
            }
            
            // UI 업데이트
            updateItemPrice(input);
            
            // AJAX 요청 전송
            updateCartQuantity(menuItemId, value, orderId, orderOptionId);
        }
        
        // 총 가격 업데이트 함수
        function updateTotalPrice() {
            const cartItems = document.querySelectorAll('.cart-item');
            let totalPrice = 0;
            
            cartItems.forEach(item => {
                const itemPrice = Number(item.getAttribute('data-price'));
                const optionPrice = Number(item.getAttribute('data-option-price') || 0);
                const quantity = Number(item.querySelector('.quantity-input').value);
                
                totalPrice += (itemPrice + optionPrice) * quantity;
            });
            
            // 배달팁 (고정값 또는 서버에서 받아온 값)
            const deliveryFee = Number(document.getElementById('orderDeliveryFee').value || 0);
            const finalTotalPrice = totalPrice + deliveryFee;
            
            // 화면의 가격 정보 업데이트
            document.getElementById('menuPriceDisplay').innerText = formatNumberWithCommas(totalPrice) + '원';
            document.getElementById('finalTotalPriceDisplay').innerText = formatNumberWithCommas(finalTotalPrice) + '원';
            
            // 숨겨진 입력 필드 업데이트
            document.getElementById('hiddenFinalTotalPrice').value = finalTotalPrice;
            document.getElementById('orderTotalPrice').value = totalPrice;
            document.getElementById('orderFinalTotalPrice').value = finalTotalPrice;
            
            // 수량 입력 필드 값 업데이트
            cartItems.forEach(item => {
                const menuId = item.getAttribute('data-menu-id');
                const optionId = item.getAttribute('data-order-option-id');
                const quantity = item.querySelector('.quantity-input').value;
                
                // 해당 메뉴 아이템의 수량 입력 필드 찾기
                const quantityInputs = document.querySelectorAll(`input[name="itemQuantities"]`);
                const menuInputs = document.querySelectorAll(`input[name="selectedItems"]`);
                const optionInputs = document.querySelectorAll(`input[name="orderOptionIds"]`);
                
                for (let i = 0; i < menuInputs.length; i++) {
                    if (menuInputs[i].value === menuId && optionInputs[i].value === optionId) {
                        quantityInputs[i].value = quantity;
                        break;
                    }
                }
            });
        }
    	
    	// 페이지 로드 시 초기화
    	document.addEventListener('DOMContentLoaded', function() {
    	    // 수량 입력 필드에 change 이벤트 리스너 추가
    	    const quantityInputs = document.querySelectorAll('.quantity-input');
    	    quantityInputs.forEach(input => {
    	        input.addEventListener('change', function() {
    	            handleQuantityChange(this);
    	        });
    	    });
    	    
    	    // 초기 총 가격 계산
    	    updateTotalPrice();
    	    
    	    // 로그인 상태 확인
    	    if (${loginUser == null}) {
    	        console.log("사용자가 로그인하지 않았습니다.");
    	    } else {
    	        console.log("사용자가 로그인되어 있습니다.");
    	    }
    	});
    </script>
</body>
</html>