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
	
<!-- 네비게이션 화살표 스타일 -->
<style>
/* 스크롤바 숨기기 */
.nav-menu-wrapper::-webkit-scrollbar {
    display: none;
}

/* 화살표 활성화 스타일 */
.nav-arrow.active {
    display: flex !important;
    align-items: center;
    justify-content: center;
}

.nav-arrow:hover {
    background: #fff !important;
    color: #222 !important;
    box-shadow: 0 3px 10px rgba(0,0,0,0.2) !important;
}

/* 네비게이션 아이템 스타일 고정 */
.nav-menu a.nav-item, .nav-menu span.nav-divider {
    display: inline-block !important;
    flex-shrink: 0 !important;
    flex-grow: 0 !important;
    white-space: nowrap !important;
}

/* 기존 스타일 덮어쓰기 (필요시) */
.nav-menu {
    flex-wrap: nowrap !important;
    display: flex !important;
}

/* 활성 메뉴 아이템 스타일 */
.nav-item.active {
    font-weight: bold;
}
</style>
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
		<div class="nav-container" style="display: flex; align-items: center; position: relative; max-width: 1200px; margin: 0 auto; padding: 0; height: 50px;">
			<button class="nav-arrow nav-prev" id="navPrev" style="position: absolute; left: 0; z-index: 100; display: none; background: rgba(255, 255, 255, 0.9); border: none; border-radius: 50%; width: 36px; height: 36px; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,0.15); color: #666; transition: all 0.2s ease; margin-left: 5px;">
				<i class="fas fa-chevron-left"></i>
			</button>
			<div class="nav-menu-wrapper" style="flex: 1; overflow-x: auto; overflow-y: hidden; position: relative; scrollbar-width: none; -ms-overflow-style: none; scroll-behavior: smooth;">
				<div class="nav-menu" id="navMenu" style="display: flex; flex-wrap: nowrap; white-space: nowrap; padding: 0 50px;">
					<a href="<c:url value='/user/categoryStores'/>"
						class="nav-item ${empty param.categoryId ? 'active' : ''}" style="flex: 0 0 auto; padding: 12px 15px; display: inline-block;">전체보기</a>

					<c:forEach var="category" items="${maincategoryList}"
						varStatus="status">
						<a href="<c:url value='/user/categoryStores?categoryId=${category.main_category_id}'/>"
							class="nav-item ${param.categoryId eq category.main_category_id ? 'active' : ''}" 
							style="flex: 0 0 auto; padding: 12px 15px; display: inline-block;"
							data-category-id="${category.main_category_id}">
							${category.main_category_name}
						</a>
						<c:if test="${!status.last}">
							<span class="nav-divider" style="flex: 0 0 auto; padding: 12px 5px; display: inline-block;">|</span>
						</c:if>
					</c:forEach>
				</div>
			</div>
			<button class="nav-arrow nav-next" id="navNext" style="position: absolute; right: 0; z-index: 100; display: none; background: rgba(255, 255, 255, 0.9); border: none; border-radius: 50%; width: 36px; height: 36px; cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,0.15); color: #666; transition: all 0.2s ease; margin-right: 5px;">
				<i class="fas fa-chevron-right"></i>
			</button>
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
            
            // 네비게이션 화살표 기능
            const navMenu = document.getElementById('navMenu');
            const navWrapper = navMenu.parentElement;
            const navPrev = document.getElementById('navPrev');
            const navNext = document.getElementById('navNext');
            
            // 현재 활성화된 카테고리 ID 저장 (URL에서 가져옴)
            const urlParams = new URLSearchParams(window.location.search);
            const currentCategoryId = urlParams.get('categoryId');
            
            // 좌우 화살표 표시 여부 확인 함수
            function checkNavArrows() {
                const isScrollable = navWrapper.scrollWidth > navWrapper.clientWidth;
                
                if (isScrollable) {
                    // 왼쪽 화살표 표시 여부
                    if (navWrapper.scrollLeft > 0) {
                        navPrev.classList.add('active');
                    } else {
                        navPrev.classList.remove('active');
                    }
                    
                    // 오른쪽 화살표 표시 여부
                    if (navWrapper.scrollLeft + navWrapper.clientWidth < navWrapper.scrollWidth - 10) {
                        navNext.classList.add('active');
                    } else {
                        navNext.classList.remove('active');
                    }
                } else {
                    // 스크롤이 필요 없으면 화살표 숨기기
                    navPrev.classList.remove('active');
                    navNext.classList.remove('active');
                }
            }
            
            // 활성 메뉴로 스크롤하는 함수
            function scrollToActiveMenu() {
                const activeItem = document.querySelector('.nav-item.active');
                if (activeItem) {
                    // 활성 메뉴가 있다면 해당 위치로 스크롤 (약간의 왼쪽 여백 추가)
                    const leftOffset = activeItem.offsetLeft - 60;
                    navWrapper.scrollLeft = Math.max(0, leftOffset);
                }
            }
            
            // 페이지 로드 시 스크롤 위치 복원 (sessionStorage 사용)
            function restoreScrollPosition() {
                // 현재 페이지 URL과 카테고리 ID를 키로 사용
                const pageUrl = window.location.pathname;
                const categoryId = urlParams.get('categoryId') || 'all';
                const storageKey = `navScrollPosition_${pageUrl}_${categoryId}`;
                
                const savedPosition = sessionStorage.getItem(storageKey);
                if (savedPosition) {
                    navWrapper.scrollLeft = parseInt(savedPosition, 10);
                } else {
                    // 저장된 위치가 없으면 활성 메뉴로 스크롤
                    scrollToActiveMenu();
                }
            }
            
            // 스크롤 위치 저장
            function saveScrollPosition() {
                // 현재 페이지 URL과 카테고리 ID를 키로 사용
                const pageUrl = window.location.pathname;
                const categoryId = urlParams.get('categoryId') || 'all';
                const storageKey = `navScrollPosition_${pageUrl}_${categoryId}`;
                
                sessionStorage.setItem(storageKey, navWrapper.scrollLeft);
            }
            
            // 네비게이션 메뉴 항목 클릭 이벤트
            const navItems = navMenu.querySelectorAll('.nav-item');
            navItems.forEach(item => {
                item.addEventListener('click', function() {
                    // 클릭한 항목의 위치 저장
                    saveScrollPosition();
                });
            });
            
            // 초기 화살표 상태 확인
            setTimeout(() => {
                checkNavArrows();
                restoreScrollPosition();
            }, 100);
            
            // 왼쪽 화살표 클릭 이벤트
            navPrev.addEventListener('click', function() {
                navWrapper.scrollBy({
                    left: -200,
                    behavior: 'smooth'
                });
                setTimeout(checkNavArrows, 300);
            });
            
            // 오른쪽 화살표 클릭 이벤트
            navNext.addEventListener('click', function() {
                navWrapper.scrollBy({
                    left: 200,
                    behavior: 'smooth'
                });
                setTimeout(checkNavArrows, 300);
            });
            
            // 스크롤 이벤트
            navWrapper.addEventListener('scroll', function() {
                checkNavArrows();
            });
            
            // 윈도우 리사이즈 이벤트
            window.addEventListener('resize', function() {
                checkNavArrows();
            });
        });
    </script>
</body>
</html>