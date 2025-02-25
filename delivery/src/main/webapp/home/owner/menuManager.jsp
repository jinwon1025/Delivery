<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>메뉴 리스트</title>
  <style>
    * {
      box-sizing: border-box;
      font-family: 'Noto Sans KR', sans-serif;
    }

    body {
      margin: 0;
      padding: 20px;
      background-color: #f5f5f5;
    }

    .menu-container {
      max-width: 800px;
      margin: 0 auto;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }

    .category {
      border-bottom: 1px solid #eee;
    }

    .category-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 20px;
      background-color: #f9f9f9;
      cursor: pointer;
    }

    .category-header h3 {
      margin: 0;
      font-size: 16px;
      color: #333;
    }

    .category-header .button-group {
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .category-header .toggle-icon {
      margin-left: 10px;
      font-size: 18px;
      transition: transform 0.3s;
    }

    .category-header.active .toggle-icon {
      transform: rotate(180deg);
    }

    .menu-items {
      display: none;
      padding: 0;
    }

    .category.active .menu-items {
      display: block;
    }

    .menu-item {
      display: flex;
      padding: 15px 20px;
      border-bottom: 1px solid #f0f0f0;
    }

    .menu-item:last-child {
      border-bottom: none;
    }

    .menu-item-image {
      width: 80px;
      height: 80px;
      border-radius: 4px;
      overflow: hidden;
      margin-right: 15px;
      background-color: #eee;
    }

    .menu-item-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .menu-item-details {
      flex: 1;
    }

    .menu-item-details h4 {
      margin: 0 0 8px 0;
      font-size: 16px;
      color: #333;
    }

    .menu-item-description {
      font-size: 14px;
      color: #666;
      margin: 0 0 8px 0;
    }

    .menu-item-price {
      font-weight: bold;
      color: #ff3d00;
    }
    
    .admin-controls {
      display: flex;
      margin-top: 10px;
      gap: 5px;
    }
    
    .admin-controls form {
      margin: 0;
    }
    
    .btn {
      padding: 5px 10px;
      background-color: #f0f0f0;
      border: 1px solid #ddd;
      border-radius: 4px;
      cursor: pointer;
    }
    
    .btn-primary {
      background-color: #4CAF50;
      color: white;
      border: none;
    }
    
    .btn-danger {
      background-color: #f44336;
      color: white;
      border: none;
    }
    
    .btn-info {
      background-color: #2196F3;
      color: white;
      border: none;
    }
    
    .register-form {
      max-width: 800px;
      margin: 20px auto;
      padding: 20px;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    .form-group {
      margin-bottom: 15px;
    }
    
    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }
    
    .form-control {
      width: 100%;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }
    
    .error {
      color: red;
      font-size: 12px;
    }
  </style>
</head>
<body>
  <h2 style="text-align: center; margin-bottom: 20px;">메뉴 관리</h2>
  
  <div class="menu-container">
    <c:forEach items="${menuList}" var="category" varStatus="status">
        <div class="category ${status.first ? 'active' : ''}">
            <div class="category-header">
                <h3>${category.menu_category_name}</h3>
                <div class="button-group">
                    <form action="/store/categoryUpdate" method="post" style="margin: 0;" onsubmit="return confirmCategoryUpdate(${category.menu_category_id});">
                        <input type="hidden" name="menu_category_id" value="${category.menu_category_id}"/>
                        <input type="hidden" id="menu_category_name_${category.menu_category_id}" name="menu_category_name"  value="${category.menu_category_name}"/>
                        <input type="submit" value="수정" class="btn btn-primary"/>
                    </form>
                    <form action="/store/categoryDelete" method="post" style="margin: 0;" onsubmit="return confirmCategoryDelete();">
                        <input type="hidden" name="menu_category_id" value="${category.menu_category_id}"/>
                        <input type="submit" value="삭제" class="btn btn-danger"/>
                    </form>
                    <span class="toggle-icon">▼</span>
                </div>
            </div>
            <div class="menu-items">
                <c:forEach items="${menuItemList}" var="menuItem">
                    <c:if test="${menuItem.menu_category_id eq category.menu_category_id}">
                        <div class="menu-item">
                            <div class="menu-item-image">
                                <c:choose>
                                    <c:when test="${not empty menuItem.image_name}">
                                        <img src="${pageContext.request.contextPath}/upload/menuItemProfile/${menuItem.image_name}" 
                                             alt="${menuItem.menu_name}">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width: 100%; height: 100%; background-color: #fff; 
                                                    display: flex; align-items: center; justify-content: center;">
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="menu-item-details">
                                <h4>${menuItem.menu_name}</h4>
                                <p class="menu-item-description">${menuItem.content}</p>
                                <p class="menu-item-price">${menuItem.price}원</p>
                                
                                <div class="admin-controls">
                                    <form action="/store/menuDetail" method="post">
                                        <input type="hidden" name="menu_item_id" value="${menuItem.menu_item_id}"/>
                                        <input type="submit" value="수정" class="btn btn-primary"/>
                                    </form>
                                    <form action="/store/menuDelete" method="post" onsubmit="return confirmDelete();">
                                        <input type="hidden" name="menu_item_id" value="${menuItem.menu_item_id}"/>
                                        <input type="submit" value="삭제" class="btn btn-danger"/>
                                    </form>
                                    <form action="/store/optionManage" method="get">
                                        <input type="hidden" name="menu_item_id" value="${menuItem.menu_item_id}"/>
                                        <input type="submit" value="옵션 관리" class="btn btn-info"/>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                
                <!-- 메뉴 추가 버튼 -->
                <div style="padding: 15px; text-align: center;">
                    <form action="/store/menuInsert" method="post">
                        <input type="hidden" name="menu_category_id" value="${category.menu_category_id}"/>
                        <input type="submit" value="+ 메뉴 추가" class="btn btn-primary"/>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
  
  <!-- 카테고리 추가 폼 -->
  <div class="register-form">
    <h3>새 카테고리 추가</h3>
    <c:if test="${not empty errorMessage }">
    	<div class="alert alert-danger">
    		<font color="red"> ${errorMessage } </font>
    	</div>
    </c:if>
    <form:form action="/store/categoryRegister" modelAttribute="menuCategory" method="post">
      <div class="form-group">
        <label for="menu_category_name">카테고리명:</label>
        <form:input path="menu_category_name" cssClass="form-control"/>
        <form:errors path="menu_category_name" cssClass="error"/>
      </div>
      <input type="submit" value="카테고리 추가" class="btn btn-primary">
    </form:form>
  </div>

  <script>
    // 카테고리 클릭 시 토글 기능
    var headers = document.querySelectorAll('.category-header');
    for(var i = 0; i < headers.length; i++) {
        headers[i].addEventListener('click', function(e) {
            // 버튼 클릭시 토글 동작 방지
            if (e.target.classList.contains('btn')) {
                e.stopPropagation();
                return;
            }
            var category = this.parentElement;
            category.classList.toggle('active');
            this.classList.toggle('active');
        });
    }
    
    // 메뉴 삭제 확인
    function confirmDelete(){
        if(confirm("정말로 삭제하시겠습니까?")){
            return true;
        }else{
            return false;
        }
    }
    
    // 카테고리 삭제 확인
    function confirmCategoryDelete(){
        if(confirm("이 카테고리와 관련된 모든 메뉴가 삭제됩니다.\n정말로 삭제하시겠습니까?")){
            return true;
        }else{
            return false;
        }
    }
    // 카테고리 수정
    function confirmCategoryUpdate(categoryId){
    	const newCategoryName = prompt("새 카테고리명을 입력하세요","");
    	
    	if(newCategoryName !== null && newCategoryName !== ""){
    	const inputElement = document.getElementById('menu_category_name_'+categoryId);
    	inputElement.value = newCategoryName;
    	return true;
    	}else{
    		alert("카테고리명을 입력해주세요.");
    		return false;
    	}
    }
  </script>
</body>
</html>