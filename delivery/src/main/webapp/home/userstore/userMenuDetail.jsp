<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메뉴 상세</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            width: 80%;
            margin: auto;
            padding: 20px;
        }
        .menu-image {
            width: 50%;
            text-align: center;
        }
        .menu-image img {
            width: 100%;
            max-width: 400px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .menu-details {
            width: 50%;
            padding: 20px;
        }
        h2 {
            margin-bottom: 10px;
        }
        .option-group {
            margin-top: 20px;
        }
        .option-group h3 {
            margin-bottom: 5px;
        }
        .option-list {
            list-style: none;
            padding: 0;
        }
        .option-list li {
             list-style: none; /* 목록 스타일 제거 */
			 padding: 0; /* 기본 패딩 제거 */
			 margin: 0; /* 기본 마진 제거 */
        }
        .price {
            font-size: 20px;
            color: #ff5722;
            font-weight: bold;
        }
        .add-to-cart {
            margin-top: 20px;
            padding: 10px;
            background-color: #ff5722;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 18px;
            border-radius: 5px;
        }
        .add-to-cart:hover {
            background-color: #e64a19;
        }
    </style>
</head>
<body>
<form action="${pageContext.request.contextPath}/userstore/addCart" method="post">
<div class="container">
    <input type="hidden" name="menuId" value="${menuDetail.menu_item_id}">
    <!-- 왼쪽: 메뉴 이미지 -->
    <div class="menu-image">
            <img src="${pageContext.request.contextPath}/upload/menuItemProfile/${menuDetail.image_name}" alt="${menuDetail.menu_name}">
    </div>
	
    <!-- 오른쪽: 메뉴 상세 정보 및 옵션 선택 -->
    <div class="menu-details">
            <h2>${menuDetail.menu_name}</h2>
            <hr>
            <p class="price">${menuDetail.price} 원</p>
            <hr>
            <p>${menuDetail.content}</p>
            <hr>
        <!-- 옵션 그룹 -->
        <div class="option-group">
            <ul class="option-list">
                <c:forEach var="entry" items="${optionGroups}">
                	<input type="hidden" name="option_group_id" value="${entry.key}">
				    <h3>[${entry.key}]</h3>
				    <ul>
				       <c:forEach var="option" items="${entry.value}">
				            <li style="">
				                <input type="checkbox" name="option" value="${option.option_id}">
				                ${option.option_name} (+${option.option_price} 원)
				                <input type="hidden" name="option_id" value="${option.option_id }">
				                <input type="hidden" name="option_name" value="${option.option_name }">
				                <input type="hidden" name="option_price" value="${option.option_price }">
				            </li>
				       </c:forEach>
				       </ul>     
				</c:forEach>
			</ul>
        </div>
		
        <!-- 장바구니 버튼 -->
        <button type="submit" class="add-to-cart">장바구니에 추가</button>
    </div>
</div>
</form>

</body>
</html>