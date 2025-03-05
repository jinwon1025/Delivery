<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문하기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
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
    
    .payment-methods {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 10px;
    }
    
    .payment-method {
        flex: 1 0 calc(50% - 10px);
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 5px;
        text-align: center;
        cursor: pointer;
        transition: all 0.2s;
    }
    
    .payment-method.selected {
        border-color: #fa0050;
        background-color: #fff0f5;
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
        <input type="hidden" id="paymentMethodHidden" name="paymentMethod" value="신용카드">
        <input type="hidden" id="couponValueHidden" name="couponValue" value="0">
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
            
            <div class="payment-methods">
                <div class="payment-method selected" data-payment="신용카드">
                    <i class="fas fa-credit-card"></i>
                    <div>신용카드</div>
                </div>
                <div class="payment-method" data-payment="계좌이체">
                    <i class="fas fa-money-bill-wave"></i>
                    <div>계좌이체</div>
                </div>
                <div class="payment-method" data-payment="휴대폰결제">
                    <i class="fas fa-mobile-alt"></i>
                    <div>휴대폰결제</div>
                </div>
                <div class="payment-method" data-payment="간편결제">
                    <i class="fab fa-paypal"></i>
                    <div>간편결제</div>
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
                        <option value="">사용 가능한 쿠폰 (3개)</option>
                        <option value="1000">첫 주문 1,000원 할인</option>
                        <option value="2000">신규가입 2,000원 할인</option>
                        <option value="3000">이벤트 3,000원 할인</option>
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
    
    // 결제수단 선택
    const paymentMethods = document.querySelectorAll('.payment-method');
    paymentMethods.forEach(method => {
        method.addEventListener('click', function() {
            paymentMethods.forEach(m => m.classList.remove('selected'));
            this.classList.add('selected');
            
            // 선택된 결제수단 hidden 필드에 저장
            document.getElementById('paymentMethodHidden').value = this.getAttribute('data-payment');
        });
    });
    
    // 쿠폰 선택시 금액 변경
    document.getElementById('coupon').addEventListener('change', function() {
        const couponValue = this.value ? parseInt(this.value) : 0;
        
        // 쿠폰 금액 표시 업데이트
        const couponDisplay = document.getElementById('couponDisplay');
        couponDisplay.textContent = '-' + couponValue.toLocaleString() + '원';
        
        // 쿠폰 값 hidden 필드에 저장
        document.getElementById('couponValueHidden').value = couponValue;
        
        updateTotalPrice();
    });
    
    // 포인트 입력시 금액 변경
    document.getElementById('point').addEventListener('input', function() {
        const pointValue = this.value ? parseInt(this.value) : 0;
        
        // 포인트 사용 금액 표시 업데이트
        const pointDisplay = document.getElementById('pointDisplay');
        pointDisplay.textContent = '-' + pointValue.toLocaleString() + '원';
        
        // 포인트 값 hidden 필드에 저장
        document.getElementById('pointValueHidden').value = pointValue;
        
        updateTotalPrice();
    });
    
    // 전액사용 버튼
    document.querySelector('.point-btn').addEventListener('click', function() {
        // 사용 가능 포인트 가져오기 (예: "사용 가능 포인트: 5,000P" 에서 "5000" 추출)
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
    
    // 페이지 로드 시 초기화
    window.addEventListener('DOMContentLoaded', function() {
        // 메뉴 가격과 배달팁 표시 업데이트
        document.getElementById('menuPriceDisplay').textContent = totalPrice.toLocaleString() + '원';
        document.getElementById('deliveryFeeDisplay').textContent = deliveryFee.toLocaleString() + '원';
        
        // 초기 총 결제금액 업데이트
        updateTotalPrice();
    });
    	
</script>
</body>
</html>