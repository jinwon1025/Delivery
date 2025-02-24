<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
.container {
   max-width: 1200px;
   margin: 2rem auto;
   padding: 0 2rem;
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

.card {
   background: white;
   border-radius: 10px;
   box-shadow: 0 4px 6px rgba(0,0,0,0.1);
   margin-bottom: 2rem;
   border: none;
}

.card-body {
   padding: 2rem;
}

.btn-secondary {
   background: linear-gradient(to right, #757575, #616161);
   border: none;
   padding: 0.8rem 1.5rem;
   border-radius: 5px;
   color: white;
   transition: all 0.3s ease;
}

.btn:hover {
   transform: translateY(-2px);
   box-shadow: 0 4px 8px rgba(0,0,0,0.1);
   opacity: 0.9;
}

.table {
   width: 100%;
   border-collapse: separate;
   border-spacing: 0;
   margin: 1rem 0;
}

.table th {
   background: #f8f9fa;
   padding: 1rem;
   font-weight: 600;
   color: #333;
   border-bottom: 2px solid #dee2e6;
   text-align: left;
}

.table td {
   padding: 1rem;
   border-bottom: 1px solid #dee2e6;
   vertical-align: middle;
}

.row {
   display: flex;
   flex-wrap: wrap;
   margin: -0.5rem;
}

.col-lg-12 {
   flex: 0 0 100%;
   max-width: 100%;
   padding: 0.5rem;
}

.mb-4 {
   margin-bottom: 1.5rem;
}

.d-flex {
   display: flex;
}

.justify-content-between {
   justify-content: space-between;
}

.align-items-center {
   align-items: center;
}

.table-responsive {
   overflow-x: auto;
   -webkit-overflow-scrolling: touch;
}

.user-info-row:hover {
   background-color: rgba(0,0,0,0.02);
}

.table th, .table td {
   white-space: nowrap;
   overflow: hidden;
   text-overflow: ellipsis;
   max-width: 200px;
}

@media (max-width: 768px) {
   .container {
       padding: 1rem;
   }
   
   .table th, .table td {
       padding: 0.5rem;
   }
}
</style>

<div class="container">
   <div class="dashboard-header">
       <div class="header-content">
           <h2><i class="fas fa-users"></i> 회원 관리</h2>
           <a href="<c:url value='/admin/home'/>" class="btn btn-secondary">
               <i class="fas fa-home"></i> 관리자 홈으로
           </a>
       </div>
   </div>

   <div class="row">
       <div class="col-lg-12">
           <div class="card">
               <div class="card-body">
                   <div class="table-responsive">
                       <table class="table">
                           <thead>
                               <tr>
                                   <th><i class="fas fa-user"></i> 아이디</th>
                                   <th><i class="fas fa-signature"></i> 이름</th>
                                   <th><i class="fas fa-envelope"></i> 이메일</th>
                                   <th><i class="fas fa-key"></i> 비밀번호</th>
                                   <th><i class="fas fa-phone"></i> 전화번호</th>
                                   <th><i class="fas fa-coins"></i> 포인트</th>
                                   <th><i class="fas fa-birthday-cake"></i> 생년월일</th>
                                   <th><i class="fas fa-map-marker-alt"></i> 주소</th>
                               </tr>
                           </thead>
                           <tbody>
                               <c:forEach var="user" items="${userList}">
                                   <tr class="user-info-row">
                                       <td>${user.user_id}</td>
                                       <td>${user.user_name}</td>
                                       <td>${user.email}</td>
                                       <td>${user.password}</td>
                                       <td>${user.user_phone}</td>
                                       <td><fmt:formatNumber value="${user.point}" type="number"/></td>
                                       <td>${user.birth}</td>
                                       <td>${user.user_address}</td>
                                   </tr>
                               </c:forEach>
                           </tbody>
                       </table>
                   </div>
               </div>
           </div>
       </div>
   </div>
</div>