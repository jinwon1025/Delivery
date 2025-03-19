<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 공통 CSS 파일 --%>
<link rel="stylesheet" href="<c:url value='/css/common/reset.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/typography.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/utilities.css'/>">

<%-- 관리자 CSS 파일 --%>
<link rel="stylesheet" href="<c:url value='/css/admin/admin-layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/admin/admin-components.css'/>">
<link rel="stylesheet" href="<c:url value='/css/admin/admin-pages.css'/>">

<%-- Font Awesome & jQuery --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    /* 아이콘과 텍스트 간격 조정을 위한 스타일 */
    .card-header h5 i {
        margin-right: 10px; /* 아이콘과 텍스트 사이 간격 */
    }
    
    .btn i {
        margin-right: 8px; /* 버튼 내 아이콘과 텍스트 사이 간격 */
    }
    
    /* 카드 디자인 개선 */
    .card {
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        border: none;
        margin-bottom: 25px;
    }
    
    .card-header {
        background-color: #f8f9fa;
        border-bottom: 1px solid #e9ecef;
        padding: 15px 20px;
        border-radius: 12px 12px 0 0;
    }
    
    .card-body {
        padding: 20px;
    }
    
    /* 테이블 디자인 개선 */
    .table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .table th {
        font-weight: 600;
        background-color: #f8f9fa;
        padding: 12px 15px;
        border-bottom: 2px solid #e9ecef;
    }
    
    .table td {
        padding: 12px 15px;
        border-bottom: 1px solid #e9ecef;
        vertical-align: middle;
    }
    
    /* 폼 요소 스타일링 */
    .form-control {
        padding: 10px 15px;
        border: 1px solid #ced4da;
        border-radius: 6px;
        transition: border-color 0.15s ease-in-out;
    }
    
    .form-control:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 0.2rem rgba(var(--primary-rgb), 0.25);
    }
    
    .form-label {
        font-weight: 500;
        margin-bottom: 6px;
        display: block;
    }
    
    /* 버튼 스타일링 */
    .btn {
        padding: 8px 16px;
        border-radius: 6px;
        font-weight: 500;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
    }
    
    .btn-primary {
        background-color: var(--primary-color);
        border-color: var(--primary-color);
        color: white;
    }
    
    .btn-primary:hover {
        background-color: var(--primary-dark);
        border-color: var(--primary-dark);
    }
    
    .btn-danger {
        background-color: #dc3545;
        border-color: #dc3545;
        color: white;
    }
    
    .btn-danger:hover {
        background-color: #c82333;
        border-color: #bd2130;
    }
    
    /* 새 카테고리 헤더 스타일 */
    .new-category-header {
        display: flex;
        align-items: center;
    }
    
    .new-category-header i {
        font-size: 1.2rem;
        margin-right: 10px;
        color: var(--primary-color);
    }
    
    /* 카테고리 목록 헤더 스타일 */
    .category-list-header {
        display: flex;
        align-items: center;
    }
    
    .category-list-header i {
        font-size: 1.2rem;
        margin-right: 10px;
        color: var(--primary-color);
    }
</style>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <!-- 카테고리 생성 폼 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0 new-category-header">
                        <i class="fas fa-plus-circle"></i>
                        <span>새 카테고리 생성</span>
                    </h5>
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
                            <i class="fas fa-plus"></i>
                            <span>카테고리 추가</span>
                        </button>
                    </form>
                </div>
            </div>

            <!-- 카테고리 목록 -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0 category-list-header">
                        <i class="fas fa-list"></i>
                        <span>카테고리 목록</span>
                    </h5>
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
                                            <i class="fas fa-trash"></i>
                                            <span>삭제</span>
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