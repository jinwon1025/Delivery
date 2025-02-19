<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align="center">
<c:choose>
	<c:when test="${ FAIL == 'YES' }">
		<h3>로그인되지 않았습니다. 계정과 암호를 확인하세요.</h3>
	</c:when>
</c:choose>
</div>
</body>
</html>

