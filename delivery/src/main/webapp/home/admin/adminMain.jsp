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
}

.stat-card:hover {
	transform: translateY(-5px);
}

.stat-value {
	font-size: 2rem;
	font-weight: 700;
	margin: 10px 0;
}

.widget-container {
	margin-top: 30px;
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
					<h1 class="page-title">대시보드</h1>
					<p class="page-description">웹사이트 통계 및 주요 정보를 확인할 수 있습니다.</p>

					<div class="stat-cards">
						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-users"></i>
							</div>
							<div class="stat-content">
								<div class="stat-title">
									<i class="fas fa-user"></i> 전체 회원
								</div>
								<div class="stat-value">${userCount != null ? userCount : '0'}</div>
								<div class="stat-description">지난 달 대비</div>
								<div class="stat-change positive">
									<i class="fas fa-arrow-up"></i> 5.3%
								</div>
							</div>
						</div>

						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-shopping-cart"></i>
							</div>
							<div class="stat-content">
								<div class="stat-title">
									<i class="fas fa-shopping-bag"></i> 주문 건수
								</div>
								<div class="stat-value">857</div>
								<div class="stat-description">지난 달 대비</div>
								<div class="stat-change positive">
									<i class="fas fa-arrow-up"></i> 2.7%
								</div>
							</div>
						</div>

						<div class="stat-card">
							<div class="stat-icon">
								<i class="fas fa-ticket-alt"></i>
							</div>
							<div class="stat-content">
								<div class="stat-title">
									<i class="fas fa-ticket-alt"></i> 쿠폰 사용
								</div>
								<div class="stat-value">432</div>
								<div class="stat-description">지난 달 대비</div>
								<div class="stat-change negative">
									<i class="fas fa-arrow-down"></i> 1.2%
								</div>
							</div>
						</div>
					</div>

					<div class="widget-container">
						<div class="card">
							<div class="card-header">
								<h5 class="mb-0">
									<i class="fas fa-chart-bar"></i> 최근 거래 통계
								</h5>
							</div>
							<div class="card-body">
								<p class="text-muted">최근 7일간의 주문 통계 그래프가 여기에 표시됩니다.</p>
								<div class="text-center py-4">
									<i class="fas fa-chart-line"
										style="font-size: 4rem; color: var(--gray-300);"></i>
									<p class="mt-3">데이터를 준비 중입니다...</p>
								</div>
							</div>
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