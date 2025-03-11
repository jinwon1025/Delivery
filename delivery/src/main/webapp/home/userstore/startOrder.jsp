<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문하기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/static/user/user-pages.css'/>">
<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Noto Sans KR', sans-serif;
    }
    
    body {
        background-color: #f5f5f5;
        color: #333;
        line-height: 1.6;
    }
    
    .container {
        max-width: 768px;
        margin: 0 auto;
        padding: 15px;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        margin-bottom: 15px;
    }
    
    .order-header {
        text-align: center;
        font-size: 1.5rem;
        font-weight: bold;
        margin: 20px 0;
        padding-bottom: 10px;
        border-bottom: 1px solid #eee;
    }
    
    .section-title {
        font-size: 1.2rem;
        font-weight: bold;
        margin-bottom: 15px;
        color: #333;
        display: flex;
        align-items: center;
    }
    
    .section-title i {
        margin-right: 8px;
        color: #fa0050; /* 배달의민족 느낌의 분홍색 */
    }
    
    .input-group {
        margin-bottom: 15px;
    }
    
    label {
        display: block;
        margin-bottom: 5px;
        font-weight: 500;
    }
    
    input[type="text"],
    input[type="tel"],
    textarea,
    select {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 16px;
    }
    
    input[readonly] {
        background-color: #f5f5f5;
        color: #555;
    }
    
    textarea {
        height: 80px;
        resize: none;
    }
    
    .coupon-select {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .coupon-value {
        font-weight: bold;
        color: #fa0050;
    }
    
    .point-container {
        display: flex;
        align-items: center;
        margin-top: 15px;
    }
    
    .point-input {
        flex-grow: 1;
        margin-right: 10px;
    }
    
    .point-btn {
        background-color: #fa0050;
        color: white;
        border: none;
        padding: 12px 15px;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
    }
    
    .total-container {
        background-color: #f9f9f9;
    }
    
    .price-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    
    .price-title {
        color: #666;
    }
    
    .price-value {
        font-weight: bold;
    }
    
    .total-price {
        margin-top: 15px;
        padding-top: 15px;
        border-top: 1px solid #ddd;
        display: flex;
        justify-content: space-between;
        font-size: 1.2rem;
    }
    
    .total-price-value {
        color: #fa0050;
        font-weight: bold;
    }
    
    .order-btn {
        display: block;
        width: 100%;
        background-color: #fa0050;
        color: white;
        border: none;
        padding: 15px;
        font-size: 1.1rem;
        font-weight: bold;
        border-radius: 5px;
        margin-top: 20px;
        cursor: pointer;
    }
    
    .available-point {
        font-size: 0.9rem;
        color: #666;
        margin-top: 5px;
    }
    
    /* 결제 타입 선택 스타일 */
    .payment-type-selector {
        display: flex;
        border-bottom: 1px solid #ddd;
        margin-bottom: 15px;
    }
    
    .payment-type {
        flex: 1;
        text-align: center;
        padding: 12px;
        cursor: pointer;
        font-weight: 500;
        color: #666;
        position: relative;
        transition: all 0.2s;
    }
    
    .payment-type.selected {
        color: #fa0050;
        font-weight: bold;
    }
    
    .payment-type.selected:after {
        content: '';
        position: absolute;
        bottom: -1px;
        left: 0;
        width: 100%;
        height: 2px;
        background-color: #fa0050;
    }
    
    .payment-type i {
        margin-right: 5px;
    }
    
    /* 결제 섹션 스타일 */
    .payment-section {
        display: none;
        padding: 10px 0;
    }
    
    .payment-section.active {
        display: block;
    }
    
    /* 만나서 결제 정보 스타일 */
    .cash-payment-info {
        padding: 15px;
        background-color: #f9f9f9;
        border-radius: 8px;
        text-align: center;
    }
    
    .cash-payment-info i {
        font-size: 24px;
        color: #666;
        margin-bottom: 10px;
    }
    
    .cash-notice {
        font-size: 0.9rem;
        color: #fa0050;
        margin-top: 10px;
    }
    
    /* 비어있는 카드 컨테이너 스타일 */
    .empty-card-container {
        text-align: center;
        padding: 20px;
    }
    
    .empty-card-icon {
        font-size: 30px;
        color: #ddd;
        margin-bottom: 10px;
    }
    
    /* 카드 추가 버튼 스타일 */
    .add-new-card {
        text-align: center;
        padding: 12px;
        border: 1px dashed #ddd;
        border-radius: 8px;
        color: #666;
        cursor: pointer;
        transition: all 0.2s;
        margin-top: 15px;
    }
    
    .add-new-card:hover {
        background-color: #f9f9f9;
        color: #fa0050;
    }
    
    .add-new-card a {
        display: block;
        color: inherit;
        text-decoration: none;
    }
    
    /* 카드 슬라이더 스타일 수정 - viewPay와 일치하도록 */

	/* 카드 슬라이더 컨테이너 */
	.card-slider-container {
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    position: relative;
	    width: 100%;
	    padding: 20px 0;
	}
	
	/* 카드 슬라이더 */
	.card-slider {
	    width: 70%;
	    overflow: hidden;
	    position: relative;
	}
	
	/* 카드 슬라이드 */
	.payment-card-slide {
	    display: none;
	    flex-direction: column;
	    align-items: center;
	    transition: transform 0.3s ease;
	}
	
	.payment-card-slide.active {
	    display: flex;
	}
	
	/* 카드 스타일 - viewPay와 동일하게 */
	.payment-card {
	    width: 320px;
	    height: 200px;
	    border-radius: 12px;
	    padding: 20px;
	    position: relative;
	    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	    margin-bottom: 15px;
	    display: flex;
	    flex-direction: column;
	    background: linear-gradient(135deg, #1e88e5, #1565c0);
	    color: white;
	}
	
	/* 카드 칩 스타일 */
	.card-chip {
	    width: 40px;
	    height: 30px;
	    background: linear-gradient(135deg, #fdd835, #f9a825);
	    border-radius: 5px;
	    margin-bottom: 20px;
	    position: relative;
	    overflow: hidden;
	}
	
	.card-chip:before {
	    content: "";
	    position: absolute;
	    left: 50%;
	    top: 50%;
	    width: 60%;
	    height: 80%;
	    transform: translate(-50%, -50%);
	    background: linear-gradient(90deg, transparent 33%, rgba(255, 255, 255, 0.3) 35%, transparent 37%);
	}
	
	/* 카드 정보 스타일 */
	.card-info {
	    flex-grow: 1;
	}
	
	.card-label {
	    font-size: 0.7rem;
	    opacity: 0.8;
	    margin-bottom: 3px;
	}
	
	.card-name {
	    font-size: 1.2rem;
	    font-weight: bold;
	    margin-bottom: 15px;
	}
	
	.card-number {
	    font-size: 1rem;
	    letter-spacing: 2px;
	    margin-bottom: 15px;
	}
	
	.card-details {
	    display: flex;
	    justify-content: space-between;
	    font-size: 0.8rem;
	}
	
	/* 화살표 스타일 */
	.slider-arrow {
	    background-color: #f8f9fa;
	    width: 40px;
	    height: 40px;
	    border-radius: 50%;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    cursor: pointer;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	    transition: all 0.2s;
	    margin: 0 15px;
	}
	
	.slider-arrow:hover {
	    background-color: #e9ecef;
	}
	
	/* 인디케이터 스타일 */
	.card-indicator {
	    display: flex;
	    justify-content: center;
	    margin-top: 20px;
	}
	
	.indicator-dot {
	    width: 8px;
	    height: 8px;
	    border-radius: 50%;
	    background-color: #ced4da;
	    margin: 0 5px;
	    cursor: pointer;
	    transition: background-color 0.3s;
	}
	
	.indicator-dot.active {
	    background-color: #fa0050;
	}
	
	/* 카드 액션 버튼 스타일 */
	.card-actions {
	    display: flex;
	    justify-content: center;
	    width: 100%;
	}
</style>
</head>
<body>
    <h1 class="order-header">주문하기</h1>
    
    <!-- 전체 폼으로 페이지 감싸기 -->
    <form id="orderForm" action="/userstore/pay" method="post">
        <!-- 숨겨진 필드들 -->
        <input type="hidden" id="riderRequestHidden" name="riderRequest" value="">
        <input type="hidden" id="storeRequestHidden" name="storeRequest" value=""> 
        <input type="hidden" id="order_Id" name="order_Id" value="${order_Id}">
        <input type="hidden" id="paymentMethodHidden" name="paymentMethod" value="card">
        <input type="hidden" id="couponValueHidden" name="couponValue" value="0">
        <input type="hidden" id="selectedCouponIdHidden" name="selectedCouponId" value="0">
        <input type="hidden" id="pointValueHidden" name="pointValue" value="0">
        <input type="hidden" id="finalTotalHidden" name="finalTotal" value="${totalPrice + deliveryFee}">
        <input type="hidden" id="menuPriceHidden" value="${totalPrice}">
        <input type="hidden" id="deliveryFeeHidden" value="${deliveryFee}">
        
        <!-- 배달주소, 라이더 요청사항, 내 연락처 컨테이너 -->
        <div class="container">
            <div class="section-title">
                <i class="fas fa-map-marker-alt"></i> 배달정보
            </div>
            
            <div class="input-group">
                <label for="fullAddress">배달주소</label>
                <input type="text" id="fullAddress" name="address" value="${userInfo.user_address}" readonly>
            </div>
            
            <div class="input-group">
                <label for="riderRequest">라이더 요청사항</label>
                <select id="riderRequest">
                    <option value="">요청사항을 선택해주세요</option>
                    <option value="문 앞에 놓아주세요">문 앞에 놓아주세요</option>
                    <option value="직접 받겠습니다">직접 받겠습니다</option>
                    <option value="경비실에 맡겨주세요">경비실에 맡겨주세요</option>
                    <option value="배달 전 연락 부탁드립니다">배달 전 연락 부탁드립니다</option>
                    <option value="direct">직접 입력</option>
                </select>
                <textarea id="riderRequestDirect" placeholder="요청사항을 직접 입력해주세요" style="display: none;"></textarea>
            </div>
        </div>
        
        <!-- 내 연락처 컨테이너 -->
        <div class="container">
            <div class="section-title">
                <i class="fas fa-phone-alt"></i> 내 연락처
            </div>
            
            <div class="input-group">
                <label for="phone">연락처</label>
                <input type="tel" id="phone" name="phone" value="${userInfo.user_phone}">
            </div>
        </div>
        
        <!-- 가게 요청사항 컨테이너 -->
        <div class="container">
            <div class="section-title">
                <i class="fas fa-store"></i> 가게 요청사항
            </div>
            
            <div class="input-group">
                <label for="storeRequest">요청사항</label>
                <select id="storeRequest">
                    <option value="">요청사항을 선택해주세요</option>
                    <option value="맵게 해주세요">맵게 해주세요</option>
                    <option value="덜 맵게 해주세요">덜 맵게 해주세요</option>
                    <option value="양념 많이 주세요">양념 많이 주세요</option>
                    <option value="빨리 부탁드립니다">빨리 부탁드립니다</option>
                    <option value="direct">직접 입력</option>
                </select>
                <textarea id="storeRequestDirect" placeholder="요청사항을 직접 입력해주세요" style="display: none;"></textarea>
            </div>
        </div>
        
        <!-- 결제수단 컨테이너 -->
        <div class="container">
            <div class="section-title">
                <i class="fas fa-credit-card"></i> 결제수단
            </div>
            
            <div class="payment-methods-container">
                <!-- 결제 방식 선택 타입 -->
                <div class="payment-type-selector">
                    <div class="payment-type selected" data-type="card">
                        <i class="fas fa-credit-card"></i> 내 카드결제
                    </div>
                    <div class="payment-type" data-type="cash">
                        <i class="fas fa-money-bill-wave"></i> 만나서결제
                    </div>
                </div>
                
                <!-- 내 카드 목록 -->
                <div id="cardPaymentSection" class="payment-section active">
                    <c:choose>
                        <c:when test="${not empty cardList}">
                            <div class="card-slider-container">
                                <!-- 왼쪽 화살표 -->
                                <div class="slider-arrow prev-arrow" id="prevCard">
                                    <i class="fas fa-chevron-left"></i>
                                </div>
                                
                                <!-- 카드 슬라이더 -->
                                <div class="card-slider">
                                    <c:forEach var="card" items="${cardList}" varStatus="status">
                                        <div class="payment-card-slide" data-index="${status.index}" data-payment="card-${card.pay_id}">
                                            <div class="payment-card">
                                                <div class="card-icon">
                                                    <i class="fas fa-credit-card"></i>
                                                </div>
                                                <div class="card-info">
                                                    <div class="card-name">${card.card_type}</div>
                                                    <div class="card-number">**** **** **** ${card.card_number.substring(card.card_number.length() - 4)}</div>
                                                </div>
                                                <div class="card-check">
                                                    <i class="fas fa-check-circle"></i>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                
                                <!-- 오른쪽 화살표 -->
                                <div class="slider-arrow next-arrow" id="nextCard">
                                    <i class="fas fa-chevron-right"></i>
                                </div>
                            </div>
                            
                            <!-- 카드 인디케이터 -->
                            <div class="card-indicator">
                                <c:forEach var="card" items="${cardList}" varStatus="status">
                                    <span class="indicator-dot" data-index="${status.index}"></span>
                                </c:forEach>
                            </div>
                            
                            <!-- 새 카드 추가하기 버튼 -->
                            <div class="add-new-card">
                                <a href="/user/payRegister">
                                    <i class="fas fa-plus-circle"></i> 새 카드 추가하기
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-card-container">
                                <div class="empty-card-icon">
                                    <i class="fas fa-credit-card"></i>
                                </div>
                                <p class="text-muted">등록된 카드가 없습니다.</p>
                                <a href="/user/payRegister" class="btn btn-primary mt-3">
                                    <i class="fas fa-plus-circle"></i> 카드 등록하기
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- 만나서 결제 섹션 -->
                <div id="cashPaymentSection" class="payment-section">
                    <div class="cash-payment-info">
                        <i class="fas fa-info-circle"></i>
                        <p>라이더에게 현금으로 직접 결제합니다.</p>
                        <p class="cash-notice">* 만나서결제 시 쿠폰 및 포인트 사용이 제한될 수 있습니다.</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 할인쿠폰, 포인트 컨테이너 -->
        <div class="container">
            <div class="section-title">
                <i class="fas fa-tags"></i> 할인 및 포인트
            </div>
            
            <div class="input-group">
                <label for="coupon">할인쿠폰</label>
                <div class="coupon-select">
                    <select id="coupon">
                        <option value="0">사용 가능한 쿠폰 (${userCoupons.size()}개)</option>
                        <c:forEach var="coupon" items="${userCoupons}">
                            <option value="${coupon.STORE_COUPON_ID}" 
                                    data-discount="${coupon.SALE_PRICE}" 
                                    data-min-order="${coupon.MINIMUM_PURCHASE}" 
                                    data-name="${coupon.CP_NAME}">
                                ${coupon.CP_NAME} (<fmt:formatNumber value="${coupon.SALE_PRICE}" pattern="#,###"/>원 할인, 최소주문 <fmt:formatNumber value="${coupon.MINIMUM_PURCHASE}" pattern="#,###"/>원)
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            
            <div class="input-group">
                <label for="point">포인트</label>
                <div class="point-container">
                    <input type="text" id="point" class="point-input" placeholder="사용할 포인트를 입력하세요" value="">
                    <button type="button" class="point-btn">전액사용</button>
                </div>
                <div class="available-point">사용 가능 포인트: ${userInfo.point}P</div>
            </div>
        </div>
        
        <!-- 결제금액 컨테이너 -->
        <div class="container total-container">
            <div class="section-title">
                <i class="fas fa-calculator"></i> 결제금액
            </div>
            
            <div class="price-row">
                <span class="price-title">메뉴 금액</span>
                <span class="price-value" id="menuPriceDisplay"></span>
            </div>
            
            <div class="price-row">
                <span class="price-title">배달팁</span>
                <span class="price-value" id="deliveryFeeDisplay"></span>
            </div>
            
            <div class="price-row">
                <span class="price-title">할인쿠폰</span>
                <span class="price-value" id="couponDisplay">-0원</span>
            </div>
            
            <div class="price-row">
                <span class="price-title">포인트 사용</span>
                <span class="price-value" id="pointDisplay">-0원</span>
            </div>
            
            <div class="total-price">
                <span class="total-price-title">총 결제금액</span>
                <span class="total-price-value" id="totalDisplay"></span>
            </div>
        </div>
        
        <button type="submit" class="order-btn" id="orderButton">결제하기</button>
    </form>
    
    <script>
// JSP 변수를 JavaScript 변수로 직접 할당
const totalPrice = ${totalPrice};
const deliveryFee = ${deliveryFee};

// 페이지 로드 직후 실행
document.addEventListener('DOMContentLoaded', function() {
    // 메뉴 가격과 배달팁 표시 업데이트
    document.getElementById('menuPriceDisplay').textContent = totalPrice.toLocaleString() + '원';
    document.getElementById('deliveryFeeDisplay').textContent = deliveryFee.toLocaleString() + '원';
    document.getElementById('totalDisplay').textContent = (totalPrice + deliveryFee).toLocaleString() + '원';
    
    // 카드 슬라이더 초기화
    initCardSlider();
    
    // 라이더 요청사항 직접 입력 토글 설정
    setupRequestHandlers();
    
    // 결제 타입 선택 설정
    setupPaymentTypeHandlers();
    
    // 쿠폰 및 포인트 핸들러 설정
    setupDiscountHandlers();
});

// 라이더 및 가게 요청사항 핸들러 설정
function setupRequestHandlers() {
    // 라이더 요청사항 직접 입력 토글
    document.getElementById('riderRequest').addEventListener('change', function() {
        const directInput = document.getElementById('riderRequestDirect');
        if (this.value === 'direct') {
            directInput.style.display = 'block';
            document.getElementById('riderRequestHidden').value = '';
        } else {
            directInput.style.display = 'none';
            document.getElementById('riderRequestHidden').value = this.value;
        }
    });
    
    // 라이더 요청사항 직접 입력 처리
    document.getElementById('riderRequestDirect').addEventListener('input', function() {
        document.getElementById('riderRequestHidden').value = this.value;
    });
    
    // 가게 요청사항 직접 입력 토글
    document.getElementById('storeRequest').addEventListener('change', function() {
        const directInput = document.getElementById('storeRequestDirect');
        if (this.value === 'direct') {
            directInput.style.display = 'block';
            document.getElementById('storeRequestHidden').value = '';
        } else {
            directInput.style.display = 'none';
            document.getElementById('storeRequestHidden').value = this.value;
        }
    });
    
    // 가게 요청사항 직접 입력 처리
    document.getElementById('storeRequestDirect').addEventListener('input', function() {
        document.getElementById('storeRequestHidden').value = this.value;
    });
}

// 결제 타입 선택 핸들러 설정
function setupPaymentTypeHandlers() {
    const paymentTypes = document.querySelectorAll('.payment-type');
    const cardSection = document.getElementById('cardPaymentSection');
    const cashSection = document.getElementById('cashPaymentSection');
    
    // 결제 타입 변경 이벤트
    paymentTypes.forEach(type => {
        type.addEventListener('click', function() {
            paymentTypes.forEach(t => t.classList.remove('selected'));
            this.classList.add('selected');
            
            const selectedType = this.getAttribute('data-type');
            
            if (selectedType === 'card') {
                cardSection.classList.add('active');
                cashSection.classList.remove('active');
                
                // 카드 결제 선택 시 현재 선택된 카드의 payment 값 가져오기
                const activeSlide = document.querySelector('.payment-card-slide.active');
                if (activeSlide) {
                    document.getElementById('paymentMethodHidden').value = activeSlide.getAttribute('data-payment');
                } else {
                    document.getElementById('paymentMethodHidden').value = 'card';
                }
            } else {
                cardSection.classList.remove('active');
                cashSection.classList.add('active');
                document.getElementById('paymentMethodHidden').value = 'cash';
            }
        });
    });
}

// 할인 핸들러 설정 (쿠폰, 포인트)
function setupDiscountHandlers() {
    // 쿠폰 선택시 금액 변경 및 최소 주문금액 체크
    document.getElementById('coupon').addEventListener('change', function() {
        const selectedOption = this.options[this.selectedIndex];
        
        if (this.value === "0") {
            // 쿠폰 선택 안함
            document.getElementById('couponDisplay').textContent = '-0원';
            document.getElementById('couponValueHidden').value = 0;
            document.getElementById('selectedCouponIdHidden').value = 0;
            updateTotalPrice();
            return;
        }
        
        const couponId = this.value;
        const discountAmount = parseInt(selectedOption.getAttribute('data-discount'));
        const minOrderAmount = parseInt(selectedOption.getAttribute('data-min-order'));
        const couponName = selectedOption.getAttribute('data-name');
        
        // 최소 주문금액 체크
        if (totalPrice < minOrderAmount) {
            alert(`'${couponName}' 쿠폰은 ${minOrderAmount.toLocaleString()}원 이상 주문 시 사용 가능합니다.`);
            this.value = "0"; // 쿠폰 선택 초기화
            document.getElementById('couponDisplay').textContent = '-0원';
            document.getElementById('couponValueHidden').value = 0;
            document.getElementById('selectedCouponIdHidden').value = 0;
        } else {
            // 쿠폰 적용
            document.getElementById('couponDisplay').textContent = '-' + discountAmount.toLocaleString() + '원';
            document.getElementById('couponValueHidden').value = discountAmount;
            document.getElementById('selectedCouponIdHidden').value = couponId;
        }
        
        updateTotalPrice();
    });
    
    // 포인트 입력시 금액 변경
    document.getElementById('point').addEventListener('input', function() {
        const pointValue = this.value ? parseInt(this.value) : 0;
        const availablePointText = document.querySelector('.available-point').textContent;
        const availablePoint = parseInt(availablePointText.match(/\d+/)[0]);
        
        // 사용 가능 포인트 초과 체크
        if (pointValue > availablePoint) {
            alert(`사용 가능한 포인트를 초과했습니다. 최대 ${availablePoint.toLocaleString()}P까지 사용 가능합니다.`);
            this.value = availablePoint;
            document.getElementById('pointDisplay').textContent = '-' + availablePoint.toLocaleString() + '원';
            document.getElementById('pointValueHidden').value = availablePoint;
        } else {
            // 포인트 사용 금액 표시 업데이트
            const pointDisplay = document.getElementById('pointDisplay');
            pointDisplay.textContent = '-' + pointValue.toLocaleString() + '원';
            
            // 포인트 값 hidden 필드에 저장
            document.getElementById('pointValueHidden').value = pointValue;
        }
        
        updateTotalPrice();
    });
    
    // 전액사용 버튼
    document.querySelector('.point-btn').addEventListener('click', function() {
        // 사용 가능 포인트 가져오기
        const availablePointText = document.querySelector('.available-point').textContent;
        const availablePoint = parseInt(availablePointText.match(/\d+/)[0]);
        
        document.getElementById('point').value = availablePoint;
        
        // 포인트 사용 금액 표시 업데이트
        const pointDisplay = document.getElementById('pointDisplay');
        pointDisplay.textContent = '-' + availablePoint.toLocaleString() + '원';
        
        // 포인트 값 hidden 필드에 저장
        document.getElementById('pointValueHidden').value = availablePoint;
        
        updateTotalPrice();
    });
    
    // 폼 제출 전 최종 확인
    document.getElementById('orderForm').addEventListener('submit', function(event) {
        const couponSelect = document.getElementById('coupon');
        
        if (couponSelect.value !== "0") {
            const selectedOption = couponSelect.options[couponSelect.selectedIndex];
            const minOrderAmount = parseInt(selectedOption.getAttribute('data-min-order'));
            
            if (totalPrice < minOrderAmount) {
                event.preventDefault();
                alert(`선택한 쿠폰은 ${minOrderAmount.toLocaleString()}원 이상 주문 시 사용 가능합니다.`);
                couponSelect.value = "0";
                document.getElementById('couponDisplay').textContent = '-0원';
                document.getElementById('couponValueHidden').value = 0;
                document.getElementById('selectedCouponIdHidden').value = 0;
                updateTotalPrice();
            }
        }
    });
}

// 총 결제금액 업데이트
function updateTotalPrice() {
    const couponValue = document.getElementById('couponValueHidden').value ? parseInt(document.getElementById('couponValueHidden').value) : 0;
    const pointValue = document.getElementById('pointValueHidden').value ? parseInt(document.getElementById('pointValueHidden').value) : 0;
    
    // 최종 계산된 금액
    const finalTotal = totalPrice + deliveryFee - couponValue - pointValue;
    
    // 총 결제금액 업데이트
    const totalDisplay = document.getElementById('totalDisplay');
    totalDisplay.textContent = finalTotal.toLocaleString() + '원';
         
    // 최종 금액 hidden 필드에 저장
    document.getElementById('finalTotalHidden').value = finalTotal;
}

// 카드 슬라이더 초기화 함수
function initCardSlider() {
    const slides = document.querySelectorAll('.payment-card-slide');
    const dots = document.querySelectorAll('.indicator-dot');
    const prevBtn = document.getElementById('prevCard');
    const nextBtn = document.getElementById('nextCard');
    let currentIndex = 0;
    
    // 초기 상태 설정 - 첫 번째 슬라이드와 인디케이터 활성화
    if (slides.length > 0) {
        // 첫 번째 슬라이드 활성화
        slides[0].classList.add('active');
        
        // 첫 번째 인디케이터 활성화
        if (dots.length > 0) {
            dots[0].classList.add('active');
        }
        
        // 첫 번째 카드의 결제 ID를 hidden 필드에 설정
        document.getElementById('paymentMethodHidden').value = slides[0].getAttribute('data-payment');
    }
    
    // 이전 카드 버튼 클릭 이벤트
    if (prevBtn) {
        prevBtn.addEventListener('click', function() {
            currentIndex = (currentIndex - 1 + slides.length) % slides.length;
            updateSlider();
        });
    }
    
    // 다음 카드 버튼 클릭 이벤트
    if (nextBtn) {
        nextBtn.addEventListener('click', function() {
            currentIndex = (currentIndex + 1) % slides.length;
            updateSlider();
        });
    }
    
    // 인디케이터 클릭 이벤트
    dots.forEach(dot => {
        dot.addEventListener('click', function() {
            currentIndex = parseInt(this.getAttribute('data-index'));
            updateSlider();
        });
    });
    
    // 슬라이더 업데이트 함수
    function updateSlider() {
        // 모든 슬라이드 비활성화
        slides.forEach(slide => {
            slide.classList.remove('active');
        });
        
        // 모든 인디케이터 비활성화
        dots.forEach(dot => {
            dot.classList.remove('active');
        });
        
        // 현재 슬라이드와 인디케이터 활성화
        slides[currentIndex].classList.add('active');
        if (dots.length > 0) {
            dots[currentIndex].classList.add('active');
        }
        
        // 선택된 카드 정보 업데이트
        document.getElementById('paymentMethodHidden').value = slides[currentIndex].getAttribute('data-payment');
    }
}
</script>