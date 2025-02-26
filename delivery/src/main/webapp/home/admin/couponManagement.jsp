<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h1 class="page-title">쿠폰 관리</h1>
<p class="page-description">할인 쿠폰을 생성하고 관리합니다.</p>

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

<!-- 쿠폰 프리뷰 -->
<div class="card mb-4">
    <div class="card-header">
        <h5 class="mb-0"><i class="fas fa-eye"></i> 쿠폰 미리보기</h5>
    </div>
    <div class="card-body">
        <div class="coupon-card" style="max-width: 550px; margin: 0 auto;">
            <div class="coupon-left">
                <div class="coupon-title">신규 가입자 할인</div>
                <div class="coupon-code">WELCOME2024</div>
                <div class="coupon-expires">유효기간: 2024-04-30</div>
            </div>
            <div class="coupon-right">
                <div class="coupon-amount">15%</div>
            </div>
        </div>
    </div>
</div>

<!-- 쿠폰 목록 -->
<div class="card">
    <div class="card-header">
        <h5 class="mb-0"><i class="fas fa-list"></i> 쿠폰 목록</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
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