<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h1 class="page-title">쿠폰 관리</h1>
<p class="page-description">관리자가 생성한 쿠폰을 가게에 적용하고 관리합니다.</p>

<div class="row">
    <!-- 적용 가능한 쿠폰 목록 -->
    <div class="col-md-12">
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-ticket-alt"></i> 적용 가능한 쿠폰
                </h5>
            </div>
            <div class="card-body">
                <c:if test="${empty availableCoupons}">
                    <div class="alert alert-info">
                        적용 가능한 쿠폰이 없습니다.
                    </div>
                </c:if>
                
                <c:if test="${not empty availableCoupons}">
                    <!-- 쿠폰 적용 폼 시작 -->
                    <form action="<c:url value='/owner/applyCoupon'/>" method="post" id="applyCouponForm">
                        <div class="table-responsive mb-4">
                            <table class="table table-striped">
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
                                            <td>${coupon.total_quantity}</td>
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
                        
                        <!-- 적용 설정 섹션 -->
                        <div class="card">
                            <div class="card-header bg-light">
                                <h6 class="mb-0">쿠폰 적용 설정</h6>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label for="storeSelect" class="form-label">가게 선택</label>
                                        <select class="form-select" name="storeId" id="storeSelect" required disabled>
                                            <option value="" selected>가게 선택</option>
                                            <c:forEach var="store" items="${storeList}">
                                                <option value="${store.store_id}">${store.store_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="col-md-4 mb-3">
                                        <label for="quantityInput" class="form-label">사용할 수량</label>
                                        <input type="number" class="form-control" 
                                               id="quantityInput" 
                                               name="quantity" 
                                               min="1" 
                                               value="1" 
                                               required
                                               disabled>
                                    </div>
                                    
                                    <div class="col-md-4 mb-3">
                                        <label for="minimumPurchaseInput" class="form-label">최소 주문금액</label>
                                        <div class="input-group">
                                            <span class="input-group-text">₩</span>
                                            <input type="number" class="form-control" 
                                                   id="minimumPurchaseInput" 
                                                   min="0" 
                                                   value="10000" 
                                                   required
                                                   disabled>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary" id="applyButton" disabled>
                                        쿠폰 등록하기
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- 가게별 적용된 쿠폰 목록 -->
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-store"></i> 가게별 적용된 쿠폰
                </h5>
            </div>
            <div class="card-body">
                <c:if test="${empty appliedStoreCoupons}">
                    <div class="alert alert-info">
                        적용된 쿠폰이 없습니다.
                    </div>
                </c:if>
                
                <c:if test="${not empty appliedStoreCoupons}">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>가게명</th>
                                    <th>쿠폰명</th>
                                    <th>최소 주문금액</th>
                                    <th>만료일</th>
                                    <th>등록 수량</th>
                                    <th>사용된 수량</th>
                                    <th>남은 수량</th>
                                    <th>관리</th>
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
                                        <td>${coupon.REMAINING_QTY}</td>
                                        <td>
                                            <button type="button" class="btn btn-sm btn-outline-danger" 
                                                    onclick="removeCoupon(${coupon.STORE_COUPON_ID}, '${coupon.STORE_ID}', '${coupon.CP_NAME}')">
                                                삭제
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- 쿠폰 삭제 확인 모달 -->
<div class="modal fade" id="removeCouponModal" tabindex="-1" aria-labelledby="removeCouponModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="removeCouponModalLabel">쿠폰 삭제 확인</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p id="removeCouponMessage">선택한 쿠폰을 정말 삭제하시겠습니까?</p>
                <form id="removeCouponForm" action="<c:url value='/owner/removeCoupon'/>" method="post">
                    <input type="hidden" id="removeStoreCouponId" name="storeCouponId">
                    <input type="hidden" id="removeStoreId" name="storeId">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-danger" id="confirmRemoveBtn">삭제</button>
            </div>
        </div>
    </div>
</div>

<!-- 쿠폰 선택 및 적용 관련 스크립트 -->
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
            const couponId = document.querySelector('input[name="owner_coupon_id"]:checked').value;
            
            // 가게가 선택되지 않았으면 리턴
            if (!storeId || !couponId) {
                return;
            }
            
            // AJAX 요청을 통해 해당 가게에 적용 가능한 쿠폰 수량 가져오기
            fetch(`/owner/getCouponAvailableQuantity?couponId=${couponId}&storeId=${storeId}`)
                .then(response => response.json())
                .then(data => {
                    if (data.availableQuantity) {
                        quantityInput.max = data.availableQuantity;
                        quantityInput.value = "1";
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
                return false;
            }
            
            // 수량 유효성 검사 추가
            const inputQuantity = parseInt(quantityInput.value);
            const maxQuantity = parseInt(quantityInput.max);
            
            if (inputQuantity > maxQuantity) {
                e.preventDefault();
                alert(`사용 가능한 최대 수량은 ${maxQuantity}개입니다.`);
                quantityInput.value = maxQuantity;
                return false;
            }
            
            // 폼 제출 전 disabled 속성 제거
            minimumPurchaseInput.disabled = false;
            
            // 최소 주문금액 hidden 필드에 값 설정
            hiddenMinimumPurchase.value = minimumPurchaseInput.value;
            
            return true;
        });
        
        // 쿠폰 삭제 확인 버튼 이벤트
        document.getElementById('confirmRemoveBtn').addEventListener('click', function() {
            document.getElementById('removeCouponForm').submit();
        });
    });
    
    // 쿠폰 삭제 함수
    function removeCoupon(storeCouponId, storeId, couponName) {
        document.getElementById('removeStoreCouponId').value = storeCouponId;
        document.getElementById('removeStoreId').value = storeId;
        document.getElementById('removeCouponMessage').textContent = `"${couponName}" 쿠폰을 정말 삭제하시겠습니까?`;
        
        const modal = new bootstrap.Modal(document.getElementById('removeCouponModal'));
        modal.show();
    }
</script>