<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="page-header">
    <h1 class="page-title">마이페이지</h1>
    <p class="page-subtitle">나의 계정 정보와 주문 내역을 확인할 수 있습니다.</p>
</div>

<div class="mypage-container">
    <!-- 사이드바 메뉴 -->
    <div class="mypage-sidebar">
        <div class="mypage-menu">
            <div class="mypage-menu-header">
                마이 금베달
            </div>
            <ul class="mypage-menu-list">
                <li class="mypage-menu-item">
                    <a href="<c:url value='/user/mypage'/>" class="mypage-menu-link active">
                        <i class="fas fa-user"></i>
                        <span>내 정보</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="<c:url value='/user/bookMarkList'/>" class="mypage-menu-link">
                        <i class="fas fa-heart"></i>
                        <span>즐겨찾기</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="<c:url value='/user/viewPay'/>" class="mypage-menu-link">
                        <i class="fas fa-credit-card"></i>
                        <span>결제수단 관리</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="<c:url value='/userstore/viewCart'/>" class="mypage-menu-link">
                        <i class="fas fa-shopping-cart"></i>
                        <span>장바구니</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="#" class="mypage-menu-link">
                        <i class="fas fa-history"></i>
                        <span>주문 내역</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="#" class="mypage-menu-link">
                        <i class="fas fa-ticket-alt"></i>
                        <span>쿠폰함</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="#" class="mypage-menu-link">
                        <i class="fas fa-star"></i>
                        <span>리뷰 관리</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- 카드 등록 영역 -->
    <div class="mypage-content">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title mb-0">결제수단 등록</h3>
            </div>
            <div class="card-body">
                <form:form action="${pageContext.request.contextPath}/user/cardRegister" modelAttribute="userCard" method="post">
                    <div class="form-group">
                        <label for="card_number">카드 번호:</label>
                        <div class="d-flex">
			            <form:input path="card_number_1" class="form-control" maxlength="4" required="true" oninput="moveFocus(this, 'card_number_2')"/>
			            <span>-</span>
			            <form:input path="card_number_2" class="form-control" maxlength="4" required="true" oninput="moveFocus(this, 'card_number_3')"/>
			            <span>-</span>
			            <form:input path="card_number_3" class="form-control" maxlength="4" required="true" oninput="moveFocus(this, 'card_number_4')"/>
			            <span>-</span>
			            <form:input path="card_number_4" class="form-control" maxlength="4" required="true"/>
        				</div>
                    </div>

                    <div class="form-group">
                        <label for="card_holder">카드 소유자명:</label>
                        <form:input path="card_holder" class="form-control"/>
                        <font color="red"><form:errors path="card_holder" /></font>
                    </div>

                    <div class="form-group">
                        <label for="expiry_date">유효기간 (MM/YY):</label>
                        <form:input path="expiry_date" class="form-control" placeholder="MM/YY" maxlength="5"/>
                        <font color="red"><form:errors path="expiry_date" /></font>
                    </div>

                    <div class="form-group">
                        <label for="card_type">카드 종류:</label>
                        <form:select path="card_type" class="form-control">
                            <form:option value="" label="카드 종류 선택"/>
                            <form:option value="Shinhan" label="신한은행"/>
                            <form:option value="Kookmin" label="국민은행"/>
                            <form:option value="Kakao" label="카카오뱅크"/>
                        </form:select>
                        <font color="red"><form:errors path="card_type" /></font>
                    </div>

                    <div class="d-flex justify-content-center mt-4">
                        <button type="submit" class="btn btn-primary">등록하기</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
function moveFocus(currentInput, nextInputId) {
    if (currentInput.value.length === currentInput.maxLength) {
        document.getElementById(nextInputId).focus();
    }
}
</script>