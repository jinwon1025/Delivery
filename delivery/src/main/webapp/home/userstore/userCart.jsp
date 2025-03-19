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
:root {
    --primary-color: #FFD700;
    --primary-dark: #E6C200;
    --primary-light: #FFF8E1;
    --secondary-color: #333333;
    --accent-color: #FF3D00;
    --light-gray: #F7F7F7;
    --medium-gray: #E0E0E0;
    --dark-gray: #757575;
    --text-color: #212121;
    --white: #FFFFFF;
    --success-color: #00C853;
    --error-color: #FF3D00;
    --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 8px rgba(0, 0, 0, 0.1);
    --border-radius: 12px;
    --transition: all 0.3s ease;
    --header-height: 60px;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f8f8;
    color: var(--text-color);
    line-height: 1.6;
    margin: 0;
    padding: 0;
}

.cart-logo {
    width: 28px;
    height: 28px;
    margin-right: 10px;
}

.cart-container {
    max-width: 820px;
    margin: 20px auto;
    background-color: var(--white);
    border-radius: var(--border-radius);
    box-shadow: var(--shadow-md);
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

.cart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 25px;
    border-bottom: 1px solid var(--medium-gray);
    background-color: var(--white);
}

.cart-header h1 {
    color: var(--text-color);
    font-size: 22px;
    font-weight: 700;
    display: flex;
    align-items: center;
}

.cart-empty {
    padding: 60px 20px;
    text-align: center;
}

.cart-empty h2 {
    font-size: 20px;
    color: var(--text-color);
    margin-bottom: 12px;
}

.cart-empty p {
    color: var(--dark-gray);
    margin-bottom: 24px;
}

.select-all-container {
    display: flex;
    align-items: center;
    padding: 16px 25px;
    background-color: var(--white);
    border-bottom: 1px solid var(--medium-gray);
}

.select-all-checkbox {
    position: relative;
    width: 20px;
    height: 20px;
    margin-right: 10px;
    cursor: pointer;
    appearance: none;
    border: 2px solid var(--dark-gray);
    border-radius: 4px;
    transition: var(--transition);
}

.select-all-checkbox:checked {
    background-color: var(--primary-color);
    border-color: var(--primary-color);
}

.select-all-checkbox:checked::after {
    content: '';
    position: absolute;
    left: 6px;
    top: 2px;
    width: 5px;
    height: 10px;
    border: solid white;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
}

.select-all-label {
    font-weight: 500;
    font-size: 15px;
}

.cart-items-container {
    flex: 1;
    overflow-y: auto;
    max-height: calc(100vh - 350px);
    min-height: 200px;
}

.cart-item {
    display: flex;
    align-items: center;
    padding: 20px 25px;
    border-bottom: 1px solid var(--medium-gray);
    position: relative;
    transition: var(--transition);
}

.cart-item:hover {
    background-color: var(--primary-light);
}

.cart-checkbox {
    position: relative;
    width: 20px;
    height: 20px;
    margin-right: 15px;
    cursor: pointer;
    appearance: none;
    border: 2px solid var(--dark-gray);
    border-radius: 4px;
    transition: var(--transition);
    flex-shrink: 0;
}

.cart-checkbox:checked {
    background-color: var(--primary-color);
    border-color: var(--primary-color);
}

.cart-checkbox:checked::after {
    content: '';
    position: absolute;
    left: 6px;
    top: 2px;
    width: 5px;
    height: 10px;
    border: solid white;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
}

.menu-image {
    width: 70px;
    height: 70px;
    border-radius: 10px;
    object-fit: cover;
    margin-right: 15px;
    box-shadow: var(--shadow-sm);
    flex-shrink: 0;
}

.cart-item-details {
    flex-grow: 1;
    min-width: 0; /* Prevent flexbox items from overflowing */
    padding-right: 10px;
    align-self: center;
}

.cart-item-name {
    font-weight: 600;
    font-size: 16px;
    margin-bottom: 8px;
    color: var(--text-color);
}

.cart-item-options {
    color: var(--dark-gray);
    font-size: 14px;
    margin-bottom: 12px;
}

.option-item {
    margin-bottom: 4px;
    padding-left: 5px;
    display: block;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 13px;
}

.cart-item-actions {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    margin-left: 10px;
    flex-shrink: 0;
    width: 130px;
}

.cart-item-price {
    font-weight: 700;
    color: var(--text-color);
    margin-top: 8px;
    font-size: 17px;
}

.quantity-container {
    display: flex;
    align-items: center;
    margin: 10px 0;
    background-color: var(--light-gray);
    border-radius: 30px;
    padding: 2px;
    width: 100%;
    justify-content: space-between;
}

.quantity-btn {
    width: 34px;
    height: 34px;
    border: none;
    border-radius: 50%;
    font-size: 18px;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: var(--light-gray);
    color: var(--text-color);
    transition: var(--transition);
}

.quantity-btn:hover {
    background-color: var(--medium-gray);
}

.quantity-input {
    width: 40px;
    height: 34px;
    text-align: center;
    font-size: 15px;
    border: none;
    background-color: transparent;
    font-weight: 600;
    -webkit-appearance: none;
    -moz-appearance: textfield;
}

.quantity-input::-webkit-outer-spin-button,
.quantity-input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

.delete-btn {
    background-color: transparent;
    color: var(--dark-gray);
    border: none;
    border-radius: 4px;
    padding: 6px 12px;
    cursor: pointer;
    font-size: 13px;
    transition: var(--transition);
    margin-top: 10px;
}

.delete-btn:hover {
    color: var(--error-color);
}

.payment-summary {
    background-color: var(--white);
    padding: 20px 25px;
    border-top: 1px solid var(--medium-gray);
}

.payment-summary-title {
    font-size: 16px;
    font-weight: 700;
    margin-bottom: 15px;
    color: var(--text-color);
}

.payment-summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 12px;
    font-size: 14px;
}

.payment-summary-price {
    font-weight: 500;
}

.payment-summary-total {
    display: flex;
    justify-content: space-between;
    margin-top: 15px;
    padding-top: 15px;
    border-top: 1px solid var(--medium-gray);
    font-size: 18px;
    font-weight: 700;
}

.total-price {
    color: var(--accent-color);
}

.order-footer {
    background-color: var(--white);
    padding: 20px 25px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top: 1px solid var(--medium-gray);
}

.order-footer-right {
    display: flex;
    gap: 10px;
}

.btn {
    display: inline-block;
    padding: 13px 26px;
    font-size: 15px;
    font-weight: 600;
    text-align: center;
    text-decoration: none;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: var(--transition);
}

.btn-primary {
    background-color: var(--primary-color);
    color: var(--text-color);
    font-weight: 700;
}

.btn-primary:hover {
    background-color: var(--primary-dark);
}

.btn-outline {
    background-color: var(--white);
    color: var(--text-color);
    border: 1px solid var(--medium-gray);
}

.btn-outline:hover {
    background-color: var(--light-gray);
}

.btn-submit {
    background-color: var(--primary-color);
    color: var(--text-color);
    min-width: 120px;
    font-weight: 700;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.btn-submit:hover {
    background-color: var(--primary-dark);
    transform: translateY(-1px);
    box-shadow: 0 3px 7px rgba(0, 0, 0, 0.15);
}

@media (max-width: 768px) {
    .cart-container {
        margin: 0;
        border-radius: 0;
        height: 100vh;
        max-height: 100vh;
    }
    
    .cart-header, .select-all-container, .cart-item, .payment-summary, .order-footer {
        padding-left: 16px;
        padding-right: 16px;
    }
    
    .cart-items-container {
        max-height: calc(100vh - 300px);
    }
    
    .cart-item {
        display: grid;
        grid-template-columns: auto 1fr;
        grid-template-rows: auto auto;
        grid-template-areas: 
            "check image details"
            "check image actions";
        column-gap: 15px;
        align-items: center;
    }
    
    .cart-checkbox {
        grid-area: check;
        align-self: center;
        justify-self: center;
    }
    
    .menu-image {
        grid-area: image;
        width: 60px;
        height: 60px;
    }
    
    .cart-item-details {
        grid-area: details;
        padding-right: 0;
    }
    
    .cart-item-name {
        font-size: 15px;
        margin-bottom: 5px;
    }
    
    .cart-item-options {
        font-size: 13px;
        margin-bottom: 5px;
    }
    
    .cart-item-actions {
        grid-area: actions;
        width: 100%;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        margin-left: 0;
        margin-top: 5px;
    }
    
    .quantity-container {
        width: auto;
        margin: 0;
    }
    
    .cart-item-price {
        margin-top: 0;
    }
    
    .delete-btn {
        padding: 4px 8px;
        margin-top: 0;
    }
    
    .order-footer {
        flex-direction: column;
        gap: 15px;
    }
    
    .order-footer-right {
        width: 100%;
    }
    
    .btn {
        flex: 1;
    }
}

@media (max-width: 480px) {
    .cart-item {
        grid-template-columns: auto 1fr;
        grid-template-rows: auto auto auto;
        grid-template-areas: 
            "check image details"
            "check image details"
            ". actions actions";
        row-gap: 10px;
    }
    
    .cart-item-actions {
        width: 100%;
        margin-top: 10px;
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
					<h1>
                        <svg class="cart-logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#FFD700" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="9" cy="21" r="1"></circle>
                            <circle cx="20" cy="21" r="1"></circle>
                            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                        </svg>
                        장바구니
                    </h1>
				</div>
				<div class="cart-empty">
					<svg width="80" height="80" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="margin: 0 auto 20px; display: block; opacity: 0.5;">
                        <circle cx="9" cy="21" r="1" stroke="#757575" stroke-width="2"/>
                        <circle cx="20" cy="21" r="1" stroke="#757575" stroke-width="2"/>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6" stroke="#757575" stroke-width="2"/>
                    </svg>
					<h2>장바구니가 비어있어요</h2>
					<p>맛있는 음식을 장바구니에 담아보세요!</p>
					<a href="/user/categoryStores" class="btn btn-primary">메뉴 보러가기</a>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="cart-container">
				<div class="cart-header">
					<h1>
                        <svg class="cart-logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#FFD700" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="9" cy="21" r="1"></circle>
                            <circle cx="20" cy="21" r="1"></circle>
                            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                        </svg>
                        장바구니
                    </h1>
				</div>

				<div class="select-all-container">
					<input type="checkbox" id="selectAll" class="select-all-checkbox"
						onclick="selectAll(this)" checked> <label for="selectAll"
						class="select-all-label">전체 선택</label>
				</div>

                <div class="cart-items-container">
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
                </div>

				<!-- 결제 금액 요약 박스 추가 -->
				<div class="payment-summary">
					<div class="payment-summary-title">결제금액</div>
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
						
							<a href="/userstore/returnToStore?store_id=${cartDetails[0].STORE_ID}" class="btn btn-outline">메뉴 추가</a>
						<form action="/userStore/startOrder" method="get"
							onsubmit="return validateForm()">
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
							<button type="submit" class="btn btn-submit">주문하기</button>
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