<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 관리</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    /* 전체 페이지 스타일 */
    .coupon-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 30px;
        background-color: #f9f9f9;
        border-radius: 10px;
    }
    
    /* 타이틀 영역 */
    .section-title {
        display: flex;
        align-items: center;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 2px solid #f0f0f0;
    }
    
    .section-title i {
        font-size: 1.5rem;
        margin-right: 12px;
        color: #ff9800;
    }
    
    .section-title h2 {
        font-size: 1.5rem;
        font-weight: 600;
        color: #333;
        margin: 0;
    }
    
    /* 폼 레이아웃 */
    .content-section {
        background-color: white;
        border-radius: 8px;
        padding: 25px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        margin-bottom: 30px;
    }
    
    .form-row {
        display: flex;
        flex-wrap: wrap;
        margin: 0 -15px;
    }
    
    .form-group {
        flex: 1;
        padding: 0 15px;
        margin-bottom: 20px;
        min-width: 250px;
    }
    
    /* 라벨 및 입력 필드 */
    .form-label {
        display: block;
        font-weight: 500;
        margin-bottom: 8px;
        color: #555;
    }
    
    .form-control {
        width: 100%;
        padding: 12px 15px;
        font-size: 1rem;
        border: 1px solid #ddd;
        border-radius: 6px;
        background-color: #fff;
        transition: all 0.3s;
    }
    
    .form-control:focus {
        border-color: #ff9800;
        box-shadow: 0 0 0 3px rgba(255, 152, 0, 0.2);
        outline: none;
    }
    
    .form-control::placeholder {
        color: #aaa;
    }
    
    .date-input {
        display: flex;
        align-items: center;
    }
    
    /* 셀렉트 박스 */
    .select-wrapper {
        position: relative;
    }
    
    .select-wrapper::after {
        content: '▼';
        font-size: 0.8rem;
        color: #888;
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        pointer-events: none;
    }
    
    .custom-select {
        appearance: none;
        -webkit-appearance: none;
        padding-right: 30px;
    }
    
    /* 버튼 스타일 */
    .btn-container {
        margin-top: 10px;
        text-align: center;
    }
    
    .btn-primary {
        background-color: #ff9800;
        color: white;
        border: none;
        padding: 12px 24px;
        font-size: 1rem;
        font-weight: 500;
        border-radius: 6px;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s;
    }
    
    .btn-primary:hover {
        background-color: #f57c00;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    
    .btn-primary i {
        margin-right: 8px;
        font-size: 1.1rem;
    }
    
    .btn-danger {
        background-color: #dc3545;
        color: white;
        border: none;
        padding: 8px 16px;
        font-size: 0.9rem;
        font-weight: 500;
        border-radius: 4px;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        transition: all 0.3s;
    }
    
    .btn-danger:hover {
        background-color: #c82333;
    }
    
    .btn-danger i {
        margin-right: 6px;
    }
    
    /* 테이블 스타일 */
    .table-container {
        margin-top: 20px;
        overflow-x: auto;
    }
    
    .coupon-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.95rem;
    }
    
    .coupon-table th {
        background-color: #f8f9fa;
        color: #495057;
        font-weight: 600;
        text-align: left;
        padding: 12px 15px;
        border-bottom: 2px solid #dee2e6;
    }
    
    .coupon-table td {
        padding: 12px 15px;
        border-bottom: 1px solid #e9ecef;
        vertical-align: middle;
    }
    
    .coupon-table tr:hover {
        background-color: #f8f9fa;
    }
    
    /* 뱃지 스타일 */
    .badge {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 4px;
        font-weight: 500;
        font-size: 0.75rem;
        text-align: center;
    }
    
    .bg-success {
        background-color: #28a745;
        color: white;
    }
    
    .bg-danger {
        background-color: #dc3545;
        color: white;
    }
    
    /* 반응형 조정 */
    @media (max-width: 992px) {
        .coupon-container {
            padding: 20px;
        }
    }
    
    @media (max-width: 768px) {
        .form-group {
            flex: 1 0 100%;
        }
        
        .content-section {
            padding: 20px 15px;
        }
    }
</style>
</head>
<body>

<div class="coupon-container">
    <!-- 쿠폰 발행 섹션 -->
    <div class="section-title">
        <i class="fas fa-ticket-alt"></i>
        <h2>쿠폰 발행</h2>
    </div>
    
    <div class="content-section">
        <form id="couponForm" action="<c:url value='/admin/coupon/create'/>" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="couponName" class="form-label">쿠폰명</label>
                    <input type="text" id="couponName" class="form-control" name="cp_name" placeholder="쿠폰 이름을 입력하세요" required>
                </div>
                
                <div class="form-group">
                    <label for="salePrice" class="form-label">할인 금액</label>
                    <input type="number" id="salePrice" class="form-control" name="sale_price" placeholder="금액을 입력하세요" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="expireDate" class="form-label">만료일</label>
                    <input type="date" id="expireDate" class="form-control" name="expire_date" required>
                </div>
                
                <div class="form-group">
                    <label for="totalQuantity" class="form-label">발행 수량</label>
                    <input type="number" id="totalQuantity" class="form-control" name="total_quantity" placeholder="발행할 쿠폰 수량" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="ownerId" class="form-label">사장님 ID</label>
                    <div class="select-wrapper">
                        <select id="ownerId" class="form-control custom-select" name="owner_id" required>
                            <option value="">사장님을 선택하세요</option>
                            <c:forEach var="owner" items="${ownerList}">
                                <option value="${owner.owner_id}">${owner.owner_id}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <!-- 균형을 위한 빈 공간 -->
                </div>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn-primary">
                    <i class="fas fa-plus-circle"></i>
                    쿠폰 발행하기
                </button>
            </div>
        </form>
    </div>
    
    <!-- 쿠폰 목록 섹션 -->
    <div class="section-title">
        <i class="fas fa-list-alt"></i>
        <h2>쿠폰 현황</h2>
    </div>
    
    <div class="content-section">
        <div class="table-container">
            <table class="coupon-table">
                <thead>
                    <tr>
                        <th>쿠폰 ID</th>
                        <th>쿠폰명</th>
                        <th>할인금액</th>
                        <th>사장님 ID</th>
                        <th>발행일</th>
                        <th>만료일</th>
                        <th>발행 수량</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="coupon" items="${couponList}">
                        <tr>
                            <td>${coupon.owner_coupon_id}</td>
                            <td>${coupon.cp_name}</td>
                            <td><fmt:formatNumber value="${coupon.sale_price}" type="currency" currencySymbol="₩" maxFractionDigits="0" /></td>
                            <td>${coupon.owner_id}</td>
                            <td>${coupon.issued_date}</td>
                            <td>${coupon.expire_date}</td>
                            <td>${coupon.total_quantity}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${coupon.expire_date < now}">
                                        <span class="badge bg-danger">만료됨</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success">사용가능</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <button type="button" class="btn-danger" onclick="if(confirm('정말 삭제하시겠습니까?')) deleteCoupon(${coupon.owner_coupon_id})">
                                    <i class="fas fa-trash"></i>삭제
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <!-- 데이터가 없을 경우 메시지 표시 -->
                    <c:if test="${empty couponList}">
                        <tr>
                            <td colspan="9" style="text-align: center; padding: 30px;">
                                <i class="fas fa-info-circle" style="font-size: 1.5rem; color: #6c757d; margin-bottom: 10px;"></i>
                                <p>등록된 쿠폰이 없습니다. 새로운 쿠폰을 발행해주세요.</p>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // 오늘 날짜를 기본값으로 설정
        const today = new Date();
        const minDate = today.toISOString().split('T')[0];
        $('#expireDate').attr('min', minDate);
        
        // 폼 유효성 검사
        $('#couponForm').on('submit', function(e) {
            const couponName = $('#couponName').val().trim();
            const salePrice = $('#salePrice').val();
            const totalQuantity = $('#totalQuantity').val();
            
            if (couponName === '') {
                alert('쿠폰명을 입력해주세요.');
                $('#couponName').focus();
                return false;
            }
            
            if (salePrice <= 0) {
                alert('할인 금액은 0보다 커야 합니다.');
                $('#salePrice').focus();
                return false;
            }
            
            if (totalQuantity <= 0) {
                alert('발행 수량은 0보다 커야 합니다.');
                $('#totalQuantity').focus();
                return false;
            }
            
            return true;
        });
    });
    
    function deleteCoupon(couponId) {
        $.ajax({
            url: '<c:url value="/admin/coupon/delete/"/>' + couponId,
            type: 'POST',
            success: function(response) {
                alert('쿠폰이 삭제되었습니다.');
                location.reload();
            },
            error: function() {
                alert('쿠폰 삭제에 실패했습니다.');
            }
        });
    }
</script>

</body>
</html>