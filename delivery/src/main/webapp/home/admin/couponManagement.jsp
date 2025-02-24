<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<!-- 임시 css -->

<style>
.container {
    padding: 20px;
}

.card {
    margin-bottom: 20px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.card-header {
    background-color: #f8f9fa;
    padding: 15px;
}

.card-body {
    padding: 20px;
}

.table {
    margin-top: 10px;
}

.table th {
    background-color: #f8f9fa;
    border-bottom: 2px solid #dee2e6;
}

.table td {
    vertical-align: middle;
}

.btn-primary {
    background-color: #0d6efd;
    border: none;
    padding: 8px 16px;
}

.btn-secondary {
    background-color: #6c757d;
    border: none;
    padding: 8px 16px;
}

.btn-danger {
    padding: 4px 8px;
}

.form-label {
    font-weight: 500;
    margin-bottom: 8px;
}

.form-control {
    padding: 8px 12px;
    border-radius: 4px;
    border: 1px solid #dee2e6;
}

.badge {
    padding: 6px 10px;
    font-weight: normal;
}

.mb-4 {
    margin-bottom: 1.5rem;
}

.table th, .table td {
    padding: 12px;
}

.btn:hover {
    opacity: 0.9;
}
</style>








<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>쿠폰 관리</h2>
                <a href="<c:url value='/admin/home'/>" class="btn btn-secondary">관리자 홈으로</a>
            </div>

            <!-- 쿠폰 생성 폼 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">새 쿠폰 생성</h5>
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
                        <button type="submit" class="btn btn-primary">쿠폰 생성</button>
                    </form>
                </div>
            </div>

            <!-- 쿠폰 목록 -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">쿠폰 목록</h5>
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
                                                onclick="if(confirm('정말 삭제하시겠습니까?')) deleteCoupon(${coupon.cp_id})">삭제</button>
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