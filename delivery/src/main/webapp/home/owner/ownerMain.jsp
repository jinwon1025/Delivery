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
<title>금베달리스트 사업자</title>

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
						<a href="<c:url value='/owner/goRegister'/>"
							class="btn btn-sm btn-outline-gold">회원가입</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</header>

	<!-- 네비게이션 -->
	<nav class="store-nav">
		<div class="nav-container">
			<div class="nav-menu">
				<a href="<c:url value='/store/storeList'/>"
					class="nav-item ${fn:contains(pageContext.request.requestURI, 'storeList') ? 'active' : ''}">매장
					목록</a> <span class="nav-divider">|</span> <a
					href="<c:url value='/store/goRegister'/>"
					class="nav-item ${fn:contains(pageContext.request.requestURI, 'goRegister') ? 'active' : ''}">매장
					등록</a> <span class="nav-divider">|</span> <a
					href="<c:url value='/owner/notice'/>"
					class="nav-item ${fn:contains(pageContext.request.requestURI, 'notice') ? 'active' : ''}">공지사항</a>
				<a href="<c:url value='/owner/couponManagement'/>"
					class="nav-item ${fn:contains(pageContext.request.requestURI, 'couponManagement') ? 'active' : ''}">쿠폰관리</a>
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
					<!-- 기본 내용 (사업자 환영 섹션) -->
					<div class="owner-welcome">
						<div class="welcome-content">
							<h1 class="welcome-title">금베달리스트 사업자 센터</h1>
							<p class="welcome-subtitle">가게 등록, 메뉴 관리, 주문 처리를 한 곳에서 편리하게
								관리하세요. 더 많은 고객에게 맛있는 음식을 배달할 수 있습니다.</p>
							<a href="<c:url value='/store/goRegister'/>" class="welcome-btn">
								<i class="fas fa-store mr-2"></i> 매장 등록하기
							</a>
						</div>
					</div>

					<!-- 사업자 기능 설명 섹션 -->
					<div class="section-title">
						<h2>사업자 주요 기능</h2>
					</div>

					<div class="stats-cards mb-5">
						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-store"></i>
							</div>
							<div class="stat-value">매장 등록</div>
							<p class="stat-description mt-3">귀하의 매장을 등록하고 고객들에게 노출시키세요.
								위치, 영업 시간, 메뉴 정보를 쉽게 관리할 수 있습니다.</p>
						</div>

						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-utensils"></i>
							</div>
							<div class="stat-value">메뉴 관리</div>
							<p class="stat-description mt-3">메뉴를 쉽게 추가하고 편집하세요. 가격, 옵션,
								사진을 관리하고 메뉴 카테고리를 구성할 수 있습니다.</p>
						</div>

						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-clipboard-list"></i>
							</div>
							<div class="stat-value">주문 관리</div>
							<p class="stat-description mt-3">실시간으로 들어오는 주문을 확인하고 관리하세요.
								주문 상태를 업데이트하고 배달 상황을 추적할 수 있습니다.</p>
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