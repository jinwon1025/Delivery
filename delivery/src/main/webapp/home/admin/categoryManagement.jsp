<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

.card-header {
   background: #f8f9fa;
   padding: 1.5rem;
   border-radius: 10px 10px 0 0;
   border-bottom: 1px solid rgba(0,0,0,0.1);
}

.card-body {
   padding: 2rem;
}

.btn-primary {
   background: linear-gradient(to right, #1e88e5, #1976d2);
   border: none;
   padding: 0.8rem 1.5rem;
   border-radius: 5px;
   transition: all 0.3s ease;
   color: white;
}

.btn-secondary {
   background: linear-gradient(to right, #757575, #616161);
   border: none;
   padding: 0.8rem 1.5rem;
   border-radius: 5px;
   color: white;
}

.btn:hover {
   transform: translateY(-2px);
   box-shadow: 0 4px 8px rgba(0,0,0,0.1);
   opacity: 0.9;
}

.form-control {
   padding: 0.8rem;
   border-radius: 5px;
   border: 1px solid #dee2e6;
   transition: all 0.3s ease;
}

.form-control:focus {
   border-color: #1e88e5;
   box-shadow: 0 0 0 2px rgba(30,136,229,0.1);
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

.btn-danger {
   background: linear-gradient(to right, #f44336, #e53935);
   color: white;
   border: none;
   padding: 0.5rem 1rem;
   border-radius: 5px;
   transition: all 0.3s ease;
}

.form-label {
   font-weight: 500;
   color: #333;
   margin-bottom: 0.5rem;
}

.row {
   display: flex;
   flex-wrap: wrap;
   margin: -0.5rem;
}

.col-md-6 {
   flex: 0 0 50%;
   padding: 0.5rem;
}

.mb-3 {
   margin-bottom: 1rem;
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

.category-icon {
   font-size: 1.2rem;
   margin-right: 0.5rem;
}

@media (max-width: 768px) {
   .container {
       padding: 1rem;
   }
   
   .row {
       flex-direction: column;
   }
   
   .col-md-6 {
       width: 100%;
   }
}
</style>

<div class="container">
   <div class="dashboard-header">
       <div class="header-content">
           <h2><i class="fas fa-list-alt category-icon"></i> 카테고리 관리</h2>
           <a href="<c:url value='/admin/home'/>" class="btn btn-secondary">
               <i class="fas fa-home"></i> 관리자 홈으로
           </a>
       </div>
   </div>

   <div class="row">
       <div class="col-lg-12">
           <!-- 카테고리 생성 폼 -->
           <div class="card mb-4">
               <div class="card-header">
                   <h5 class="mb-0"><i class="fas fa-plus-circle"></i> 새 카테고리 생성</h5>
               </div>
               <div class="card-body">
                   <form action="<c:url value='/admin/maincategory/create'/>" method="post">
                       <div class="row mb-3">
                           <div class="col-md-6">
                               <div class="mb-3">
                                   <label class="form-label">카테고리 명</label>
                                   <input type="text" class="form-control" name="main_category_name" required>
                               </div>
                           </div>
                       </div>
                       <button type="submit" class="btn btn-primary">
                           <i class="fas fa-plus"></i> 카테고리 추가
                       </button>
                   </form>
               </div>
           </div>

           <!-- 카테고리 목록 -->
           <div class="card">
               <div class="card-header">
                   <h5 class="mb-0"><i class="fas fa-list"></i> 카테고리 목록</h5>
               </div>
               <div class="card-body">
                   <table class="table">
                       <thead>
                           <tr>
                               <th>카테고리 ID</th>
                               <th>카테고리 명</th>
                               <th>작업</th>
                           </tr>
                       </thead>
                       <tbody>
                           <c:forEach var="maincategory" items="${maincategoryList}">
                               <tr>
                                   <td>${maincategory.main_category_id}</td>
                                   <td>${maincategory.main_category_name}</td>
                                   <td>
                                       <button type="button" class="btn btn-sm btn-danger" 
                                               onclick="if(confirm('이 카테고리를 삭제하면 관련된 모든 데이터가 영향을 받을 수 있습니다.\n정말 삭제하시겠습니까?')) deleteMaincategory(${maincategory.main_category_id})">
                                           <i class="fas fa-trash"></i> 삭제
                                       </button>
                                   </td>
                               </tr>
                           </c:forEach>
                       </tbody>
                   </table>
               </div>
           </div>
       </div>
   </div>
</div>

<script>
function deleteMaincategory(maincategoryId) {
   $.ajax({
       url: '<c:url value="/admin/maincategory/delete/"/>' + maincategoryId,
       type: 'POST',
       success: function(response) {
           alert('카테고리가 성공적으로 삭제되었습니다.');
           window.location.href = '<c:url value="/admin/categoryManagement"/>';
       },
       error: function(xhr, status, error) {
           console.error('Error:', error);
           alert('카테고리 삭제 실패: ' + error);
       }
   });
}
</script>