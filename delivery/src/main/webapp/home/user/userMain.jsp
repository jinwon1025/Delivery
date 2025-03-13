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
<title>금베달리스트 - 배달 웹사이트</title>

<!-- 공통 CSS 파일 -->
<link rel="stylesheet" href="<c:url value='/css/common/reset.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/common/typography.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/utilities.css'/>">

<!-- 사용자 CSS 파일 -->
<link rel="stylesheet" href="<c:url value='/css/user/user-layout.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/user/user-components.css'/>">
<link rel="stylesheet" href="<c:url value='/css/user/user-pages.css'/>">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- Google Fonts - Noto Sans KR -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
</head>
<body>
	<!-- 헤더 영역 -->
	<header class="user-header">
		<div class="header-container">
			<div class="logo-area">
				<a href="<c:url value='/user/index'/>" class="site-logo"> <i
					class="fas fa-medal"></i> <span class="logo-text">금베달리스트</span>
				</a>
			</div>

			<div class="user-account">
				<c:choose>
					<c:when test="${sessionScope.loginUser != null}">
						<div class="user-info">
							<c:choose>
								<c:when test="${not empty sessionScope.loginUser.image_name}">
									<img class="profile-pic"
										src="${pageContext.request.contextPath}/upload/userProfile/${sessionScope.loginUser.image_name}"
										alt="프로필 이미지" />
								</c:when>
								<c:otherwise>
									<img class="profile-pic"
										src="${pageContext.request.contextPath}/image/noImage.png"
										alt="기본 이미지" />
								</c:otherwise>
							</c:choose>
							<span class="username">${sessionScope.loginUser.user_name}님</span>
						</div>

						<a href="<c:url value='/user/notice'/>" title="공지사항"> <i
							class="fas fa-bullhorn icon-link"></i>
						</a>
						<a href="<c:url value='/user/mypage'/>" title="마이페이지"> <i
							class="fas fa-user-circle icon-link"></i>
						</a>
						<a href="<c:url value='/userstore/viewCart'/>" title="장바구니"
							class="icon-link cart"> <i class="fas fa-shopping-cart"></i>
							<!-- 장바구니에 상품이 있는 경우 카운트 표시 --> <c:if test="${cartCount > 0}">
								<span class="cart-count">${cartCount}</span>
							</c:if>
						</a>
						<a href="<c:url value='/user/bookMarkList'/>" title="즐겨찾기"
							class="icon-link favorite"> <i class="fas fa-heart"></i>
						</a>
						<a href="<c:url value='/user/logout'/>" title="로그아웃"> <i
							class="fas fa-sign-out-alt icon-link"></i>
						</a>
					</c:when>
					<c:otherwise>
						<a href="<c:url value='/user/loginForm'/>"
							class="btn btn-sm btn-primary">로그인</a>
						<a href="/user/register"
							class="btn btn-sm btn-outline-gold">회원가입</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</header>

	<!-- 네비게이션 -->
	<nav class="user-nav">
		<div class="nav-container">
			<div class="nav-menu">
				<a href="<c:url value='/user/categoryStores'/>"
					class="nav-item ${empty param.categoryId ? 'active' : ''}">전체보기</a>

				<c:forEach var="category" items="${maincategoryList}"
					varStatus="status">
					<a
						href="<c:url value='/user/categoryStores?categoryId=${category.main_category_id}'/>"
						class="nav-item ${param.categoryId eq category.main_category_id ? 'active' : ''}">
						${category.main_category_name} </a>
					<c:if test="${!status.last}">
						<span class="nav-divider">|</span>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</nav>

	<!-- 메인 컨텐츠 -->
	<main class="main-content">
		<div class="container">
			<c:choose>
				<c:when test="${BODY != null}">
					<jsp:include page="${BODY}" />
				</c:when>
				<c:otherwise>
					<!-- 로그인되지 않은 상태라면 로그인 폼 표시 -->
					<c:if test="${sessionScope.loginUser == null}">
						<div class="auth-container">
							<div class="auth-header">
								<h2 class="auth-title">로그인</h2>
								<p class="auth-subtitle">금베달리스트 서비스를 이용하려면 로그인해주세요</p>
							</div>

							<div class="auth-form">
								<form:form action="/user/login" method="post"
									modelAttribute="loginUser">
									<div class="form-group">
										<label for="id" class="form-label">아이디</label>
										<form:input path="user_id" id="id" class="form-control"
											placeholder="아이디를 입력하세요" />
										<font color="red"><form:errors path="user_id" /></font>
									</div>

									<div class="form-group">
										<label for="password" class="form-label">비밀번호</label>
										<form:password path="password" id="password"
											class="form-control" placeholder="비밀번호를 입력하세요" />
										<font color="red"><form:errors path="password" /></font>
									</div>

									<button type="submit" class="btn-auth">로그인</button>
								</form:form>
							</div>

							<div class="auth-footer">
								<p>
									계정이 없으신가요? <a href="<c:url value='/user/register'/>"
										class="auth-link">회원가입</a>
								</p>
							</div>

							<c:if test="${BBODY != null}">
								<jsp:include page="${BBODY}" />
							</c:if>
						</div>
					</c:if>
				</c:otherwise>
			</c:choose>
		</div>
	</main>

	<!-- 푸터 영역 -->
	<footer class="user-footer">
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
					<li class="footer-link"><a href="<c:url value='/user/index'/>">홈</a></li>
					<li class="footer-link"><a
						href="<c:url value='/user/categoryStores'/>">전체 가게</a></li>
					<li class="footer-link"><a
						href="<c:url value='/user/notice'/>">공지사항</a></li>
					<li class="footer-link"><a
						href="<c:url value='/user/mypage'/>">마이페이지</a></li>
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
						<p>support@goldmedalist.com</p>
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