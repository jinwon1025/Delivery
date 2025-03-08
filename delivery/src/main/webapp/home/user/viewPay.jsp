<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="<c:url value='/css/user/user-card.css'/>">

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

    <!-- 메인 컨텐츠 영역 -->
    <div class="mypage-content">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title mb-0">신용카드 관리</h3>
            </div>
            <div class="card-body">
			<c:choose>
			    <c:when test="${not empty cardList}">
			        <div class="card-list">
			            <c:forEach var="card" items="${cardList}">
			                <div class="payment-card-with-menu">
			                   <div class="payment-card card-${card.card_type}">
			                        <div class="card-chip"></div>
			                        <div class="card-info">
			                            <div class="card-label">카드 종류</div>
			                            <h5 class="card-name">${card.card_type}</h5>
			                            
			                            <div class="card-label">카드 번호</div>
			                            <p class="card-number">**** **** **** ${fn:substring(card.card_number, fn:length(card.card_number) - 4, fn:length(card.card_number))}</p>
			                            
			                            <div class="card-details">
			                                <div>
			                                    <div class="card-label">유효기간</div>
			                                    <p class="card-expiry">${card.expiry_date}</p>
			                                </div>
			                                <div>
			                                    <div class="card-label">카드 소유자</div>
			                                    <p class="card-holder">${card.card_holder}</p>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                    
			                    <%-- 사이드 메뉴 추가  --%>
			                    <div class="card-side-menu">
			                       <a href="javascript:void(0);" onclick="confirmDelete('${card.pay_id}')" class="btn btn-delete">
								   	 <i class="fas fa-trash-alt"></i>
								   </a>
			                    </div>
			                </div>
			            </c:forEach>
			        </div>
			    </c:when>
			    <c:otherwise>
			        <div class="empty-card-container">
			            <div class="empty-card-icon">
			                <i class="fas fa-credit-card"></i>
			            </div>
			            <p class="text-muted">등록된 결제수단이 없습니다.</p>
			        </div>
			    </c:otherwise>
			</c:choose>
                <div class="d-flex justify-content-center mt-4">
                    <a href="<c:url value='/user/payRegister'/>" class="btn btn-primary">결제수단 등록하기</a>
                    <a href="<c:url value='/user/paypassword'/>" class="btn btn-primary">결제비밀번호 관리</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function confirmDelete(payId) {
        if (confirm("정말로 이 카드를 삭제하시겠습니까?")) {
            location.href = "/user/deleteCard?payId=" + payId;
        }
    }
</script>