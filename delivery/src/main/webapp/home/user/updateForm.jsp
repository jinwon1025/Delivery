<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container text-center" align="center">
<h2 class="mb-4">회원정보 수정</h2>
<form action="<c:url value='/user/updateUser'/>" method="post" enctype="multipart/form-data" class="mx-auto" style="max-width: 500px;">
<label class="form-label">아이디</label>
<input type="text" class="form-control-plaintext" name="user_id" value="${userInfo.user_id}" readonly><br/>

<label class="form-label mt-2">이메일</label>
<input type="email" class="form-control-plaintext" name="email" value="${userInfo.email}" readonly><br/>

<label class="form-label mt-2">이름</label>
<input type="text" class="form-control" name="user_name" value="${userInfo.user_name}" required><br/>

<label class="form-label mt-2">비밀번호</label>
<input type="text" class="form-control" name="password" value="${userInfo.password}" required><br/>

<label class="form-label mt-2">전화번호</label>
<select class="form-select" name="phone1" required>
<option value="010" ${userInfo.user_phone.startsWith('010') ? 'selected' : ''}>010</option>
<option value="011" ${userInfo.user_phone.startsWith('011') ? 'selected' : ''}>011</option>
<option value="016" ${userInfo.user_phone.startsWith('016') ? 'selected' : ''}>016</option>
<option value="017" ${userInfo.user_phone.startsWith('017') ? 'selected' : ''}>017</option>
<option value="018" ${userInfo.user_phone.startsWith('018') ? 'selected' : ''}>018</option>
<option value="019" ${userInfo.user_phone.startsWith('019') ? 'selected' : ''}>019</option>
</select>
<c:set var="phone2" value="${userInfo.user_phone.length() >= 7 ? userInfo.user_phone.substring(3, 7) : ''}"/>
<input type="text" class="form-control" name="phone2" value="${phone2}" maxlength="4" required>
<c:set var="phone3" value="${userInfo.user_phone.length() >= 11 ? userInfo.user_phone.substring(7) : ''}"/>
<input type="text" class="form-control" name="phone3" value="${phone3}" maxlength="4" required><br/>

<label class="form-label mt-2">생년월일</label>
<input type="date" class="form-control" name="birth" value="${userInfo.birth}" required><br/>

<label class="form-label mt-2">주소</label>
<input type="text" class="form-control" name="user_address" value="${userInfo.user_address}" required><br/>

<label>프로필 사진</label>
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
<input type="file" name="image" /><br/><br/>
<div class="d-grid gap-2 mt-4">
<button type="submit" class="btn btn-primary">정보 수정하기</button>
<a href="<c:url value='/user/mypage'/>" class="btn btn-secondary">취소</a>
</div>
</form>
</div>