<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>쿠폰 관리</h2>
                <a href="<c:url value='/admin/'/>" class="btn btn-secondary">관리자 홈으로</a>
            </div>

            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">쿠폰 목록</h5>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>쿠폰 ID</th>
                                <th>쿠폰명</th>
                                <th>할인금액</th>
                                <th>최소구매금액</th>
                                <th>생성일</th>
                                <th>만료일</th>
                                <th>발급 현황</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="coupon" items="${couponList}">
                                <tr>
                                    <td>${coupon.cp_id}</td>
                                    <td>${coupon.co_name}</td>
                                    <td><fmt:formatNumber value="${coupon.sale_price}" type="currency" currencySymbol="₩"/></td>
                                    <td><fmt:formatNumber value="${coupon.minimum_purchase}" type="currency" currencySymbol="₩"/></td>
                                    <td><fmt:formatDate value="${coupon.created_date}" pattern="yyyy-MM-dd"/></td>
                                    <td><fmt:formatDate value="${coupon.end_date}" pattern="yyyy-MM-dd"/></td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-info" 
                                                onclick="showCouponUsage(${coupon.cp_id})">발급현황</button>
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

<!-- 쿠폰 발급 현황 모달 -->
<div class="modal fade" id="couponUsageModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">쿠폰 발급 현황</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="couponUsageContent"></div>
            </div>
        </div>
    </div>
</div>

<script>
function showCouponUsage(couponId) {
    $.ajax({
        url: '<c:url value="/admin/coupon/usage"/>' + '?couponId=' + couponId,
        type: 'GET',
        success: function(response) {
            $('#couponUsageContent').html(response);
            $('#couponUsageModal').modal('show');
        }
    });
}
</script>