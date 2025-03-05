<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>가게 관리 - 금베달리스트</title>

<!-- 공통 CSS 파일 -->
<link rel="stylesheet" href="<c:url value='/css/common/reset.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/common/typography.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/utilities.css'/>">

<!-- 사업자 CSS 파일 -->
<link rel="stylesheet"
	href="<c:url value='/css/store/store-layout.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/store/store-components.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/store/store-pages.css'/>">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- Google Fonts - Noto Sans KR -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
</head>
<body>
	<!-- 헤더 영역 -->
	<header class="store-header">
		<div class="header-container">
			<div class="logo-area">
				<a href="<c:url value='/owner/index'/>" class="site-logo"> <i
					class="fas fa-medal"></i> <span class="logo-text">금베달리스트</span>
				</a>
			</div>

			<div class="owner-account">
				<c:choose>
					<c:when test="${sessionScope.loginOwner != null}">
						<div class="owner-info">
							<c:choose>
								<c:when test="${not empty sessionScope.loginOwner.image_name}">
									<img class="profile-pic"
										src="${pageContext.request.contextPath}/upload/ownerProfile/${sessionScope.loginOwner.image_name}"
										alt="프로필 이미지" />
								</c:when>
								<c:otherwise>
									<img class="profile-pic"
										src="${pageContext.request.contextPath}/image/noImage.png"
										alt="기본 이미지" />
								</c:otherwise>
							</c:choose>
							<span class="username">${sessionScope.loginOwner.name}님</span>
						</div>
						<a href="<c:url value='/owner/myPage'/>" title="마이페이지"> <i
							class="fas fa-user-circle icon-link"></i>
						</a>
						<a href="<c:url value='/owner/logout'/>" title="로그아웃"> <i
							class="fas fa-sign-out-alt icon-link"></i>
						</a>
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/owner/goLogin'/>"
							class="btn btn-sm btn-primary">로그인</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</header>

	<!-- 현재 관리 중인 가게 정보 -->
	<div class="store-banner bg-gradient-gold text-white p-4 mb-4">
		<div
			class="container d-flex justify-content-between align-items-center">
			<div>
				<h1 class="font-bold">${sessionScope.currentStore.store_name}</h1>
				<p class="text-sm opacity-90">${sessionScope.currentStore.store_id}</p>
			</div>
			<a href="<c:url value='/store/storeList'/>" class="btn btn-white">
				<i class="fas fa-store mr-1"></i> 다른 가게 선택
			</a>
		</div>
	</div>

	<!-- 네비게이션 -->
	<nav class="store-nav mb-4">
		<div class="nav-container">
			<div class="nav-menu">
				<a href="<c:url value='/store/menuManager'/>"
					class="nav-item ${fn:contains(pageContext.request.requestURI, 'menu') ? 'active' : ''}">
					<i class="fas fa-utensils mr-2"></i> 메뉴 관리
				</a> <span class="nav-divider">|</span> <a href="#"
					class="nav-item ${fn:contains(pageContext.request.requestURI, 'order') ? 'active' : ''}">
					<i class="fas fa-clipboard-list mr-2"></i> 주문 목록
				</a> <span class="nav-divider">|</span> <a href="#"
					class="nav-item ${fn:contains(pageContext.request.requestURI, 'review') ? 'active' : ''}">
					<i class="fas fa-star mr-2"></i> 리뷰 관리
				</a> <span class="nav-divider">|</span> <a
					href="<c:url value='/store/goStoreModify'/>"
					class="nav-item ${fn:contains(pageContext.request.requestURI, 'Modify') ? 'active' : ''}">
					<i class="fas fa-edit mr-2"></i> 가게 정보 수정
				</a> <span class="nav-divider">|</span> <a href="#"
					class="nav-item ${fn:contains(pageContext.request.requestURI, 'coupon') ? 'active' : ''}">
					<i class="fas fa-ticket-alt mr-2"></i> 쿠폰 등록
				</a>
			</div>
		</div>
	</nav>

	<!-- 메인 컨텐츠 -->
	<main class="main-content">
		<div class="store-container">
			<c:choose>
				<c:when test="${BODY != null}">
					<jsp:include page="${BODY}" />
				</c:when>
				<c:otherwise>
					<!-- 가게 대시보드 -->
					<div class="dashboard-section">
						<h2 class="section-title">가게 대시보드</h2>

						<div class="dashboard-stats">
							<div class="stat-card">
								<div class="stat-icon">
									<i class="fas fa-shopping-cart"></i>
								</div>
								<div class="stat-value">0</div>
								<div class="stat-label">오늘 주문</div>
							</div>

							<div class="stat-card">
								<div class="stat-icon">
									<i class="fas fa-utensils"></i>
								</div>
								<div class="stat-value">0</div>
								<div class="stat-label">메뉴 수</div>
							</div>

							<div class="stat-card">
								<div class="stat-icon">
									<i class="fas fa-star"></i>
								</div>
								<div class="stat-value">0.0</div>
								<div class="stat-label">평균 평점</div>
							</div>

							<div class="stat-card">
								<div class="stat-icon">
									<i class="fas fa-won-sign"></i>
								</div>
								<div class="stat-value">0</div>
								<div class="stat-label">오늘 매출</div>
							</div>
						</div>
					</div>

					<!-- 빠른 메뉴 접근 -->
					<div class="dashboard-section">
						<h2 class="section-title">빠른 메뉴</h2>

						<div class="row mt-4">
							<div class="col-3">
								<a href="<c:url value='/store/menuManager'/>"
									class="card text-center p-4 h-100">
									<div class="text-primary mb-3">
										<i class="fas fa-utensils" style="font-size: 3rem;"></i>
									</div>
									<h3 class="card-title">메뉴 관리</h3>
									<p class="text-sm text-muted mt-2">메뉴와 옵션을 관리합니다</p>
								</a>
							</div>

							<div class="col-3">
								<a href="#" class="card text-center p-4 h-100">
									<div class="text-primary mb-3">
										<i class="fas fa-clipboard-list" style="font-size: 3rem;"></i>
									</div>
									<h3 class="card-title">주문 목록</h3>
									<p class="text-sm text-muted mt-2">들어온 주문을 확인합니다</p>
								</a>
							</div>

							<div class="col-3">
								<a href="<c:url value='/store/goStoreModify'/>"
									class="card text-center p-4 h-100">
									<div class="text-primary mb-3">
										<i class="fas fa-edit" style="font-size: 3rem;"></i>
									</div>
									<h3 class="card-title">가게 정보</h3>
									<p class="text-sm text-muted mt-2">가게 정보를 수정합니다</p>
								</a>
							</div>

							<div class="col-3">
								<a href="#" class="card text-center p-4 h-100">
									<div class="text-primary mb-3">
										<i class="fas fa-chart-line" style="font-size: 3rem;"></i>
									</div>
									<h3 class="card-title">매출 통계</h3>
									<p class="text-sm text-muted mt-2">매출 통계를 확인합니다</p>
								</a>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</main>

	<!-- 푸터 영역 -->
	<footer class="store-footer">
		<div class="footer-container">
			<div class="footer-column">
				<h3 class="footer-title">금베달리스트</h3>
				<p>최고의 음식을 가장 빠르게 배달해 드립니다.</p>
				<div class="footer-social">
					<a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
					<a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
					<a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
				</div>
			</div>

			<div class="footer-column">
				<h3 class="footer-title">바로가기</h3>
				<ul class="footer-links">
					<li class="footer-link"><a
						href="<c:url value='/store/storeList'/>">매장 목록</a></li>
					<li class="footer-link"><a
						href="<c:url value='/store/goRegister'/>">매장 등록</a></li>
					<li class="footer-link"><a
						href="<c:url value='/owner/notice'/>">공지사항</a></li>
					<li class="footer-link"><a
						href="<c:url value='/owner/myPage'/>">마이페이지</a></li>
				</ul>
			</div>

			<div class="footer-column">
				<h3 class="footer-title">고객센터</h3>
				<div class="footer-contact">
					<i class="fas fa-phone"></i>
					<div>
						<p>1544-9999</p>
						<p>평일 09:00 - 18:00</p>
					</div>
				</div>
				<div class="footer-contact">
					<i class="fas fa-envelope"></i>
					<div>
						<p>partner@goldmedalist.com</p>
					</div>
				</div>
			</div>
		</div>

		<div class="footer-bottom">
			<p>&copy; 2025 금베달리스트. All Rights Reserved.</p>
		</div>
	</footer>

	<!-- JavaScript -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
        // 페이지 로드 시 실행될 JavaScript 코드
        $(document).ready(function() {
            // 공통 기능 구현
        });
    </script>
</body>
</html>