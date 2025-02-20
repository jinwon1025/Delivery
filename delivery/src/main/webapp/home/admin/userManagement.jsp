<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>회원 관리</h2>
                <a href="<c:url value='/admin/'/>" class="btn btn-secondary">관리자 홈으로</a>
            </div>

            <div class="card">
                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>아이디</th>
                                <th>이름</th>
                                <th>이메일</th>
                                <th>전화번호</th>
                                <th>포인트</th>
                                <th>가입일</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${userList}">
                                <tr>
                                    <td>${user.user_id}</td>
                                    <td>${user.user_name}</td>
                                    <td>${user.email}</td>
                                    <td>${user.user_phone}</td>
                                    <td>${user.point}</td>
                                    <td><fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd"/></td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-primary" 
                                                onclick="showUserDetail('${user.user_id}')">상세</button>
                                        <button type="button" class="btn btn-sm btn-success"
                                                onclick="issueCoupon('${user.user_id}')">쿠폰발급</button>
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

<!-- 유저 상세 정보 모달 -->
<div class="modal fade" id="userDetailModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">회원 상세 정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="userDetailContent"></div>
            </div>
        </div>
    </div>
</div>

<!-- 쿠폰 발급 모달 -->
<div class="modal fade" id="issueCouponModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">쿠폰 발급</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="issueCouponForm">
                    <input type="hidden" id="couponUserId" name="userId">
                    <div class="mb-3">
                        <label class="form-label">발급할 쿠폰 선택</label>
                        <select class="form-select" name="couponId" required>
                            <c:forEach var="coupon" items="${couponList}">
                                <option value="${coupon.cp_id}">${coupon.co_name} (${coupon.sale_price}원)</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">발급하기</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function showUserDetail(userId) {
    $.ajax({
        url: '<c:url value="/admin/user/detail"/>' + '?userId=' + userId,
        type: 'GET',
        success: function(response) {
            $('#userDetailContent').html(response);
            $('#userDetailModal').modal('show');
        }
    });
}

function issueCoupon(userId) {
    $('#couponUserId').val(userId);
    $('#issueCouponModal').modal('show');
}

$('#issueCouponForm').on('submit', function(e) {
    e.preventDefault();
    $.ajax({
        url: '<c:url value="/admin/coupon/issue"/>',
        type: 'POST',
        data: $(this).serialize(),
        success: function(response) {
            alert('쿠폰이 발급되었습니다.');
            $('#issueCouponModal').modal('hide');
        }
    });
});
</script>