<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>메뉴 카테고리 등록 화면</h2>
<table border="1">
    <tr>
        <th>번호</th>
        <th>카테고리명</th>
    </tr>
	    <c:forEach items="${menuList}" var="menu" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${menu}</td>
        </tr>
    </c:forEach>
</table>

<form action="/store/menuRegister" method="post">
    카테고리명 : <input type="text" name="menu_category_name"/>
    <font color="red">${errors.menu_category_name}</font>

    <p><input type="submit" value="카테고리 등록"/></p>
</form>
</body>
</html>