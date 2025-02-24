<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.admin-dashboard {
   max-width: 1200px;
   margin: 2rem auto;
   padding: 2rem;
}

.dashboard-header {
   background: linear-gradient(to right, #1a237e, #283593);
   color: white;
   padding: 2rem;
   border-radius: 10px;
   margin-bottom: 2rem;
   box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

.header-content {
   display: flex;
   justify-content: space-between;
   align-items: center;
}

.welcome-text h1 {
   font-size: 2.4rem;
   margin: 0;
}

.welcome-text p {
   margin-top: 0.5rem;
   opacity: 0.9;
}

.stat-cards {
   display: grid;
   grid-template-columns: repeat(3, 1fr);
   gap: 1.5rem;
   margin-bottom: 2rem;
}

.stat-card {
   background: white;
   padding: 1.5rem;
   border-radius: 8px;
   box-shadow: 0 2px 4px rgba(0,0,0,0.05);
   transition: transform 0.2s;
}

.stat-card:hover {
   transform: translateY(-5px);
}

.stat-title {
   font-size: 1.1rem;
   color: #666;
   margin-bottom: 0.5rem;
}

.stat-value {
   font-size: 2rem;
   font-weight: bold;
   color: #333;
}

.admin-actions {
   display: grid;
   grid-template-columns: repeat(3, 1fr);
   gap: 1.5rem;
   margin-top: 2rem;
}

.action-card {
   background: white;
   padding: 2rem;
   border-radius: 10px;
   text-align: center;
   box-shadow: 0 4px 6px rgba(0,0,0,0.05);
   transition: all 0.3s ease;
   cursor: pointer;
   border: 1px solid #eee;
}

.action-card:hover {
   transform: translateY(-5px);
   box-shadow: 0 6px 12px rgba(0,0,0,0.1);
   border-color: #1a237e;
}

.action-icon {
   font-size: 2.5rem;
   margin-bottom: 1rem;
   color: #1a237e;
}

.action-title {
   font-size: 1.2rem;
   font-weight: bold;
   margin-bottom: 0.5rem;
   color: #333;
}

.action-description {
   color: #666;
   font-size: 0.9rem;
   line-height: 1.4;
}

</style>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<div class="admin-dashboard">
   <div class="dashboard-header">
       <div class="header-content">
           <div class="welcome-text">
               <h1>관리자 대시보드</h1>
               <p>웹사이트 관리 및 모니터링을 위한 중앙 관제 시스템입니다.</p>
           </div>
       </div>
   </div>

   <div class="admin-actions">
       <div class="action-card" onclick="location.href='/admin/couponManagement'">
           <div class="action-icon">
               <i class="fas fa-ticket"></i>
           </div>
           <div class="action-title">쿠폰 관리</div>
           <div class="action-description">
               할인 쿠폰 생성 및 관리<br>
               사용자별 쿠폰 발급 현황 확인
           </div>
       </div>

       <div class="action-card" onclick="location.href='/admin/userManagement'">
           <div class="action-icon">
               <i class="fas fa-users"></i>
           </div>
           <div class="action-title">사용자 관리</div>
           <div class="action-description">
               회원 정보 관리<br>
               사용자 권한 및 활동 모니터링
           </div>
       </div>

       <div class="action-card" onclick="location.href='/admin/categoryManagement'">
           <div class="action-icon">
               <i class="fas fa-list"></i>
           </div>
           <div class="action-title">카테고리 관리</div>
           <div class="action-description">
               메뉴 카테고리 설정<br>
               카테고리별 상품 구성 관리
           </div>
       </div>
   </div>
</div>