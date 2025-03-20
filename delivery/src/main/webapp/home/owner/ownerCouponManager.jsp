<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
    /* 쿠폰 관리 페이지 스타일 */
    .page-title {
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 10px;
    }
    
    .page-description {
        color: #666;
        margin-bottom: 20px;
    }
    
    /* 카드 스타일 */
    .card {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
        overflow: hidden;
    }
    
    .card-header {
        padding: 16px 20px;
        font-weight: 600;
        font-size: 16px;
        display: flex;
        align-items: center;
    }
    
    .card-header-gold {
        background-color: #d6b742; /* 골드 색상 */
        color: #fff;
    }
    
    .card-header-brown {
        background-color: #7c5e10; /* 갈색 */
        color: #fff;
    }
    
    .card-body {
        padding: 20px;
    }
    
    /* 테이블 스타일 */
    .table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .table th {
        background-color: #f5f5f5;
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #ddd;
        font-weight: 600;
    }
    
    .table td {
        padding: 12px 15px;
        border-bottom: 1px solid #eee;
    }
    
    .table tr:hover {
        background-color: #f9f9f9;
    }
    
    /* 쿠폰 설정 영역 */
    .settings-container {
        margin-top: 20px;
        padding-top: 15px;
        border-top: 1px solid #eee;
    }
    
    .settings-title {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        font-size: 16px;
        font-weight: 600;
    }
    
    .settings-title i {
        margin-right: 8px;
        color: #d6b742;
    }
    
    .form-row {
        display: flex;
        gap: 15px;
        margin-bottom: 20px;
    }
    
    .form-group {
        flex: 1;
    }
    
    .form-label {
        display: flex;
        align-items: center;
        margin-bottom: 8px;
        font-weight: 500;
    }
    
    .form-label i {
        margin-right: 5px;
        color: #666;
    }
    
    .form-select {
        width: 100%;
        height: 45px;
        padding: 0 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        background-color: #f9f9f9;
        font-size: 14px;
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%23333' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 12px center;
        background-size: 16px;
    }
    
    /* 단위 표시 입력 필드 */
    .form-input-group {
        display: flex;
        align-items: center;
    }
    
    .form-input {
        flex: 1;
        height: 45px;
        padding: 0 12px;
        border: 1px solid #ddd;
        border-radius: 4px 0 0 4px;
        background-color: #f9f9f9;
        font-size: 14px;
    }
    
    .input-unit {
        height: 45px;
        display: flex;
        align-items: center;
        padding: 0 12px;
        background-color: #f5f5f5;
        border: 1px solid #ddd;
        border-left: none;
        border-radius: 0 4px 4px 0;
        color: #666;
    }
    
    .form-helper {
        margin-top: 5px;
        font-size: 12px;
        color: #888;
    }
    
    /* 버튼 스타일 */
    .btn-container {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    
    .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        height: 45px;
        padding: 0 24px;
        background-color: #d6b742;
        color: white;
        font-size: 14px;
        font-weight: 600;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: all 0.2s;
    }
    
    .btn:hover {
        background-color: #c5a83b;
    }
    
    .btn i {
        margin-right: 8px;
    }
    
    /* 배지 스타일 */
    .badge {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 30px;
        font-size: 12px;
        font-weight: 600;
        text-align: center;
        min-width: 40px;
    }
    
    .badge-green {
        background-color: #28a745;
        color: white;
    }
    
    .badge-danger {
        background-color: #dc3545;
        color: white;
    }
    
    /* 알림 메시지 스타일 */
    .alert {
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 4px;
    }
    
    .alert-info {
        background-color: #d1ecf1;
        color: #0c5460;
        border: 1px solid #bee5eb;
    }
    
    /* 반응형 설정 */
    @media (max-width: 768px) {
        .form-row {
            flex-direction: column;
            gap: 15px;
        }
    }
</style>

<div class="container">
    <h1 class="page-title">쿠폰 관리</h1>
    <p class="page-description">관리자가 생성한 쿠폰을 가게에 적용하고 관리합니다.</p>
    
    <!-- 적용 가능한 쿠폰 카드 -->
    <div class="card">
        <div class="card-header card-header-gold">
            <i class="fas fa-ticket-alt"></i> 적용 가능한 쿠폰
        </div>
        <div class="card-body">
            <c:if test="${empty availableCoupons}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> 적용 가능한 쿠폰이 없습니다.
                </div>
            </c:if>
            
            <c:if test="${not empty availableCoupons}">
                <!-- 쿠폰 적용 폼 시작 -->
                <form action="<c:url value='/owner/applyCoupon'/>" method="post" id="applyCouponForm">
                    <div class="table-responsive mb-4">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>선택</th>
                                    <th>쿠폰명</th>
                                    <th>할인금액</th>
                                    <th>만료일</th>
                                    <th>등록 가능 수량</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="coupon" items="${availableCoupons}">
                                    <tr>
                                        <td>
                                            <input type="radio" name="owner_coupon_id" id="coupon_${coupon.owner_coupon_id}" 
                                            value="${coupon.owner_coupon_id}" 
                                            data-coupon-name="${coupon.cp_name}" 
                                            data-sale-price="${coupon.sale_price}" 
                                            data-expire-date="${coupon.expire_date}" 
                                            data-total-quantity="${coupon.total_quantity}"
                                            data-minimum-purchase="${coupon.minimum_purchase != null ? coupon.minimum_purchase : 10000}"
                                            required>
                                        </td>
                                        <td>${coupon.cp_name}</td>
                                        <td><fmt:formatNumber value="${coupon.sale_price}" type="currency" currencySymbol="₩" maxFractionDigits="0" /></td>
                                        <td>${coupon.expire_date}</td>
                                        <td><span class="badge badge-green">${coupon.total_quantity}</span></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- hidden fields for selected coupon data -->
                    <input type="hidden" name="couponName" id="couponNameInput">
                    <input type="hidden" name="salePrice" id="salePriceInput">
                    <input type="hidden" name="expireDate" id="expireDateInput">
                    <input type="hidden" name="totalQuantity" id="totalQuantityInput">
                    <input type="hidden" name="minimumPurchase" id="hiddenMinimumPurchase">
                    
                    <!-- 쿠폰 적용 설정 -->
                    <div class="settings-container">
                        <div class="settings-title">
                            <i class="fas fa-cog"></i> 쿠폰 적용 설정
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label" for="storeSelect">
                                    <i class="fas fa-store"></i> 가게 선택
                                </label>
                                <select id="storeSelect" name="storeId" class="form-select" required>
                                    <option value="">가게 선택</option>
                                    <c:forEach var="store" items="${storeList}">
                                        <option value="${store.store_id}">${store.store_name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="quantityInput">
                                    <i class="fas fa-cubes"></i> 사용할 수량
                                </label>
                                <div class="form-input-group">
                                    <input type="number" id="quantityInput" name="quantity" class="form-input" min="1" value="1" required>
                                    <span class="input-unit">개</span>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="minimumPurchaseInput">
                                    <i class="fas fa-tags"></i> 최소 주문금액
                                </label>
                                <div class="form-input-group">
                                    <input type="number" id="minimumPurchaseInput" class="form-input" min="0" value="10000" required>
                                    <span class="input-unit">원</span>
                                </div>
                                <div class="form-helper">쿠폰 사용을 위한 최소 주문 금액을 설정하세요</div>
                            </div>
                        </div>
                        
                        <div class="btn-container">
                            <button type="submit" class="btn" id="applyButton">
                                <i class="fas fa-check-circle"></i> 쿠폰 등록하기
                            </button>
                        </div>
                    </div>
                </form>
            </c:if>
        </div>
    </div>
    
    <!-- 가게별 적용된 쿠폰 카드 -->
    <div class="card">
        <div class="card-header card-header-brown">
            <i class="fas fa-store"></i> 가게별 적용된 쿠폰
        </div>
        <div class="card-body">
            <c:if test="${empty appliedStoreCoupons}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> 적용된 쿠폰이 없습니다.
                </div>
            </c:if>
            
            <c:if test="${not empty appliedStoreCoupons}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>가게명</th>
                                <th>쿠폰명</th>
                                <th>최소 주문금액</th>
                                <th>만료일</th>
                                <th>등록 수량</th>
                                <th>사용된 수량</th>
                                <th>남은 수량</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="coupon" items="${appliedStoreCoupons}">
                                <tr>
                                    <td>${coupon.STORE_NAME}</td>
                                    <td>${coupon.CP_NAME}</td>
                                    <td><fmt:formatNumber value="${coupon.MINIMUM_PURCHASE}" type="currency" currencySymbol="₩" maxFractionDigits="0" /></td>
                                    <td>${coupon.EXPIRE_DATE}</td>
                                    <td>${coupon.QUANTITY}</td>
                                    <td>${coupon.USED_QTY}</td>
                                    <td><span class="badge badge-${coupon.REMAINING_QTY > 0 ? 'green' : 'danger'}">${coupon.REMAINING_QTY}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const couponRadios = document.querySelectorAll('input[name="owner_coupon_id"]');
    const storeSelect = document.getElementById('storeSelect');
    const quantityInput = document.getElementById('quantityInput');
    const minimumPurchaseInput = document.getElementById('minimumPurchaseInput');
    const hiddenMinimumPurchase = document.getElementById('hiddenMinimumPurchase');
    const applyButton = document.getElementById('applyButton');
    const couponNameInput = document.getElementById('couponNameInput');
    const salePriceInput = document.getElementById('salePriceInput');
    const expireDateInput = document.getElementById('expireDateInput');
    const totalQuantityInput = document.getElementById('totalQuantityInput');
    
    // 페이지 로드 시 초기값 설정
    storeSelect.disabled = true;
    quantityInput.disabled = true;
    minimumPurchaseInput.disabled = true;
    applyButton.disabled = true;
    
    // 쿠폰 라디오 버튼 클릭 이벤트
    couponRadios.forEach(radio => {
        radio.addEventListener('change', function() {
            // 폼 활성화
            storeSelect.disabled = false;
            quantityInput.disabled = false;
            minimumPurchaseInput.disabled = false;
            applyButton.disabled = false;
            
            // 선택된 쿠폰 정보 설정
            const maxQuantity = this.dataset.totalQuantity;
            const minimumPurchase = this.dataset.minimumPurchase;
            
            // 선택된 행 스타일 변경
            couponRadios.forEach(r => {
                const row = r.closest('tr');
                if (r === this) {
                    row.style.backgroundColor = 'rgba(214, 183, 66, 0.1)';
                } else {
                    row.style.backgroundColor = '';
                }
            });
            
            // hidden 필드 값 설정
            couponNameInput.value = this.dataset.couponName;
            salePriceInput.value = this.dataset.salePrice;
            expireDateInput.value = this.dataset.expireDate;
            totalQuantityInput.value = this.dataset.totalQuantity;
            hiddenMinimumPurchase.value = minimumPurchase;
            
            // 최대 수량 및 최소 구매 금액 설정
            quantityInput.max = maxQuantity;
            quantityInput.value = "1";
            minimumPurchaseInput.value = minimumPurchase;
            
            // 스크롤을 적용 설정 섹션으로 부드럽게 이동
            document.querySelector('.settings-container').scrollIntoView({ 
                behavior: 'smooth',
                block: 'start'
            });
        });
    });
    
    // 사용할 수량 입력값 변경 시 유효성 검사
    quantityInput.addEventListener('input', function() {
        const inputQuantity = parseInt(this.value);
        const maxQuantity = parseInt(this.max);
        
        if (inputQuantity > maxQuantity) {
            alert(`사용 가능한 최대 수량은 ${maxQuantity}개입니다.`);
            this.value = maxQuantity;
        }
    });
    
    // 가게 선택 시 이벤트
    storeSelect.addEventListener('change', function() {
        const storeId = this.value;
        const selectedRadio = document.querySelector('input[name="owner_coupon_id"]:checked');
        
        // 가게가 선택되지 않았거나 쿠폰이 선택되지 않았으면 리턴
        if (!storeId || !selectedRadio) {
            return;
        }
        
        const couponId = selectedRadio.value;
        
        // AJAX 요청을 통해 해당 가게에 적용 가능한 쿠폰 수량 가져오기
        fetch(`/owner/getCouponAvailableQuantity?couponId=${couponId}&storeId=${storeId}`)
            .then(response => response.json())
            .then(data => {
                if (data.availableQuantity) {
                    quantityInput.max = data.availableQuantity;
                    quantityInput.value = "1";
                    
                    // 알림 표시
                    alert(`가게에 적용 가능한 쿠폰 수량: ${data.availableQuantity}개`);
                }
            })
            .catch(error => console.error('Error:', error));
    });
    
    // 폼 제출 전 유효성 검사
    document.getElementById('applyCouponForm').addEventListener('submit', function(e) {
        const selectedCoupon = document.querySelector('input[name="owner_coupon_id"]:checked');
        
        if (!selectedCoupon) {
            e.preventDefault();
            alert('쿠폰을 선택해주세요.');
            return false;
        }
        
        if (!storeSelect.value) {
            e.preventDefault();
            alert('가게를 선택해주세요.');
            storeSelect.focus();
            return false;
        }
        
        // 수량 유효성 검사 추가
        const inputQuantity = parseInt(quantityInput.value);
        const maxQuantity = parseInt(quantityInput.max);
        
        if (inputQuantity <= 0) {
            e.preventDefault();
            alert('수량은 1개 이상이어야 합니다.');
            quantityInput.value = 1;
            quantityInput.focus();
            return false;
        }
        
        if (inputQuantity > maxQuantity) {
            e.preventDefault();
            alert(`사용 가능한 최대 수량은 ${maxQuantity}개입니다.`);
            quantityInput.value = maxQuantity;
            quantityInput.focus();
            return false;
        }
        
        // 최소 주문금액 확인
        const minPurchase = parseInt(minimumPurchaseInput.value);
        if (minPurchase < 0) {
            e.preventDefault();
            alert('최소 주문금액은 0원 이상이어야 합니다.');
            minimumPurchaseInput.value = 0;
            minimumPurchaseInput.focus();
            return false;
        }
        
        // 최소 주문금액 hidden 필드에 값 설정
        hiddenMinimumPurchase.value = minimumPurchaseInput.value;
        
        return true;
    });
});
</script>