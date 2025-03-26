<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> <!-- fmt 태그 추가 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>가게 관리 - 금베달리스트</title>

<!-- 공통 CSS 파일 -->
<link rel="stylesheet" href="<c:url value='/css/common/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/typography.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/utilities.css'/>">

<!-- 사업자 CSS 파일 -->
<link rel="stylesheet" href="<c:url value='/css/store/store-layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/store/store-components.css'/>">
<link rel="stylesheet" href="<c:url value='/css/store/store-pages.css'/>">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- Google Fonts - Noto Sans KR -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">

<style>
    /* 토글 스위치 스타일 */
    .store-status-toggle {
        display: flex;
        align-items: center;
    }
    
    .status-label {
        color: white;
        margin-right: 10px;
        font-weight: 500;
    }
    
    .toggle-switch {
        position: relative;
        display: inline-block;
        width: 100px;
        height: 34px;
    }
    
    .toggle-switch input {
        opacity: 0;
        width: 0;
        height: 0;
    }
    
    .toggle-label {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: #ccc;
        transition: .4s;
        border-radius: 34px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .toggle-label:before {
        position: absolute;
        content: "";
        height: 26px;
        width: 26px;
        left: 4px;
        bottom: 4px;
        background-color: white;
        transition: .4s;
        border-radius: 50%;
    }
    
    input:checked + .toggle-label {
        background-color: #4CAF50;
    }
    
    input:checked + .toggle-label:before {
        transform: translateX(66px);
    }
    
    .status-text {
        color: white;
        font-weight: bold;
        text-transform: uppercase;
        font-size: 12px;
    }
    
    .gm-mr-3 {
        margin-right: 1rem;
    }

    /* 부트스트랩과 충돌할 수 있는 클래스에 gm- 접두사 추가 */
    .gm-row {
        display: flex;
        flex-wrap: wrap;
        margin-right: -15px;
        margin-left: -15px;
    }

    .gm-col-3 {
        flex: 0 0 25%;
        max-width: 25%;
        padding-right: 15px;
        padding-left: 15px;
    }

    .gm-container {
        width: 100%;
        padding-right: 15px;
        padding-left: 15px;
        margin-right: auto;
        margin-left: auto;
        max-width: 1140px;
    }

    .gm-card {
        position: relative;
        display: flex;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 1px solid rgba(0,0,0,.125);
        border-radius: 0.25rem;
    }

    .gm-card-title {
        margin-bottom: 0.75rem;
        font-size: 1.25rem;
        font-weight: 500;
    }

    .gm-text-center {
        text-align: center;
    }

    .gm-text-primary {
        color: #4e73df;
    }

    .gm-text-muted {
        color: #6c757d;
    }

    .gm-text-sm {
        font-size: 0.875rem;
    }

    .gm-p-4 {
        padding: 1.5rem;
    }

    .gm-mb-3 {
        margin-bottom: 1rem;
    }

    .gm-mb-4 {
        margin-bottom: 1.5rem;
    }

    .gm-mt-2 {
        margin-top: 0.5rem;
    }

    .gm-mt-4 {
        margin-top: 1.5rem;
    }

    .gm-h-100 {
        height: 100%;
    }

    .gm-btn {
        display: inline-block;
        font-weight: 400;
        color: #212529;
        text-align: center;
        vertical-align: middle;
        cursor: pointer;
        background-color: transparent;
        border: 1px solid transparent;
        padding: 0.375rem 0.75rem;
        font-size: 1rem;
        line-height: 1.5;
        border-radius: 0.25rem;
        transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    }

    .gm-btn-white {
        color: #212529;
        background-color: #fff;
        border-color: #fff;
    }

    .gm-btn-sm {
        padding: 0.25rem 0.5rem;
        font-size: 0.875rem;
        line-height: 1.5;
        border-radius: 0.2rem;
    }

    .gm-btn-primary {
        color: #fff;
        background-color: #4e73df;
        border-color: #4e73df;
    }

    .gm-d-flex {
        display: flex;
    }

    .gm-justify-content-between {
        justify-content: space-between;
    }

    .gm-align-items-center {
        align-items: center;
    }

    .gm-text-white {
        color: #fff;
    }

    .gm-bg-gradient-gold {
        background: linear-gradient(135deg, #d4af37 0%, #f2c94c 100%);
    }

    .gm-p-4 {
        padding: 1.5rem;
    }

    .gm-opacity-90 {
        opacity: 0.9;
    }

    .gm-font-bold {
        font-weight: 700;
    }
</style>
</head>
<body>
    <!-- 헤더 영역 -->
    <header class="store-header">
        <div class="header-container">
            <div class="logo-area">
                <a href="<c:url value='/owner/index'/>" class="site-logo"> 
                    <i class="fas fa-medal"></i> <span class="logo-text">금베달리스트</span>
                </a>
            </div>

            <div class="owner-account">
                <c:choose>
                    <c:when test="${sessionScope.loginOwner != null}">
                        <div class="owner-info">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loginOwner.image_name}">
                                    <img class="profile-pic" src="${pageContext.request.contextPath}/upload/ownerProfile/${sessionScope.loginOwner.image_name}" alt="프로필 이미지" />
                                </c:when>
                                <c:otherwise>
                                    <img class="profile-pic" src="${pageContext.request.contextPath}/image/noImage.png" alt="기본 이미지" />
                                </c:otherwise>
                            </c:choose>
                            <span class="username">${sessionScope.loginOwner.name}님</span>
                        </div>
                        <a href="<c:url value='/owner/myPage'/>" title="마이페이지"> 
                            <i class="fas fa-user-circle icon-link"></i>
                        </a>
                        <a href="<c:url value='/owner/logout'/>" title="로그아웃"> 
                            <i class="fas fa-sign-out-alt icon-link"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/owner/goLogin'/>" class="gm-btn gm-btn-sm gm-btn-primary">로그인</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <!-- 현재 관리 중인 가게 정보 -->
    <div class="gm-bg-gradient-gold gm-text-white gm-p-4 gm-mb-4">
        <div class="gm-container gm-d-flex gm-justify-content-between gm-align-items-center">
            <div>
                <h1 class="gm-font-bold">${sessionScope.currentStore.store_name}</h1>
                <p class="gm-text-sm gm-opacity-90">${sessionScope.currentStore.store_id}</p>
            </div>
            <div class="gm-d-flex gm-align-items-center">
                <!-- 영업 상태 토글 스위치 -->
                <div class="store-status-toggle gm-mr-3">
                    <span class="status-label mr-2">영업 상태:</span>
                    <div class="toggle-switch">
                        <input type="checkbox" id="storeStatusToggle" 
                               ${sessionScope.currentStore.store_status == 1 ? 'checked' : ''} 
                               onchange="updateStoreStatus(this.checked)">
                        <label for="storeStatusToggle" class="toggle-label">
                            <span class="status-text">
                                ${sessionScope.currentStore.store_status == 1 ? '영업중' : '영업종료'}
                            </span>
                        </label>
                    </div>
                </div>
                <a href="<c:url value='/store/storeList'/>" class="gm-btn gm-btn-white">
                    <i class="fas fa-store mr-1"></i> 다른 가게 선택
                </a>
            </div>
        </div>
    </div>

    <!-- 네비게이션 -->
    <nav class="store-nav gm-mb-4">
        <div class="nav-container">
            <div class="nav-menu">
                <a href="<c:url value='/store/menuManager'/>" class="nav-item ${fn:contains(pageContext.request.requestURI, 'menu') ? 'active' : ''}">
                    <i class="fas fa-utensils mr-2"></i> 메뉴 관리
                </a> 
                <a href="/owner/orderList" class="nav-item ${fn:contains(pageContext.request.requestURI, 'order') ? 'active' : ''}">
                    <i class="fas fa-clipboard-list mr-2"></i> 주문 목록
                </a> 
                <span class="nav-divider">|</span> 
                <a href="/owner/reviewList" class="nav-item ${fn:contains(pageContext.request.requestURI, 'review') ? 'active' : ''}">
                    <i class="fas fa-star mr-2"></i> 리뷰 관리
                </a> 
                <span class="nav-divider">|</span> 
                <a href="<c:url value='/store/goStoreModify'/>" class="nav-item ${fn:contains(pageContext.request.requestURI, 'Modify') ? 'active' : ''}">
                    <i class="fas fa-edit mr-2"></i> 가게 정보 수정
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
                                <div class="stat-value">${todayOrder}</div>
                                <div class="stat-label">오늘 주문</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-utensils"></i>
                                </div>
                                <div class="stat-value">${menuCount}</div>
                                <div class="stat-label">메뉴 수</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-star"></i>
                                </div>
                                <div class="stat-value">${averageRating}</div>
                                <div class="stat-label">평균 평점</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-won-sign"></i>
                                </div>
                                <div class="stat-value">
                                    <fmt:formatNumber value="${totalPrice}" type="number" pattern="#,###"/>원
                                </div>
                                <div class="stat-label">오늘 매출</div>
                            </div>
                        </div>
                    </div>

                    <!-- 빠른 메뉴 접근 -->
                    <div class="dashboard-section">
                        <h2 class="section-title">빠른 메뉴</h2>

                        <div class="gm-row gm-mt-4">
                            <div class="gm-col-3">
                                <a href="<c:url value='/store/menuManager'/>" class="gm-card gm-text-center gm-p-4 gm-h-100">
                                    <div class="gm-text-primary gm-mb-3">
                                        <i class="fas fa-utensils" style="font-size: 3rem;"></i>
                                    </div>
                                    <h3 class="gm-card-title">메뉴 관리</h3>
                                    <p class="gm-text-sm gm-text-muted gm-mt-2">메뉴와 옵션을 관리합니다</p>
                                </a>
                            </div>

                            <div class="gm-col-3">
                                <a href="/owner/orderList" class="gm-card gm-text-center gm-p-4 gm-h-100">
                                    <div class="gm-text-primary gm-mb-3">
                                        <i class="fas fa-clipboard-list" style="font-size: 3rem;"></i>
                                    </div>
                                    <h3 class="gm-card-title">주문 목록</h3>
                                    <p class="gm-text-sm gm-text-muted gm-mt-2">들어온 주문을 확인합니다</p>
                                </a>
                            </div>

                            <div class="gm-col-3">
                                <a href="<c:url value='/store/goStoreModify'/>" class="gm-card gm-text-center gm-p-4 gm-h-100">
                                    <div class="gm-text-primary gm-mb-3">
                                        <i class="fas fa-edit" style="font-size: 3rem;"></i>
                                    </div>
                                    <h3 class="gm-card-title">가게 정보</h3>
                                    <p class="gm-text-sm gm-text-muted gm-mt-2">가게 정보를 수정합니다</p>
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
                    <li class="footer-link"><a href="<c:url value='/store/storeList'/>">매장 목록</a></li>
                    <li class="footer-link"><a href="<c:url value='/store/goRegister'/>">매장 등록</a></li>
                    <li class="footer-link"><a href="<c:url value='/owner/notice'/>">공지사항</a></li>
                    <li class="footer-link"><a href="<c:url value='/owner/myPage'/>">마이페이지</a></li>
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
    function updateStoreStatus(isOpen) {
        const status = isOpen ? 1 : 0;
        const storeId = "${sessionScope.currentStore.store_id}";
        
        // 상태 텍스트 업데이트
        document.querySelector('.status-text').textContent = isOpen ? '영업중' : '영업종료';
        
        // AJAX 요청으로 서버에 상태 업데이트
        $.ajax({
            url: '/store/updateStatus',
            type: 'POST',
            data: {
                storeId: storeId,
                status: status
            },
            success: function(response) {
                if (response.success) {
                    // 성공 메시지 표시
                    alert('가게 상태가 업데이트되었습니다.');
                } else {
                    // 실패 시 원래 상태로 되돌림
                    document.getElementById('storeStatusToggle').checked = !isOpen;
                    document.querySelector('.status-text').textContent = !isOpen ? '영업중' : '영업종료';
                    alert(response.message || '상태 업데이트에 실패했습니다.');
                }
            },
            error: function() {
                // 에러 시 원래 상태로 되돌림
                document.getElementById('storeStatusToggle').checked = !isOpen;
                document.querySelector('.status-text').textContent = !isOpen ? '영업중' : '영업종료';
                alert('서버 통신 오류가 발생했습니다.');
            }
        });
    }
    </script>
</body>
</html>