<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>배달 웹사이트 관리자</title>

<%-- 공통 CSS 파일 --%>
<link rel="stylesheet" href="<c:url value='/css/common/reset.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/common/typography.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/utilities.css'/>">

<%-- 관리자 CSS 파일 --%>
<link rel="stylesheet"
	href="<c:url value='/css/admin/admin-layout.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/admin/admin-components.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/admin/admin-pages.css'/>">

<%-- Font Awesome --%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
body {
	background-color: #f5f7fa;
	padding: 20px;
}

.admin-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20px;
	background-color: white;
	border-radius: 12px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
	margin-bottom: 20px;
}

.admin-logo {
	display: flex;
	align-items: center;
}

.admin-logo h1 {
	font-size: 1.5rem;
	font-weight: bold;
	margin-left: 10px;
}

.admin-logo img {
	height: 40px;
}

.admin-user {
	display: flex;
	align-items: center;
}

.admin-user img {
	width: 35px;
	height: 35px;
	border-radius: 50%;
	margin-right: 10px;
}

.admin-layout {
	display: flex;
	background-color: transparent;
	border-radius: 12px;
	overflow: hidden;
	min-height: calc(100vh - 150px);
}

.admin-sidebar {
	width: 260px;
	background: linear-gradient(135deg, var(--primary-dark),
		var(--primary-color));
	color: white;
	border-radius: 12px;
	padding: 20px 0;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.admin-menu {
	list-style: none;
	padding: 0;
	margin: 0;
}

.admin-menu-item {
	padding: 15px 20px;
	display: flex;
	align-items: center;
	cursor: pointer;
	transition: all 0.3s ease;
	position: relative;
}

.admin-menu-item:hover {
	background-color: rgba(255, 255, 255, 0.1);
}

.admin-menu-item.active {
	background-color: rgba(255, 255, 255, 0.2);
}

.admin-menu-item.active::before {
	content: '';
	position: absolute;
	left: 0;
	top: 0;
	width: 4px;
	height: 100%;
	background-color: white;
}

.admin-menu-item i {
	margin-right: 15px;
	font-size: 18px;
	width: 24px;
	text-align: center;
}

.admin-content {
	flex: 1;
	background: white;
	border-radius: 12px;
	padding: 25px;
	margin-left: 20px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
	overflow: auto;
}

/* 대시보드 스타일 */
.stat-cards {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
	margin-bottom: 30px;
}

.stat-card {
	position: relative;
	padding: 25px;
	border-radius: 12px;
	background: white;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
	transition: transform 0.3s ease;
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
}

.stat-card:hover {
	transform: translateY(-5px);
}

.stat-icon {
	font-size: 2.5rem;
	color: var(--primary-color);
	margin-bottom: 15px;
}

.stat-title {
	font-weight: 600;
	color: var(--gray-600);
	margin-bottom: 10px;
}

.stat-value {
	font-size: 2.5rem;
	font-weight: 700;
	color: var(--gray-800);
}

.welcome-card {
	background: linear-gradient(135deg, #4568dc, #b06ab3);
	color: white;
	border-radius: 12px;
	padding: 30px;
	margin-bottom: 30px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.welcome-title {
	font-size: 1.8rem;
	font-weight: 700;
	margin-bottom: 10px;
}

.welcome-subtitle {
	font-size: 1.1rem;
	opacity: 0.9;
}

.quick-actions {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 15px;
	margin-top: 30px;
}

.action-card {
	background: white;
	border-radius: 12px;
	padding: 20px;
	text-align: center;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
	transition: all 0.3s ease;
	cursor: pointer;
}

.action-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.action-icon {
	font-size: 2rem;
	color: var(--primary-color);
	margin-bottom: 10px;
}

.action-title {
	font-weight: 600;
	color: var(--gray-800);
}

.page-title {
	font-size: 1.75rem;
	margin-bottom: 5px;
	font-weight: 700;
	color: var(--gray-800);
}

.page-description {
	color: var(--gray-600);
	margin-bottom: 25px;
}

@media ( max-width : 992px) {
	.stat-cards {
		grid-template-columns: repeat(2, 1fr);
	}
	
	.quick-actions {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 768px) {
	.admin-layout {
		flex-direction: column;
	}
	.admin-sidebar {
		width: 100%;
		margin-bottom: 20px;
	}
	.admin-content {
		margin-left: 0;
	}
	.stat-cards {
		grid-template-columns: 1fr;
	}
	
	.quick-actions {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>
	<!-- 관리자 헤더 -->
	<div class="admin-header">
		<div class="admin-logo">
			<i class="fas fa-utensils"
				style="font-size: 1.75rem; color: var(--primary-color);"></i>
			<h1>금베달리스트 관리자</h1>
		</div>
		<div class="admin-user">
			<c:choose>
				<c:when test="${not empty sessionScope.loginUser.image_name}">
					<!-- 프로필 사진이 있을 때 -->
					<img
						src="${pageContext.request.contextPath}/upload/userProfile/${sessionScope.loginUser.image_name}"
						alt="Profile" />
				</c:when>
				<c:otherwise>
					<!-- 프로필 사진이 없을 때 -->
					<i class="fas fa-user-circle"
						style="font-size: 1.75rem; color: var(--gray-500);"></i>
				</c:otherwise>
			</c:choose>
			<span>${sessionScope.loginUser.user_name}님</span> <a
				href="<c:url value='/user/logout'/>"
				class="btn btn-sm btn-secondary ml-3">로그아웃</a>
		</div>
	</div>

	<!-- 관리자 레이아웃 -->
	<div class="admin-layout">
		<!-- 사이드바 -->
		<div class="admin-sidebar">
			<ul class="admin-menu">
				<li
					class="admin-menu-item ${activeMenu eq 'dashboard' ? 'active' : ''}"
					onclick="location.href='<c:url value='/admin/home'/>'"><i
					class="fas fa-tachometer-alt"></i> <span>대시보드</span></li>
				<li
					class="admin-menu-item ${activeMenu eq 'userManagement' ? 'active' : ''}"
					onclick="location.href='<c:url value='/admin/userManagement'/>'">
					<i class="fas fa-users"></i> <span>회원관리</span>
				</li>
				<li
					class="admin-menu-item ${activeMenu eq 'categoryManagement' ? 'active' : ''}"
					onclick="location.href='<c:url value='/admin/categoryManagement'/>'">
					<i class="fas fa-list"></i> <span>카테고리관리</span>
				</li>
				<li
					class="admin-menu-item ${activeMenu eq 'couponManagement' ? 'active' : ''}"
					onclick="location.href='<c:url value='/admin/couponManagement'/>'">
					<i class="fas fa-ticket-alt"></i> <span>쿠폰관리</span>
				</li>
				<li
				    class="admin-menu-item ${activeMenu eq 'pointManagement' ? 'active' : ''}"
				    onclick="location.href='<c:url value='/admin/pointManagement'/>'">
				    <i class="fas fa-coins"></i> <span>포인트관리</span>
				</li>
				<!-- 공지사항 관리 메뉴 추가 -->
				<li
					class="admin-menu-item ${activeMenu eq 'userNotice' ? 'active' : ''}"
					onclick="location.href='<c:url value='/admin/userNotice'/>'">
					<i class="fas fa-bullhorn"></i> <span>사용자 공지사항</span>
				</li>
				<li
					class="admin-menu-item ${activeMenu eq 'ownerNotice' ? 'active' : ''}"
					onclick="location.href='<c:url value='/admin/ownerNotice'/>'">
					<i class="fas fa-clipboard-list"></i> <span>사업자 공지사항</span>
				</li>
			</ul>
		</div>

		<!-- 컨텐츠 영역 -->
		<div class="admin-content">
			<c:choose>
				<c:when test="${activeMenu eq 'dashboard'}">
					<!-- 대시보드 내용 -->
					<div class="welcome-card">
						<h1 class="welcome-title">${sessionScope.loginUser.user_name}님, 환영합니다!</h1>
						<p class="welcome-subtitle">금베달리스트 관리자 대시보드에서 웹사이트의 주요 정보를 확인하세요.</p>
					</div>

					<div class="stat-cards">
						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-users"></i>
							</div>
							<div class="stat-title">전체 회원</div>
							<div class="stat-value">${userCount != null ? userCount : '0'}</div>
						</div>

						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-shopping-bag"></i>
							</div>
							<div class="stat-title">주문 건수</div>
							<div class="stat-value">${orderCount != null ? orderCount : '0'}</div>
						</div>

						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-ticket-alt"></i>
							</div>
							<div class="stat-title">쿠폰 사용</div>
							<div class="stat-value">${usedCouponCount != null ? usedCouponCount : '0'}</div>
						</div>
					</div>

					<h2 class="page-title">빠른 관리 메뉴</h2>
					<p class="page-description">자주 사용하는 기능에 빠르게 접근하세요.</p>
					
					<div class="quick-actions">
						<div class="action-card" onclick="location.href='<c:url value='/admin/userManagement'/>'">
							<div class="action-icon"><i class="fas fa-user-plus"></i></div>
							<div class="action-title">회원 관리</div>
						</div>
						<div class="action-card" onclick="location.href='<c:url value='/admin/couponManagement'/>'">
							<div class="action-icon"><i class="fas fa-tags"></i></div>
							<div class="action-title">쿠폰 발행</div>
						</div>
						<div class="action-card" onclick="location.href='<c:url value='/admin/userNotice'/>'">
							<div class="action-icon"><i class="fas fa-bullhorn"></i></div>
							<div class="action-title">공지사항 등록</div>
						</div>
						<div class="action-card" onclick="location.href='<c:url value='/admin/pointManagement'/>'">
							<div class="action-icon"><i class="fas fa-coins"></i></div>
							<div class="action-title">포인트 관리</div>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<!-- 다른 관리 페이지 내용 -->
					<jsp:include page="${contentPage}" />
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>