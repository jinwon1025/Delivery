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
<div align="center">
<table border="1">
    <tr>
        <th>번호</th>
        <th>카테고리명</th>
        <th>삭제</th> <!-- 삭제 버튼 컬럼 추가 -->
    </tr>
    <c:forEach items="${menuList}" var="menu" varStatus="status">
        <tr>
            <td>${status.count}</td>
            <td>${menu.menu_category_name}</td>
            <td>
                <form action="/store/menuDelete" method="post">
                    <input type="hidden" name="menu_category_name" value="${menu.menu_category_name}"/>
                    <input type="submit" value="삭제"/>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
</div>
<br/><br/>
<form action="/store/menuRegister" method="post">
    카테고리명 : <input type="text" name="menu_category_name"/>
    <font color="red">${errors.menu_category_name}</font>

    <p><input type="submit" value="카테고리 등록"/></p>
</form>
</body>
</html>