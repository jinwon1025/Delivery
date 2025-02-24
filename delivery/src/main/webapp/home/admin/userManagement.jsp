<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
.container {
    padding: 20px;
}

.card {
    margin-bottom: 20px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.card-body {
    padding: 20px;
}

.table {
    margin-top: 10px;
    width: 100%;
}

.table th {
    background-color: #f8f9fa;
    border-bottom: 2px solid #dee2e6;
    padding: 12px;
}

.table td {
    padding: 12px;
    vertical-align: middle;
}

.btn-secondary {
    background-color: #6c757d;
    border: none;
    padding: 8px 16px;
}
</style>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>회원 관리</h2>
                <a href="<c:url value='/admin/home'/>" class="btn btn-secondary">관리자 홈으로</a>
            </div>

            <div class="card">
                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>아이디</th>
                                <th>이름</th>
                                <th>이메일</th>
                                <th>비밀번호</th>
                                <th>전화번호</th>
                                <th>포인트</th>
                                <th>생년월일</th>
                                <th>주소</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${userList}">
                                <tr>
                                    <td>${user.user_id}</td>
                                    <td>${user.user_name}</td>
                                    <td>${user.email}</td>
                                    <td>${user.password}</td>
                                    <td>${user.user_phone}</td>
                                    <td>${user.point}</td>
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