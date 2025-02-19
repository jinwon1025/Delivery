<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 메인화면!</title>
</head>
<body>
<div>
<h2>사용자</h2>
<form:form action="/user/login" method="post" modelAttribute="loginUser">
<table>
            <tr>
                <td><label for="id">아이디</label></td>
                <td><form:input path="user_id" id="id" size="12"/></td>
                <td><font color="red"><form:errors path="user_id"/></font></td>
            </tr>
            <tr>
                <td><label for="password">비밀번호</label></td>
                <td><form:input path="password" id="password" size="12" type="password"/></td>
                <td><font color="red"><form:errors path="password"/></font></td>
            </tr>
        </table>
<input type="submit" value="로그인"/><br/>
</form:form>
<a href="/user/register">회원가입</a>
</div>
</body>
</html>