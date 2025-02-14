<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 회원가입</title>
</head>
<body>
<h3 align="center">사업자 회원가입</h3>
<form:form action="" method="post" modelAttribute="">
아이디 : <br/>
<form:input path="owner_id"/>
<font color="red"><form:errors path="owner_id"/></font><br/><br/>
비밀번호 : <br/>
<form:password path="owner_password"/>
<font color="red"><form:errors path="owner_password"/></font><br/>
<input type="password" name="CONFIRM"/><br/><br/>
이름 : <br/>
<form:input path="owner_name"/>
<font color="red"><form:errors path="owner_name"/></font><br/><br/>
이메일 : <br/>
<form:input path="owner_email"/>
<font color="red"><form:errors path="owner_email"/></font><br/><br/>

전화번호 : <br/>
<form:input path="owner_phone"/>
<font color="red"><form:errors path="owner_phone"/></font><br/><br/>







</form:form>
</body>
</html>