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

<%-- Font Awesome --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* 테이블 관련 스타일 개선 */
    .card {
        margin-bottom: 20px;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        border: none;
    }
    
    .card-header {
        background-color: #f8f9fa;
        border-bottom: 1px solid #e9ecef;
        padding: 15px 20px;
        border-radius: 12px 12px 0 0;
    }
    
    .card-body {
        padding: 0;
    }
    
    .table-container {
        width: 100%;
        overflow-x: auto;
        padding: 0;
        margin: 0;
    }
    
    .user-table {
        width: 100%;
        min-width: 1200px; /* 테이블 최소 너비 설정 */
        border-collapse: collapse;
    }
    
    .user-table th,
    .user-table td {
        padding: 15px;
        text-align: left;
        vertical-align: middle;
        border-bottom: 1px solid #e9ecef;
        white-space: nowrap; /* 텍스트 줄바꿈 방지 */
        overflow: hidden;
        text-overflow: ellipsis; /* 길 경우 ... 표시 */
    }
    
    .user-table th {
        font-weight: 600;
        color: #495057;
        background-color: #f8f9fa;
    }
    
    .user-table th i {
        margin-right: 6px;
        color: var(--primary-color);
    }
    
    .user-info-row:hover {
        background-color: #f8f9fa;
    }
    
    /* 각 컬럼 너비 조정 */
    .user-table th:nth-child(1), .user-table td:nth-child(1) { width: 10%; } /* 아이디 */
    .user-table th:nth-child(2), .user-table td:nth-child(2) { width: 8%; } /* 이름 */
    .user-table th:nth-child(3), .user-table td:nth-child(3) { width: 15%; } /* 이메일 */
    .user-table th:nth-child(4), .user-table td:nth-child(4) { width: 10%; } /* 비밀번호 */
    .user-table th:nth-child(5), .user-table td:nth-child(5) { width: 12%; } /* 전화번호 */
    .user-table th:nth-child(6), .user-table td:nth-child(6) { width: 8%; } /* 포인트 */
    .user-table th:nth-child(7), .user-table td:nth-child(7) { width: 10%; } /* 생년월일 */
    .user-table th:nth-child(8), .user-table td:nth-child(8) { width: 27%; } /* 주소 */
    
    /* 주소 컬럼은 필요한 경우 툴팁으로 전체 내용 볼 수 있게 설정 */
    .address-cell {
        position: relative;
        cursor: pointer;
    }
    
    .tooltip-text {
        display: none;
        position: absolute;
        background-color: #333;
        color: #fff;
        padding: 5px 10px;
        border-radius: 4px;
        z-index: 1;
        width: 300px;
        left: 0;
        top: 100%;
    }
    
    .address-cell:hover .tooltip-text {
        display: block;
    }
</style>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-users"></i> 회원 목록</h5>
                </div>
                <div class="card-body">
                    <div class="table-container">
                        <table class="user-table">
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
                                        <td>
                                            <c:catch var="birthFormatException">
                                                <fmt:parseDate var="parsedBirth" value="${user.birth}" pattern="yyyy-MM-dd" />
                                                <fmt:formatDate value="${parsedBirth}" pattern="yyyy년 MM월 dd일" />
                                            </c:catch>
                                            <c:if test="${not empty birthFormatException}">
                                                ${user.birth}
                                            </c:if>
                                        </td>
                                        <td class="address-cell">
                                            ${user.user_address}
                                            <span class="tooltip-text">${user.user_address}</span>
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
</div>

<script>
    // 테이블 반응형 처리 및 주소 툴팁 표시 관련 스크립트
    document.addEventListener('DOMContentLoaded', function() {
        // 테이블 너비 조정 (필요시)
        const tableContainer = document.querySelector('.table-container');
        const userTable = document.querySelector('.user-table');
        
        // 창 크기 변경 시 테이블 스크롤 상태 확인
        window.addEventListener('resize', function() {
            if (userTable.offsetWidth > tableContainer.offsetWidth) {
                tableContainer.style.overflowX = 'auto';
            } else {
                tableContainer.style.overflowX = 'hidden';
            }
        });
        
        // 초기 실행
        if (userTable.offsetWidth > tableContainer.offsetWidth) {
            tableContainer.style.overflowX = 'auto';
        }
    });
</script>