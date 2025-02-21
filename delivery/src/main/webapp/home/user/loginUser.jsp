<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>로그인되었습니다</h2>
<div class="container">
  <div class="row">
    <div class="col-lg-8 mx-auto">
      <h2>로그인 성공</h2>
      <p>${sessionScope.loginUser.user_name}님 환영합니다!</p>

  </div>
</div>


</body>
</html>