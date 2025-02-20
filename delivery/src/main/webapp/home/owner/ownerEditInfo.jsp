<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Owner Information</title>
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
            margin-bottom: 10px;
        }
        .info-form {
            width: 400px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .form-group {
            margin-bottom: 10px;
        }
        label {
            display: block;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="password"], input[type="file"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .save-btn {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }
        .save-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h2 style="text-align: center;">Edit My Information</h2>

<div class="container">
    <form:form modelAttribute="owner" action="/owner/updateInfo" method="post" enctype="multipart/form-data" class="info-form">
        <div class="form-group">
            <label>사업자 아이디</label>
            <form:input path="owner_id" readonly="true" />
        </div>
        <div class="form-group">
            <label>사업자명</label>
            <form:input path="owner_name" />
        </div>
        <div class="form-group">
            <label>사업자 이메일</label>
            <form:input path="owner_email" type="email" />
        </div>
        <div class="form-group">
            <label>사업자 비밀번호</label>
            <form:input path="owner_password" />
        </div>
        <div class="form-group">
            <label>사업자 전화번호</label>
            <form:input path="owner_phone" />
        </div>
        <div class="form-group">
            <label>사업자 프로필 사진</label>
            <c:choose>
                <c:when test="${sessionScope.loginOwner.image_name != 'none'}">
                    <img alt="Profile Image" class="profile-img"
                         src="${pageContext.request.contextPath}/upload/ownerProfile/${sessionScope.loginOwner.image_name}" />
                </c:when>
                <c:otherwise>
                    <img alt="No Image" class="profile-img"
                         src="${pageContext.request.contextPath}/image/noImage.png" />
                </c:otherwise>
            </c:choose>
            <input type="file" name="image" />
        </div>
        <button type="submit" class="save-btn">저장</button>
    </form:form>
</div>

</body>
</html>
