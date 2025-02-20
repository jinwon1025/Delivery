<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Owner Information</title>
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
</style>
</head>
<body>

	<h2 style="text-align: center;">My Page</h2>

	<div class="container">

		<table class="info-table">
			<tr>
				<th>사업자 아이디</th>
				<td>${owner.owner_id }</td>
			</tr>
			<tr>
				<th>사업자명</th>
				<td>${owner.owner_name }</td>
			</tr>
			<tr>
				<th>사업자 이메일</th>
				<td>${owner.owner_email }</td>
			</tr>
			<tr>
				<th>사업자 비밀번호</th>
				<td>${owner.owner_password }</td>
			</tr>
			<tr>
				<th>사업자 전화번호</th>
				<td>${owner.owner_phone }</td>
			</tr>
			<tr>
				<th>사업자 프로필 사진</th>
				<td><c:choose>
						<c:when test="${not empty sessionScope.loginOwner.image_name}">
							<img alt="Profile Image" class="profile-img"
								src="${pageContext.request.contextPath}/upload/ownerProfile/${sessionScope.loginOwner.image_name}" />
						</c:when>
						<c:otherwise>
							<img alt="No Image" class="profile-img"
								src="${pageContext.request.contextPath}/image/noImage.png" />
						</c:otherwise>
					</c:choose></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><a
					href="/owner/goEdit" class="edit-btn">수정</a></td>
			</tr>
		</table>

	</div>

</body>
</html>
