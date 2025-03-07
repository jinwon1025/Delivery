<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h1 class="page-title">쿠폰 관리</h1>
<p class="page-description">관리자가 생성한 쿠폰을 가게에 적용하고 관리합니다.</p>

<div class="row">
    <!-- 적용 가능한 쿠폰 목록 -->
    <div class="col-md-6">
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
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>쿠폰명</th>
                                    <th>할인금액</th>
                                    <th>최소구매금액</th>
                                    <th>만료일</th>
                                    <th>적용</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="coupon" items="${availableCoupons}">
                                    <tr>
                                        <td>${coupon.cp_name}</td>
                                        <td><fmt:formatNumber value="${coupon.sale_price}" type="currency" currencySymbol="₩" /></td>
                                        <td><fmt:formatNumber value="${coupon.minimum_purchase}" type="currency" currencySymbol="₩" /></td>
                                        <td>${coupon.expire_date}</td>
                                        <td>
                                            <form action="<c:url value='/owner/applyCoupon'/>" method="post">
                                                <div class="d-flex">
                                                    <input type="hidden" name="couponId" value="${coupon.owner_coupon_id}">
                                                    <input type="hidden" name="couponName" value="${coupon.cp_name}">
                                                    <input type="hidden" name="salePrice" value="${coupon.sale_price}">
                                                    <input type="hidden" name="minimumPurchase" value="${coupon.minimum_purchase}">
                                                    <input type="hidden" name="expireDate" value="${coupon.expire_date}">
                                                    <input type="hidden" name="quantity" value="100">
                                                    
                                                    <select class="form-select form-select-sm me-2" name="storeId" required>
                                                        <option value="" selected>가게 선택</option>
                                                        <c:forEach var="store" items="${storeList}">
                                                            <option value="${store.store_id}">${store.store_name}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <button type="submit" class="btn btn-sm btn-primary">
                                                        적용
                                                    </button>
                                                </div>
                                            </form>
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
    
    <!-- 적용된 쿠폰 목록 -->
    <div class="col-md-6">
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-tags"></i> 적용된 쿠폰
                </h5>
            </div>
            <div class="card-body">
                <c:if test="${empty appliedCoupons}">
                    <div class="alert alert-info">
                        적용된 쿠폰이 없습니다.
                    </div>
                </c:if>
                
                <c:if test="${not empty appliedCoupons}">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>가게명</th>
                                    <th>쿠폰명</th>
                                    <th>할인금액</th>
                                    <th>최소구매금액</th>
                                    <th>만료일</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="coupon" items="${appliedCoupons}">
                                    <tr>
                                        <td>${coupon.store_name}</td>
                                        <td>${coupon.cp_name}</td>
                                        <td><fmt:formatNumber value="${coupon.sale_price}" type="currency" currencySymbol="₩" /></td>
                                        <td><fmt:formatNumber value="${coupon.minimum_purchase}" type="currency" currencySymbol="₩" /></td>
                                        <td>${coupon.expire_date}</td>
                                        <td>
                                            <form action="<c:url value='/owner/removeCoupon'/>" method="post" onsubmit="return confirm('정말 이 쿠폰을 삭제하시겠습니까?');">
                                                <input type="hidden" name="couponId" value="${coupon.owner_coupon_id}">
                                                <input type="hidden" name="storeId" value="${coupon.store_id}">
                                                <button type="submit" class="btn btn-sm btn-danger">
                                                    <i class="fas fa-trash"></i> 삭제
                                                </button>
                                            </form>
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