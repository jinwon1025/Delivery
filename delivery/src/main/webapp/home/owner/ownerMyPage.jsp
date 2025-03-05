<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="page-header">
	<h1 class="page-title">사업자 정보</h1>
	<p class="page-subtitle">내 계정 정보와 가게 관리 정보를 확인할 수 있습니다.</p>
</div>

<div class="mypage-container">
	<!-- 사이드바 메뉴 -->
	<div class="mypage-sidebar">
		<div class="mypage-menu">
			<div class="mypage-menu-header">사업자 센터</div>
			<ul class="mypage-menu-list">
				<li class="mypage-menu-item"><a
					href="<c:url value='/owner/myPage'/>"
					class="mypage-menu-link active"> <i class="fas fa-user"></i> <span>내
							정보</span>
				</a></li>
				<li class="mypage-menu-item"><a
					href="<c:url value='/store/storeList'/>" class="mypage-menu-link">
						<i class="fas fa-store"></i> <span>내 매장 관리</span>
				</a></li>
				<li class="mypage-menu-item"><a href="#"
					class="mypage-menu-link"> <i class="fas fa-utensils"></i> <span>메뉴
							관리</span>
				</a></li>
				<li class="mypage-menu-item"><a href="#"
					class="mypage-menu-link"> <i class="fas fa-clipboard-list"></i>
						<span>주문 관리</span>
				</a></li>
				<li class="mypage-menu-item"><a href="#"
					class="mypage-menu-link"> <i class="fas fa-chart-line"></i> <span>매출
							통계</span>
				</a></li>
				<li class="mypage-menu-item"><a href="#"
					class="mypage-menu-link"> <i class="fas fa-cog"></i> <span>설정</span>
				</a></li>
			</ul>
		</div>
	</div>

	<!-- 메인 컨텐츠 영역 -->
	<div class="mypage-content">
		<!-- 사업자 프로필 섹션 -->
		<div class="owner-profile-header">
			<div class="owner-info-section">
				<div class="owner-avatar-large">
					<c:choose>
						<c:when test="${not empty owner.owner_image_name}">
							<img
								src="${pageContext.request.contextPath}/upload/ownerProfile/${owner.owner_image_name}"
								alt="프로필 이미지" />
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath}/image/noImage.png"
								alt="기본 이미지" />
						</c:otherwise>
					</c:choose>
				</div>

				<div class="owner-details">
					<h2 class="owner-name-large">${owner.owner_name}</h2>

					<div class="owner-meta-list">
						<div class="owner-meta-item-large">
							<i class="fas fa-user"></i> <span>${owner.owner_id}</span>
						</div>
						<div class="owner-meta-item-large">
							<i class="fas fa-envelope"></i> <span>${owner.owner_email}</span>
						</div>
						<div class="owner-meta-item-large">
							<i class="fas fa-phone"></i> <span>${owner.owner_phone}</span>
						</div>
					</div>

					<div class="owner-actions">
						<a href="<c:url value='/owner/goEdit'/>" class="btn btn-primary">
							<i class="fas fa-edit mr-1"></i> 정보 수정
						</a> <a href="<c:url value='/store/goRegister'/>"
							class="btn btn-outline-gold"> <i class="fas fa-plus mr-1"></i>
							매장 등록
						</a>
					</div>
				</div>
			</div>
		</div>

		<!-- 내 정보 카드 -->
		<div class="owner-info-card">
			<div class="info-card-header">
				<i class="fas fa-info-circle mr-2"></i> 기본 정보
			</div>
			<div class="info-card-body">
				<div class="info-row">
					<div class="info-label">사업자 아이디</div>
					<div class="info-value">${owner.owner_id}</div>
				</div>
				<div class="info-row">
					<div class="info-label">사업자명</div>
					<div class="info-value">${owner.owner_name}</div>
				</div>
				<div class="info-row">
					<div class="info-label">이메일</div>
					<div class="info-value">${owner.owner_email}</div>
				</div>
				<div class="info-row">
					<div class="info-label">전화번호</div>
					<div class="info-value">${owner.owner_phone}</div>
				</div>
				<div class="info-row">
					<div class="info-label">비밀번호</div>
					<div class="info-value">
						******** <a href="<c:url value='/owner/goEdit'/>"
							class="text-primary ml-2"> <i class="fas fa-pencil-alt"></i>
							변경
						</a>
					</div>
				</div>
				<div class="info-row">
					<div class="info-label">프로필 사진</div>
					<div class="info-value">
						<c:choose>
							<c:when test="${not empty owner.owner_image_name}">
								<span class="text-success"> <i
									class="fas fa-check-circle mr-1"></i> 등록됨
								</span>
							</c:when>
							<c:otherwise>
								<span class="text-muted"> <i
									class="fas fa-times-circle mr-1"></i> 미등록
								</span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>

		<!-- 운영 중인 가게 정보 (있을 경우) -->
		<c:if test="${not empty storeList}">
			<div class="owner-info-card mt-4">
				<div class="info-card-header">
					<i class="fas fa-store mr-2"></i> 내 매장 정보
				</div>
				<div class="info-card-body">
					<div class="store-card-list">
						<c:forEach items="${storeList}" var="store">
							<div class="store-card">
								<div class="store-card-img">
									<c:choose>
										<c:when test="${not empty store.store_image_name}">
											<img
												src="${pageContext.request.contextPath}/upload/storeProfile/${store.store_image_name}"
												alt="${store.store_name}">
										</c:when>
										<c:otherwise>
											<img
												src="${pageContext.request.contextPath}/image/noStoreProfile.png"
												alt="기본 이미지">
										</c:otherwise>
									</c:choose>
									<div class="store-status status-open">영업 중</div>
								</div>
								<div class="store-card-body">
									<h3 class="store-card-title">
										${store.store_name} <span class="store-badge">배달</span>
									</h3>
									<div class="store-card-meta">
										<div class="store-meta-item">
											<i class="fas fa-map-marker-alt"></i> <span>${store.store_address}</span>
										</div>
										<div class="store-meta-item">
											<i class="fas fa-won-sign"></i> <span>최소주문금액:
												${store.last_price}원</span>
										</div>
									</div>
								</div>
								<div class="store-card-footer">
									<div class="store-stats">
										<div class="store-stat">
											<i class="fas fa-star"></i> <span>4.8</span>
										</div>
										<div class="store-stat">
											<i class="fas fa-shopping-cart"></i> <span>123건</span>
										</div>
									</div>
									<div class="store-card-btns">
										<a href="#" class="btn btn-sm btn-primary">관리</a>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</c:if>
	</div>
</div>