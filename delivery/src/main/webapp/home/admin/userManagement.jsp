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

<div class="container">


    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-user-list"></i> 회원 목록</h5>
                </div>
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