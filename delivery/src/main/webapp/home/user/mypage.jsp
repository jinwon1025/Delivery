<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Information</title>
<style>
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
}

.profile-img {
    width: 200px;
    height: 200px;
    border-radius: 10px;
    object-fit: cover;
    border: 2px solid #ddd;
    margin-right: 20px;
}

.info-table {
    border-collapse: collapse;
    text-align: left;
    width: 400px;
}

.info-table th, .info-table td {
    border: 1px solid black;
    padding: 10px;
}

.info-table th {
    background-color: #f2f2f2;
}

.edit-btn {
    display: block;
    width: 100px;
    padding: 10px;
    margin: 10px auto;
    text-align: center;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    text-decoration: none;
}

.edit-btn:hover {
    background-color: #0056b3;
}

.btn-group {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 10px;
}
</style>
</head>
<body>

<h2 style="text-align: center;">My Page</h2>

<div class="container">
    <table class="info-table">
        <tr>
            <th>아이디</th>
            <td>${userInfo.user_id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${userInfo.user_name}</td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td>${userInfo.password}</td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td>${userInfo.user_phone}</td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td>${userInfo.birth}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${userInfo.email}</td>
        </tr>
        <c:if test="${not empty userInfo.point}">
        <tr>
            <th>포인트</th>
            <td>${userInfo.point}</td>
        </tr>
        </c:if>
        <tr>
            <th>프로필 사진</th>
            <td>
                <c:choose>
                    <c:when test="${not empty userInfo.image_name}">
                        <img alt="Profile Image" class="profile-img"
                            src="${pageContext.request.contextPath}/upload/userProfile/${userInfo.image_name}" />
                    </c:when>
                    <c:otherwise>
                        <img alt="No Image" class="profile-img"
                            src="${pageContext.request.contextPath}/image/noImage.png" />
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <div class="btn-group">
                    <a href="<c:url value='/user/updateForm'/>" class="edit-btn">회원정보 수정</a>
                    <a href="<c:url value='/user/index'/>" class="edit-btn">홈으로</a>
                </div>
            </td>
        </tr>
    </table>
</div>

</body>
</html>