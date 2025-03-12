<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="page-header">
	<h1 class="page-title">마이페이지</h1>
	<p class="page-subtitle">나의 계정 정보와 주문 내역을 확인할 수 있습니다.</p>
</div>

<div class="mypage-container">
	<!-- 사이드바 메뉴 -->
	<div class="mypage-sidebar">
		<div class="mypage-menu">
			<div class="mypage-menu-header">마이 금베달</div>
			<ul class="mypage-menu-list">
				<li class="mypage-menu-item"><a
					href="<c:url value='/user/mypage'/>"
					class="mypage-menu-link ${activeMenu eq 'mypage' || empty activeMenu ? 'active' : ''}">
						<i class="fas fa-user"></i> <span>내 정보</span>
				</a></li>
				<li class="mypage-menu-item"><a
					href="<c:url value='/user/mypage/bookMarkList'/>"
					class="mypage-menu-link ${activeMenu eq 'bookMarkList' ? 'active' : ''}">
						<i class="fas fa-heart"></i> <span>즐겨찾기</span>
				</a></li>
				<li class="mypage-menu-item"><a
					href="<c:url value='/user/viewPay'/>"
					class="mypage-menu-link ${activeMenu eq 'viewPay' ? 'active' : ''}">
						<i class="fas fa-credit-card"></i> <span>결제수단 관리</span>
				</a></li>
				<li class="mypage-menu-item"><a
					href="<c:url value='/userstore/mypage/viewCart'/>"
					class="mypage-menu-link ${activeMenu eq 'viewCart' ? 'active' : ''}">
						<i class="fas fa-shopping-cart"></i> <span>장바구니</span>
				</a></li>
				<li class="mypage-menu-item"><a
					href="<c:url value='/userstore/myOrderList'/>"
					class="mypage-menu-link ${activeMenu eq 'myOrderList' ? 'active' : ''}">
						<i class="fas fa-history"></i> <span>주문 내역</span>
				</a></li>
				<li class="mypage-menu-item"><a href="#"
					class="mypage-menu-link"> <i class="fas fa-ticket-alt"></i> <span>쿠폰함</span>
				</a></li>
				<li class="mypage-menu-item"><a
					href="<c:url value='/userstore/myReviewList'/>"
					class="mypage-menu-link ${activeMenu eq 'myReviewList' ? 'active' : ''}">
						<i class="fas fa-star"></i> <span>리뷰 관리</span>
				</a></li>
			</ul>
		</div>
	</div>

	<!-- 메인 컨텐츠 영역 -->
	<div class="mypage-content">
		<c:choose>
			<c:when test="${contentPage eq 'bookMarkList'}">
				<%@ include file="mypage-bookmarkList.jsp"%>
			</c:when>
			<c:when test="${contentPage eq 'viewPay'}">
				<%@ include file="viewPay.jsp"%>
			</c:when>
			<c:when test="${contentPage eq 'viewCart'}">
				<%@ include file="../userstore/mypage-userCart.jsp"%>
			</c:when>
			<c:when test="${contentPage eq 'myOrderList'}">
				<%@ include file="../userstore/myOrderList.jsp"%>
			</c:when>
			<c:when test="${contentPage eq 'myReviewList'}">
				<%@ include file="../userstore/reviewList.jsp"%>
			</c:when>
			<c:otherwise>
				<!-- 기본 내 정보 표시 -->
				<div class="card">
					<div class="card-header">
						<h3 class="card-title mb-0">내 정보</h3>
					</div>
					<div class="card-body">
						<div class="d-flex align-items-center mb-4">
							<div class="mr-4">
								<c:choose>
									<c:when test="${not empty userInfo.image_name}">
										<img
											src="${pageContext.request.contextPath}/upload/userProfile/${userInfo.image_name}"
											alt="프로필 이미지" class="rounded-circle"
											style="width: 100px; height: 100px; object-fit: cover;" />
									</c:when>
									<c:otherwise>
										<img
											src="${pageContext.request.contextPath}/image/noImage.png"
											alt="기본 이미지" class="rounded-circle"
											style="width: 100px; height: 100px; object-fit: cover;" />
									</c:otherwise>
								</c:choose>
							</div>
							<div>
								<h4 class="mb-2">${userInfo.user_name}님</h4>
								<p class="text-muted mb-0">${userInfo.email}</p>
							</div>
						</div>

						<table class="table">
							<tr>
								<th style="width: 30%">아이디</th>
								<td>${userInfo.user_id}</td>
							</tr>
							<tr>
								<th>이름</th>
								<td>${userInfo.user_name}</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td>${userInfo.password}</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>${userInfo.user_phone}</td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td>${userInfo.birth}</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>${userInfo.email}</td>
							</tr>
							<tr>
								<th>주소</th>
								<td>${userInfo.user_address}</td>
							</tr>
							<c:if test="${not empty userInfo.point}">
								<tr>
									<th>포인트</th>
									<td><span class="text-primary font-bold">${userInfo.point}</span>
										P</td>
								</tr>
							</c:if>
						</table>

						<div class="d-flex justify-content-center mt-4">
							<a href="<c:url value='/user/updateForm'/>"
								class="btn btn-primary mr-2">회원정보 수정</a> <A
								href="<c:url value='/user/index'/>" class="btn btn-outline-gold">홈으로</a>
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<!-- AJAX 네비게이션 스크립트 -->
<script>
// 마이페이지 메뉴 클릭 이벤트 처리
document.addEventListener('DOMContentLoaded', function() {
    // 사이드바 메뉴의 모든 링크 요소 가져오기
    const menuLinks = document.querySelectorAll('.mypage-menu-link');
    
    // 각 링크에 클릭 이벤트 추가
    menuLinks.forEach(link => {
        // '#' 링크인 경우(쿠폰함) 제외 (구현되지 않은 메뉴)
        if (link.getAttribute('href') === '#') {
            return;
        }
        
        link.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 링크 동작 방지
            
            // 활성 클래스 관리
            menuLinks.forEach(item => item.classList.remove('active'));
            this.classList.add('active');
            
            // 클릭된 링크의 URL 가져오기
            const url = this.getAttribute('href');
            
            // URL 히스토리 업데이트 (새로고침 없이 URL 변경)
            history.pushState({}, '', url);
            
            // 새 페이지 로드
            window.location.href = url;
        });
    });
});
</script>