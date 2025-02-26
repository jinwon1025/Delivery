<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>메뉴 목록</title>
    <style>
        .menu-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .menu-item {
            width: 250px;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 10px;
            text-align: center;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        .menu-item img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
        }
        .menu-name {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0;
        }
        .menu-content {
            font-size: 14px;
            color: #666;
            margin-bottom: 10px;
        }
        .menu-price {
            font-size: 16px;
            color: #e74c3c;
            font-weight: bold;
        }
        .menu-item {
		    cursor: pointer;
		    transition: all 0.2s ease;
		}
    </style>
</head>
<body>

<h2>메뉴 목록</h2>
<div class="menu-container">
    <c:forEach var="menu" items="${menuList}">
        <div class="menu-item" onclick="location.href='/userstore/menuDetail?menu_item_id=${menu.menu_item_id}'" style="cursor: pointer;">
            <img src="${pageContext.request.contextPath}/upload/menuItemProfile/${menu.image_name}" alt="${menu.image_name}">
            <div class="menu-name">${menu.menu_name}</div>
            <div class="menu-content">${menu.content}</div>
            <div class="menu-price">${menu.price}원</div>
        </div>
    </c:forEach>
</div>

</body>
</html>