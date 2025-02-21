<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>메뉴 등록</h2>
<form:form action="/store/menuRegister" method="post" modelAttribute="menu" enctype="multipart/form-data">
	<div>
        <label for="menu_name">메뉴명:</label>
        <form:input path="menu_name" id="menu_name" type="text"/>
        <font color="red"><form:errors path="menu_name"/></font>
    </div>
    <div>
        <label for="price">가격:</label>
        <form:input path="price" id="price" type="number"/>
        <font color="red"><form:errors path="price"/></font>
    </div>
    <div>
        <label for="image">이미지:</label>
        <form:input path="image" id="image" type="file" />
    </div>
    <div>
        <label for="menuContent">메뉴설명:</label>
        <form:input path="content" id="menuContent" type="text" />
    </div>
    <br/>
    <input type="submit" value="등록하기">
</form:form>
</body>
</html>