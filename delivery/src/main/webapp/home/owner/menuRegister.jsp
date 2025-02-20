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
<form:form action="/store/menuRegister" method="post" modelAttribute="menu">
	<div>
        <label for="menuName">메뉴명:</label>
        <form:input path="menu_name" id="menuName" type="text" />
    </div>
    <div>
        <label for="menuPrice">가격:</label>
        <form:input path="price" id="menuPrice" type="number" />
    </div>
    <div>
        <label for="imageName">이미지:</label>
        <form:input path="image_name" id="imageName" type="file" />
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