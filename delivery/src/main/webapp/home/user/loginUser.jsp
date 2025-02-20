<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<<<<<<< HEAD
<h2>로그인되었습니다</h2>
<div class="container">
  <div class="row">
    <div class="col-lg-8 mx-auto">
      <h2>로그인 성공</h2>
      <p>${user.user_name}님 환영합니다!</p>

      <div class="mt-4">
        <a href="<c:url value='/user/mypage'/>" class="btn btn-primary">마이페이지</a>
        <a href="<c:url value='/user/logout'/>" class="btn btn-secondary">로그아웃</a>
      </div>
    </div>
  </div>
</div>
=======
<h2>로그인되었습니다!!</h2>
<h2>환영합니다~${sessionScope.loginUser.user_name }님</h2>

>>>>>>> refs/remotes/origin/master
</body>
</html>