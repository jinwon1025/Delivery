<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문하기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="<c:url value='/static/user/user-pages.css'/>">
<style>
.container {
	max-width: 768px;
	margin: 0 auto;
	padding: 15px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
	margin-bottom: 15px;
}

/* 결제 비밀번호 모달 스타일 */
.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	border-radius: 10px;
	width: 80%;
	max-width: 400px;
}

.modal-header {
	padding: 10px 0;
	border-bottom: 1px solid #eee;
	position: relative;
}

.modal-header h2 {
	margin: 0;
	text-align: center;
	font-size: 18px;
}

.close {
	position: absolute;
	right: 0;
	top: 0;
	color: #aaa;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.modal-body {
	padding: 20px 0;
	text-align: center;
}

.password-input-container {
	position: relative;
	margin: 20px auto;
	width: 80%;
}

#paymentPassword {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	text-align: center;
	font-size: 20px;
	letter-spacing: 10px;
	box-sizing: border-box;
}

.password-dots {
	display: flex;
	justify-content: center;
	margin-top: 15px;
}

.dot {
	width: 12px;
	height: 12px;
	background-color: #ddd;
	border-radius: 50%;
	margin: 0 8px;
}

.dot.filled {
	background-color: #4a90e2;
}

.modal-footer {
	padding: 10px 0;
	border-top: 1px solid #eee;
	display: flex;
	justify-content: space-between;
}

.modal-footer button {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

#cancelPayment {
	background-color: #f2f2f2;
}

#confirmPayment {
	background-color: #4a90e2;
	color: white;
}
</style>
</head>
<body>
	<h1 class="order-header">주문하기</h1>

	<!-- 전체 폼으로 페이지 감싸기 -->
	<form id="orderForm" action="/userstore/pay" method="post">
		<!-- 숨겨진 필드들 -->
		<input type="hidden" id="riderRequestHidden" name="riderRequest"
			value=""> <input type="hidden" id="storeRequestHidden"
			name="storeRequest" value=""> <input type="hidden"
			id="order_Id" name="order_Id" value="${order_Id}"> <input
			type="hidden" id="paymentMethodHidden" name="paymentMethod"
			value="${card.pay_id}"> <input type="hidden"
			id="couponValueHidden" name="couponValue" value="0"> <input
			type="hidden" id="selectedCouponIdHidden" name="selectedCouponId"
			value="0"> <input type="hidden" id="pointValueHidden"
			name="pointValue" value="0"> <input type="hidden"
			id="finalTotalHidden" name="finalTotal"
			value="${totalPrice + deliveryFee}"> <input type="hidden"
			id="menuPriceHidden" value="${totalPrice}"> <input
			type="hidden" id="deliveryFeeHidden" value="${deliveryFee}">
		<input type="hidden" id="paymentPasswordHidden" name="paymentPassword"
			value="">

		<!-- 배달주소, 라이더 요청사항, 내 연락처 컨테이너 -->
		<div class="container">
			<div class="section-title">
				<i class="fas fa-map-marker-alt"></i> 배달정보
			</div>

			<div class="input-group">
				<label for="fullAddress">배달주소</label> <input type="text"
					id="fullAddress" name="address" value="${userInfo.user_address}"
					readonly>
			</div>

			<div class="input-group">
				<label for="riderRequest">라이더 요청사항</label> <select id="riderRequest">
					<option value="">요청사항을 선택해주세요</option>
					<option value="문 앞에 놓아주세요">문 앞에 놓아주세요</option>
					<option value="직접 받겠습니다">직접 받겠습니다</option>
					<option value="경비실에 맡겨주세요">경비실에 맡겨주세요</option>
					<option value="배달 전 연락 부탁드립니다">배달 전 연락 부탁드립니다</option>
					<option value="direct">직접 입력</option>
				</select>
				<textarea id="riderRequestDirect" placeholder="요청사항을 직접 입력해주세요"
					style="display: none;"></textarea>
			</div>
		</div>

		<!-- 내 연락처 컨테이너 -->
		<div class="container">
			<div class="section-title">
				<i class="fas fa-phone-alt"></i> 내 연락처
			</div>

			<div class="input-group">
				<label for="phone">연락처</label> <input type="tel" id="phone"
					name="phone" value="${userInfo.user_phone}">
			</div>
		</div>

		<!-- 가게 요청사항 컨테이너 -->
		<div class="container">
			<div class="section-title">
				<i class="fas fa-store"></i> 가게 요청사항
			</div>

			<div class="input-group">
				<label for="storeRequest">요청사항</label> <select id="storeRequest">
					<option value="">요청사항을 선택해주세요</option>
					<option value="맵게 해주세요">맵게 해주세요</option>
					<option value="덜 맵게 해주세요">덜 맵게 해주세요</option>
					<option value="양념 많이 주세요">양념 많이 주세요</option>
					<option value="빨리 부탁드립니다">빨리 부탁드립니다</option>
					<option value="direct">직접 입력</option>
				</select>
				<textarea id="storeRequestDirect" placeholder="요청사항을 직접 입력해주세요"
					style="display: none;"></textarea>
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
										<div class="payment-card-slide" data-index="${status.index}"
											data-payment="${card.pay_id}">
											<div class="payment-card card-${card.card_type}">
												<div class="card-icon">
													<i class="fas fa-credit-card"></i>
												</div>
												<div class="card-info">
													<div class="card-name">${card.card_type}</div>
													<div class="card-number">**** **** ****
														${card.card_number.substring(card.card_number.length() - 4)}</div>
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
								<a href="/user/payRegister"> <i class="fas fa-plus-circle"></i>
									새 카드 추가하기
								</a>
							</div>
						</c:when>
						<c:otherwise>
							<div class="empty-card-container">
								<div class="empty-card-icon">
									<i class="fas fa-credit-card"></i>
								</div>
								<p class="text-muted">등록된 카드가 없습니다.</p>
								<a href="/user/payRegister" class="btn btn-primary mt-3"> <i
									class="fas fa-plus-circle"></i> 카드 등록하기
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
							<option value="${coupon.USER_CP_ID}"
								data-discount="${coupon.SALE_PRICE}"
								data-min-order="${coupon.MINIMUM_PURCHASE}"
								data-name="${coupon.CP_NAME}">${coupon.CP_NAME}(
								<fmt:formatNumber value="${coupon.SALE_PRICE}" pattern="#,###" />원
								할인, 최소주문
								<fmt:formatNumber value="${coupon.MINIMUM_PURCHASE}"
									pattern="#,###" />원)
							</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<div class="input-group">
				<label for="point">포인트</label>
				<div class="point-container">
					<input type="text" id="point" class="point-input"
						placeholder="사용할 포인트를 입력하세요" value="">
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
				<span class="price-title">메뉴 금액</span> <span class="price-value"
					id="menuPriceDisplay"></span>
			</div>

			<div class="price-row">
				<span class="price-title">배달팁</span> <span class="price-value"
					id="deliveryFeeDisplay"></span>
			</div>

			<div class="price-row">
				<span class="price-title">할인쿠폰</span> <span class="price-value"
					id="couponDisplay">-0원</span>
			</div>

			<div class="price-row">
				<span class="price-title">포인트 사용</span> <span class="price-value"
					id="pointDisplay">-0원</span>
			</div>

			<div class="total-price">
				<span class="total-price-title">총 결제금액</span> <span
					class="total-price-value" id="totalDisplay"></span>
			</div>
		</div>

		<button type="submit" class="order-btn" id="orderButton">결제하기</button>
	</form>

	<!-- 결제 비밀번호 모달 -->
	<div id="paymentPasswordModal" class="modal">
		<div class="modal-content">
			<div class="modal-header">
				<span class="close">&times;</span>
				<h2>결제 비밀번호 입력</h2>
			</div>
			<div class="modal-body">
				<p>안전한 결제를 위해 결제 비밀번호를 입력해주세요.</p>
				<div class="password-input-container">
					<input type="password" id="paymentPassword" maxlength="6"
						placeholder="6자리 비밀번호 입력">
					<div class="password-dots">
						<span class="dot"></span> <span class="dot"></span> <span
							class="dot"></span> <span class="dot"></span> <span class="dot"></span>
						<span class="dot"></span>
					</div>
				</div>
				<div class="error-message" id="passwordError"
					style="display: none; color: red;">비밀번호가 일치하지 않습니다.</div>
			</div>
			<div class="modal-footer">
				<button id="cancelPayment">취소</button>
				<button id="confirmPayment">확인</button>
			</div>
		</div>
	</div>

	<script>
// JSP 변수를 JavaScript 변수로 직접 할당
const totalPrice = ${totalPrice};
const deliveryFee = ${deliveryFee};
const hasPaymentPassword = ${hasPaymentPassword != null ? 'true' : 'false'};

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
    
    // 결제 비밀번호 모달 설정
    setupPaymentPasswordModal();
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

// 결제 비밀번호 모달 설정
function setupPaymentPasswordModal() {
    const modal = document.getElementById('paymentPasswordModal');
    const closeBtn = document.querySelector('.close');
    const passwordInput = document.getElementById('paymentPassword');
    const dots = document.querySelectorAll('.password-dots .dot');
    const confirmPaymentBtn = document.getElementById('confirmPayment');
    const cancelPaymentBtn = document.getElementById('cancelPayment');
    const passwordError = document.getElementById('passwordError');
    const modalTitle = document.querySelector('.modal-header h2');
    const modalDesc = document.querySelector('.modal-body p');
    const passwordInputContainer = document.querySelector('.password-input-container');

    // 폼 제출 이벤트 덮어쓰기
    document.getElementById('orderForm').addEventListener('submit', function(event) {
        event.preventDefault(); // 기본 제출 방지
        
        // 현재 선택된 결제 방식 확인
        const paymentMethod = document.getElementById('paymentMethodHidden').value;
        
        // 내 카드 결제 선택 & 등록된 카드가 없는 경우 체크
        const isCardPaymentSelected = document.querySelector('.payment-type[data-type="card"]').classList.contains('selected');
        const hasRegisteredCards = document.querySelectorAll('.payment-card-slide').length > 0;
        
        if (isCardPaymentSelected && !hasRegisteredCards) {
            // 등록된 카드가 없는 경우
            event.preventDefault();
            
            // 결제수단 섹션으로 스크롤
            const paymentSection = document.querySelector('.payment-methods-container');
            paymentSection.scrollIntoView({ behavior: 'smooth' });
            
            // 알림 메시지 표시
            const alertMsg = document.createElement('div');
            alertMsg.className = 'card-alert-message';
            alertMsg.style.color = 'red';
            alertMsg.style.marginTop = '10px';
            alertMsg.style.fontWeight = 'bold';
            alertMsg.style.padding = '10px';
            alertMsg.style.backgroundColor = '#fff8f8';
            alertMsg.style.border = '1px solid #ffcccb';
            alertMsg.style.borderRadius = '5px';
            alertMsg.style.textAlign = 'center';
            alertMsg.innerHTML = '<i class="fas fa-exclamation-circle"></i> 등록된 카드가 없습니다. 카드를 등록해주세요.';
            
            // 기존 알림 메시지가 있으면 제거
            const existingAlert = document.querySelector('.card-alert-message');
            if (existingAlert) {
                existingAlert.remove();
            }
            
            // 알림 메시지 삽입
            const emptyCardContainer = document.querySelector('.empty-card-container');
            if (emptyCardContainer) {
                emptyCardContainer.prepend(alertMsg);
                
                // 버튼 강조 표시
                const registerBtn = emptyCardContainer.querySelector('.btn');
                registerBtn.style.animation = 'pulse 1.5s infinite';
                
                // 애니메이션 CSS 추가
                if (!document.querySelector('style#pulse-animation')) {
                    const style = document.createElement('style');
                    style.id = 'pulse-animation';
                    style.innerHTML = `
                        @keyframes pulse {
                            0% { transform: scale(1); box-shadow: 0 0 0 0 rgba(74, 144, 226, 0.7); }
                            70% { transform: scale(1.05); box-shadow: 0 0 0 10px rgba(74, 144, 226, 0); }
                            100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(74, 144, 226, 0); }
                        }
                    `;
                    document.head.appendChild(style);
                }
                
                // 5초 후 알림 메시지 숨기기
                setTimeout(() => {
                    alertMsg.style.display = 'none';
                    registerBtn.style.animation = '';
                }, 5000);
            }
            
            return;
        }
        
        // 결제 방식에 따라 다른 처리
        if (paymentMethod === 'cash') {
            // 현금 결제인 경우 바로 폼 제출
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/userstore/pay';
            
            // 필요한 파라미터 추가 (카드 결제와 동일하게)
            const params = {
                'order_Id': document.getElementById('order_Id').value,
                'riderRequest': document.getElementById('riderRequestHidden').value,
                'storeRequest': document.getElementById('storeRequestHidden').value,
                'finalTotal': document.getElementById('finalTotalHidden').value,
                'selectedCouponId': document.getElementById('selectedCouponIdHidden').value,
                'paymentMethod': document.getElementById('paymentMethodHidden').value,
                'pointValue': document.getElementById('pointValueHidden').value
            };
            
            // 폼에 필드 추가
            for (const key in params) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = params[key];
                form.appendChild(input);
            }
            
            // 폼을 DOM에 추가하고 제출
            document.body.appendChild(form);
            form.submit();
        } else if (!isNaN(paymentMethod)) {
            // 카드 결제인 경우 결제 비밀번호 확인
            if (hasPaymentPassword === false) {
                // 결제 비밀번호가 없는 경우 - 비밀번호 설정 안내 모달 표시
                showPasswordRegisterModal();
            } else {
                // 결제 비밀번호가 있는 경우 - 일반 비밀번호 입력 모달 표시
                showPasswordModal(false);
            }
        }
    });

    // 비밀번호 설정 안내 모달 표시 함수
    function showPasswordRegisterModal() {
        // 모달 내용 변경
        modalTitle.textContent = '결제 비밀번호 설정 필요';
        modalDesc.textContent = '안전한 결제를 위해 결제 비밀번호 설정이 필요합니다.';
        
        // 입력 필드 숨기기
        passwordInputContainer.style.display = 'none';
        passwordError.style.display = 'none';
        
        // 버튼 텍스트 변경
        cancelPaymentBtn.textContent = '취소';
        confirmPaymentBtn.textContent = '비밀번호 설정하기';
        
        // 원래 이벤트 핸들러 백업
        const originalConfirmHandler = confirmPaymentBtn.onclick;
        
        // 비밀번호 설정하기 버튼 이벤트 변경
        confirmPaymentBtn.onclick = function() {
            // 비밀번호 설정 페이지로 이동
            window.location.href = '/user/paypassword';
        };
        
        // 모달 표시
        modal.style.display = 'block';
        
        // 취소 버튼 이벤트 - 모달 닫고 원래 상태로 복원
        cancelPaymentBtn.onclick = function() {
            closeModal();
            // 모달 내용 원래대로 복원
            modalTitle.textContent = '결제 비밀번호 입력';
            modalDesc.textContent = '안전한 결제를 위해 결제 비밀번호를 입력해주세요.';
            passwordInputContainer.style.display = 'block';
            confirmPaymentBtn.textContent = '확인';
            cancelPaymentBtn.textContent = '취소';
            
            // 이벤트 핸들러 복원
            confirmPaymentBtn.onclick = originalConfirmHandler;
            cancelPaymentBtn.onclick = closeModal;
        };
    }

    // 비밀번호 모달 표시 함수
    function showPasswordModal(showError) {
        modal.style.display = 'block';
        passwordInput.value = '';
        dots.forEach(dot => dot.classList.remove('filled'));
        
        if (showError) {
            passwordError.style.display = 'block';
        } else {
            passwordError.style.display = 'none';
        }
        
        // 포커스 설정
        setTimeout(() => {
            passwordInput.focus();
        }, 100);
    }

    // 비밀번호 입력 처리
    passwordInput.addEventListener('input', function() {
        const value = this.value;
        
        // 비밀번호 입력에 따른 시각적 표시 업데이트
        for (let i = 0; i < dots.length; i++) {
            if (i < value.length) {
                dots[i].classList.add('filled');
            } else {
                dots[i].classList.remove('filled');
            }
        }
    });

    // 확인 버튼 클릭
    confirmPaymentBtn.addEventListener('click', function() {
        // 결제 비밀번호 설정 모달이면 별도 처리
        if (modalTitle.textContent === '결제 비밀번호 설정 필요') {
            return; // 이미 버튼에 이벤트가 설정되어 있음
        }
        
        const password = passwordInput.value;
        
        // 비밀번호가 6자리인지 확인
        if (password.length !== 6) {
            passwordError.innerText = '6자리 비밀번호를 입력해주세요';
            passwordError.style.display = 'block';
            return;
        }
        
        // AJAX로 비밀번호 검증 요청
        verifyPasswordWithAjax(password);
    });

    // 취소 버튼 클릭
    cancelPaymentBtn.addEventListener('click', function() {
        closeModal();
    });

    // 닫기 버튼 클릭
    closeBtn.addEventListener('click', function() {
        closeModal();
    });

    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(event) {
        if (event.target === modal) {
            closeModal();
        }
    });

    // 모달 닫기 함수
    function closeModal() {
        modal.style.display = 'none';
        passwordInput.value = '';
        passwordError.style.display = 'none';
        dots.forEach(dot => dot.classList.remove('filled'));
        
        // 모달 내용 원래대로 복원
        modalTitle.textContent = '결제 비밀번호 입력';
        modalDesc.textContent = '안전한 결제를 위해 결제 비밀번호를 입력해주세요.';
        passwordInputContainer.style.display = 'block';
        confirmPaymentBtn.textContent = '확인';
        cancelPaymentBtn.textContent = '취소';
    }
    
    // AJAX로 비밀번호 검증
    function verifyPasswordWithAjax(password) {
        // 모든 폼 데이터 수집
        const formData = new FormData();
        formData.append('paymentPassword', password);
        formData.append('paymentMethod', document.getElementById('paymentMethodHidden').value);
        formData.append('order_Id', document.getElementById('order_Id').value);
        formData.append('riderRequest', document.getElementById('riderRequestHidden').value);
        formData.append('storeRequest', document.getElementById('storeRequestHidden').value);
        formData.append('address', document.getElementById('fullAddress').value);
        formData.append('phone', document.getElementById('phone').value);
        formData.append('couponValue', document.getElementById('couponValueHidden').value);
        formData.append('selectedCouponId', document.getElementById('selectedCouponIdHidden').value);
        formData.append('pointValue', document.getElementById('pointValueHidden').value);
        formData.append('finalTotal', document.getElementById('finalTotalHidden').value);
        
        // AJAX 요청 생성
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/userstore/verifyPaymentPasswordAjax', true);
        
        // 응답 처리
        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    const response = JSON.parse(xhr.responseText);
                    
                    if (response.success) {
                    	 // 비밀번호 검증 성공 - POST 방식으로 폼 제출
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = '/userstore/pay';
                        
                        // 필요한 파라미터 추가
                        const params = {
                            'order_Id': document.getElementById('order_Id').value,
                            'riderRequest': document.getElementById('riderRequestHidden').value,
                            'storeRequest': document.getElementById('storeRequestHidden').value,
                            'finalTotal': document.getElementById('finalTotalHidden').value,
                            'selectedCouponId': document.getElementById('selectedCouponIdHidden').value,
                            'paymentMethod': document.getElementById('paymentMethodHidden').value,
                            'pointValue': document.getElementById('pointValueHidden').value
                        };
                        // 폼에 필드 추가
                        for (const key in params) {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = key;
                            input.value = params[key];
                            form.appendChild(input);
                        }
                        
                        // 폼을 DOM에 추가하고 제출
                        document.body.appendChild(form);
                        form.submit();
                    } else {
                        // 비밀번호 검증 실패 - 오류 표시
                        passwordError.innerText = '비밀번호가 일치하지 않습니다';
                        passwordError.style.display = 'block';
                        passwordInput.value = '';
                        dots.forEach(dot => dot.classList.remove('filled'));
                        passwordInput.focus();
                    }
                } catch (e) {
                    console.error('응답 처리 오류:', e);
                    passwordError.innerText = '처리 중 오류가 발생했습니다';
                    passwordError.style.display = 'block';
                }
            } else {
                passwordError.innerText = '서버 오류가 발생했습니다';
                passwordError.style.display = 'block';
            }
        };
        
        // 요청 실패 처리
        xhr.onerror = function() {
            passwordError.innerText = '네트워크 오류가 발생했습니다';
            passwordError.style.display = 'block';
        };
        
        // 요청 전송
        xhr.send(formData);
    }
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
    
    // 폼 제출 전 최종 확인 (쿠폰 최소 주문금액 확인)
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
</body>
</html>