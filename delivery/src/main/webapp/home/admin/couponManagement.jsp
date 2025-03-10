<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<h1 class="page-title">쿠폰 관리</h1>
<p class="page-description">할인 쿠폰을 생성하고 관리합니다.</p>

<div class="card mb-4">
	<div class="card-header">
		<h5 class="mb-0">
			<i class="fas fa-plus-circle"></i> 쿠폰 발행
		</h5>
	</div>
	<div class="card-body">
		<!-- 쿠폰 생성 폼 -->
		<form action="<c:url value='/admin/coupon/create'/>" method="post">
			<div class="row mb-3">
				<div class="col-md-6">
					<div class="mb-3">
						<label class="form-label">쿠폰명</label> <input type="text"
							class="form-control" name="cp_name" required>
					</div>
				</div>
				<div class="col-md-6">
					<div class="mb-3">
						<label class="form-label">할인 금액</label> <input type="number"
							class="form-control" name="sale_price" required>
					</div>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-md-6">
					<div class="mb-3">
						<label class="form-label">만료일</label> <input type="date"
							class="form-control" name="expire_date" required>
					</div>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-md-6">
					<div class="mb-3">
						<label class="form-label">사장님 ID</label> <select
							class="form-control" name="owner_id" required>
							<option value="">사장님을 선택하세요</option>
							<c:forEach var="owner" items="${ownerList}">
								<option value="${owner.owner_id}">${owner.owner_id}
									${owner.owner_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-md-6">
					<div class="mb-3">
						<label class="form-label">발행 수량</label> <input type="number"
							class="form-control" name="total_quantity" required>
					</div>
				</div>
			</div>
			<button type="submit" class="btn btn-primary">
				<i class="fas fa-plus"></i> 쿠폰 발행
			</button>
		</form>

		<!-- 쿠폰 목록 -->
		<table class="table">
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
						<td><fmt:formatNumber value="${coupon.sale_price}"
								type="currency" currencySymbol="₩" maxFractionDigits="0" /></td>
						<td>${coupon.owner_id}</td>
						<td>${coupon.issued_date}</td>
						<td>${coupon.expire_date}</td>
						<td>${coupon.total_quantity}</td>
						<td><c:choose>
								<c:when test="${coupon.expire_date < now}">
									<span class="badge bg-danger">만료됨</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-success">사용가능</span>
								</c:otherwise>
							</c:choose></td>
						<td>
							<button type="button" class="btn btn-sm btn-danger"
								onclick="if(confirm('정말 삭제하시겠습니까?')) deleteCoupon(${coupon.owner_coupon_id})">
								<i class="fas fa-trash"></i> 삭제
							</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
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