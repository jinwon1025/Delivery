<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 공통 CSS 파일 --%>
<link rel="stylesheet" href="<c:url value='/css/common/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/typography.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/utilities.css'/>">

<%-- 관리자 CSS 파일 --%>
<link rel="stylesheet" href="<c:url value='/css/admin/admin-layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/admin/admin-components.css'/>">
<link rel="stylesheet" href="<c:url value='/css/admin/admin-pages.css'/>">

<%-- Font Awesome --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<%-- 관리자 대시보드용 인라인 스타일 --%>
<style>
    .admin-container {
        display: flex;
        min-height: calc(100vh - 150px); /* 헤더/푸터 영역 고려 */
        margin-top: 20px;
    }
    
    .admin-sidebar {
        width: 260px;
        background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
        color: white;
        border-radius: 12px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-right: 20px;
        padding: 20px 0;
    }
    
    .admin-sidebar-header {
        padding: 0 20px 20px 20px;
        margin-bottom: 20px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        display: flex;
        align-items: center;
    }
    
    .admin-logo {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background-color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 15px;
    }
    
    .admin-logo i {
        font-size: 24px;
        color: var(--primary-color);
    }
    
    .admin-title {
        font-size: 18px;
        font-weight: 600;
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
        background-color: rgba(255, 255, 255, 0.15);
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
        padding: 20px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        overflow: hidden;
    }
    
    /* 대시보드 통계 카드 */
    .stat-cards {
        margin-top: 20px;
    }
    
    .frame-container {
        display: none;
        width: 100%;
        height: 100%;
        border: none;
        min-height: 500px;
    }
    
    .frame-container.active {
        display: block;
    }
    
    #dashboardContent {
        display: block;
    }
</style>

<div class="admin-container">
    <%-- 관리자 사이드바 --%>
    <div class="admin-sidebar">
        <div class="admin-sidebar-header">
            <div class="admin-logo">
                <i class="fas fa-user-shield"></i>
            </div>
            <div class="admin-title">관리자 페이지</div>
        </div>
        
        <ul class="admin-menu">
            <li class="admin-menu-item active" onclick="showSection('dashboardContent')">
                <i class="fas fa-tachometer-alt"></i>
                <span>대시보드</span>
            </li>
            <li class="admin-menu-item" onclick="location.href='<c:url value='/admin/userManagement'/>'">
                <i class="fas fa-users"></i>
                <span>회원관리</span>
            </li>
            <li class="admin-menu-item" onclick="location.href='<c:url value='/admin/categoryManagement'/>'">
                <i class="fas fa-list"></i>
                <span>카테고리관리</span>
            </li>
            <li class="admin-menu-item" onclick="location.href='<c:url value='/admin/couponManagement'/>'">
                <i class="fas fa-ticket-alt"></i>
                <span>쿠폰관리</span>
            </li>
        </ul>
    </div>
    
    <%-- 관리자 컨텐츠 영역 --%>
    <div class="admin-content">
        <%-- 대시보드 컨텐츠 --%>
        <div id="dashboardContent">
            <div class="section-title">관리자 대시보드</div>
            <p class="text-muted mb-4">웹사이트 관리 및 모니터링을 위한 중앙 관제 시스템</p>
            
            <div class="stat-cards">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                    <div class="stat-content">
                        <div class="stat-title"><i class="fas fa-user"></i> 전체 회원</div>
                        <div class="stat-value">1,234</div>
                        <div class="stat-description">지난 달 대비</div>
                        <div class="stat-change positive"><i class="fas fa-arrow-up"></i> 5.3%</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-shopping-cart"></i></div>
                    <div class="stat-content">
                        <div class="stat-title"><i class="fas fa-shopping-bag"></i> 주문 건수</div>
                        <div class="stat-value">857</div>
                        <div class="stat-description">지난 달 대비</div>
                        <div class="stat-change positive"><i class="fas fa-arrow-up"></i> 2.7%</div>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-ticket-alt"></i></div>
                    <div class="stat-content">
                        <div class="stat-title"><i class="fas fa-ticket-alt"></i> 쿠폰 사용</div>
                        <div class="stat-value">432</div>
                        <div class="stat-description">지난 달 대비</div>
                        <div class="stat-change negative"><i class="fas fa-arrow-down"></i> 1.2%</div>
                    </div>
                </div>
            </div>
            
            <div class="row mt-5">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fas fa-chart-line"></i> 최근 활동</h5>
                        </div>
                        <div class="card-body">
                            <p class="text-muted">최근 7일간의 활동 데이터를 표시합니다.</p>
                            <p>데이터 준비 중입니다...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function showSection(sectionId) {
    // 모든 메뉴 항목에서 active 클래스 제거
    document.querySelectorAll('.admin-menu-item').forEach(item => {
        item.classList.remove('active');
    });
    
    // 클릭된 메뉴 항목에 active 클래스 추가 
    if (sectionId === 'dashboardContent') {
        document.querySelector('.admin-menu-item').classList.add('active');
    }
}
</script>