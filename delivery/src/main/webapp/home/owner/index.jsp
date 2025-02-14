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
<input type="text" placeholder="아이디를 입력하세요."/><br/>
<input type="password" placeholder="비밀번호를 입력하세요."><br/>
<input type="submit" value="로그인"/>
<hr>
<a href="/owner/register.html">회원가입</a>
</div>
</body>
</html>