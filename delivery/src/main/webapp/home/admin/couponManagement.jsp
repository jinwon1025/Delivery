<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
.container {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 0 2rem;
}

.dashboard-header {
    background: linear-gradient(to right, #1a237e, #283593);
    color: white;
    padding: 2rem;
    border-radius: 10px;
    margin-bottom: 2rem;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.card {
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
    border: none;
}

.card-header {
    background: #f8f9fa;
    padding: 1.5rem;
    border-radius: 10px 10px 0 0;
    border-bottom: 1px solid rgba(0,0,0,0.1);
}

.card-body {
    padding: 2rem;
}

.btn-primary {
    background: linear-gradient(to right, #1e88e5, #1976d2);
    border: none;
    padding: 0.8rem 1.5rem;
    border-radius: 5px;
    transition: all 0.3s ease;
    color: white;
}

.btn-secondary {
    background: linear-gradient(to right, #757575, #616161);
    border: none;
    padding: 0.8rem 1.5rem;
    border-radius: 5px;
    color: white;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    opacity: 0.9;
}

.form-control {
    padding: 0.8rem;
    border-radius: 5px;
    border: 1px solid #dee2e6;
    transition: all 0.3s ease;
}

.form-control:focus {
    border-color: #1e88e5;
    box-shadow: 0 0 0 2px rgba(30,136,229,0.1);
}

.table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    margin: 1rem 0;
}

.table th {
    background: #f8f9fa;
    padding: 1rem;
    font-weight: 600;
    color: #333;
    border-bottom: 2px solid #dee2e6;
    text-align: left;
}

.table td {
    padding: 1rem;
    border-bottom: 1px solid #dee2e6;
    vertical-align: middle;
}

.badge {
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-weight: 500;
    color: white;
}

.bg-success {
    background: #4caf50 !important;
}

.bg-danger {
    background: #f44336 !important;
}

.btn-danger {
    background: linear-gradient(to right, #f44336, #e53935);
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 5px;
    transition: all 0.3s ease;
}

.form-label {
    font-weight: 500;
    color: #333;
    margin-bottom: 0.5rem;
}

.row {
    display: flex;
    flex-wrap: wrap;
    margin: -0.5rem;
}

.col-md-6 {
    flex: 0 0 50%;
    padding: 0.5rem;
}

.mb-3 {
    margin-bottom: 1rem;
}

.mb-4 {
    margin-bottom: 1.5rem;
}

.d-flex {
    display: flex;
}

.justify-content-between {
    justify-content: space-between;
}

.align-items-center {
    align-items: center;
}

@media (max-width: 768px) {
    .container {
        padding: 1rem;
    }
    
    .row {
        flex-direction: column;
    }
    
    .col-md-6 {
        width: 100%;
    }
}
</style>

<div class="container">
    <div class="dashboard-header">
        <div class="header-content">
            <h2><i class="fas fa-ticket-alt"></i> 쿠폰 관리</h2>
            <a href="<c:url value='/admin/home'/>" class="btn btn-secondary">
                <i class="fas fa-home"></i> 관리자 홈으로
            </a>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <!-- 쿠폰 생성 폼 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-plus-circle"></i> 새 쿠폰 생성</h5>
                </div>
                <div class="card-body">
                    <form action="<c:url value='/admin/coupon/create'/>" method="post">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">쿠폰명</label>
                                    <input type="text" class="form-control" name="co_name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">할인 금액</label>
                                    <input type="number" class="form-control" name="sale_price" required>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">최소 구매 금액</label>
                                    <input type="number" class="form-control" name="minimum_purchase" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">만료일</label>
                                    <input type="date" class="form-control" name="end_date" required>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus"></i> 쿠폰 생성
                        </button>
                    </form>
                </div>
            </div>

            <!-- 쿠폰 목록 -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-list"></i> 쿠폰 목록</h5>
                </div>
                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>쿠폰 ID</th>
                                <th>쿠폰명</th>
                                <th>할인금액</th>
                                <th>최소구매금액</th>
                                <th>생성일</th>
                                <th>만료일</th>
                                <th>상태</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="coupon" items="${couponList}">
                                <tr>
                                    <td>${coupon.cp_id}</td>
                                    <td>${coupon.co_name}</td>
                                    <td><fmt:formatNumber value="${coupon.sale_price}" type="currency" currencySymbol="₩"/></td>
                                    <td><fmt:formatNumber value="${coupon.minimum_purchase}" type="currency" currencySymbol="₩"/></td>
                                    <td>${coupon.created_date}</td>
                                    <td>${coupon.end_date}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${coupon.end_date < now}">
                                                <span class="badge bg-danger">만료됨</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success">사용가능</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-danger" 
                                                onclick="if(confirm('정말 삭제하시겠습니까?')) deleteCoupon(${coupon.cp_id})">
                                            <i class="fas fa-trash"></i> 삭제
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
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