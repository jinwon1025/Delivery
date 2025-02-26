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

<div class="container">
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