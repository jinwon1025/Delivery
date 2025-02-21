<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메뉴 수정</title>
</head>
<body>
    <h2>메뉴 수정</h2>

    <!-- 메뉴 수정 폼 -->
    <form:form action="/store/menuModify" method="post" modelAttribute="menuItem">
        
        <!-- 메뉴명 -->
        <div class="form-group">
            <label for="menuName">메뉴명:</label>
            <form:input path="menu_name" id="menuName" class="form-control" value="${menuItem.menu_name}" />
            <form:errors path="menu_name" cssClass="form-error"/>
        </div>
        
        <!-- 가격 -->
        <div class="form-group">
            <label for="price">가격:</label>
            <form:input path="price" id="price" class="form-control" type="number" value="${menuItem.price}" />
            <form:errors path="price" cssClass="form-error"/>
        </div>

        <!-- 메뉴 설명 -->
        <div class="form-group">
            <label for="content">설명:</label>
            <form:textarea path="content" id="content" class="form-control" rows="4"></form:textarea>
            <form:errors path="content" cssClass="form-error"/>
        </div>

        <!-- 이미지 -->
        <div class="form-group">
            <label for="image">이미지:</label>
            <form:input path="image_name" id="image" class="form-control" type="file"/>
        </div>

        <!-- 수정하기 버튼 -->
        <div class="form-group">
        	<input type="hidden" name="menu_item_id" value="${menuItem.menu_item_id }"/>
            <input type="submit" value="수정하기" class="btn btn-custom"/>
        </div>

    </form:form>
</body>
</html>
