<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 메인화면</title>
</head>
<body>
<div align="center">
<h2>금베달리스트</h2>
<form:form action="/owner/loginDo" method="post" modelAttribute="loginOwner">

	아이디 <form:input path="id" size="12" />
		<font color="red"><form:errors path="id"/></font><br/>
	비밀번호 <form:input path="password" size="12"/>
		<font color="red"><form:errors path="password"/></font><br/>
	<input type="submit" value="로그인"/>
</form:form>
<hr>
<a href="/owner/goRegister">회원가입</a>
</div>
</body>
</html>