<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>메뉴 옵션 등록</title>
  <style>
    * {
      box-sizing: border-box;
      font-family: 'Noto Sans KR', sans-serif;
    }
    
    .menu-container {
      max-width: 800px;
      margin: 0 auto;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      overflow: hidden;
    }
    
    .menu-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 20px;
      background-color: #f9f9f9;
      border-bottom: 1px solid #eee;
    }
    
    .menu-header .menu-title {
      display: flex;
      align-items: center;
    }
    
    .menu-header img {
      width: 35px;
      height: 35px;
      object-fit: cover;
      margin-right: 10px;
      border-radius: 4px;
    }
    
    .button-group {
      display: flex;
      gap: 10px;
      align-items: center;
    }
    
    .menu-content {
      padding: 15px 20px;
    }
    
    .menu-description {
      color: #666;
      margin: 10px 0;
    }
    
    .menu-price {
      color: #ff3d00;
      font-weight: bold;
      font-size: 1.1em;
    }
    
    .option-group {
      border-top: 1px solid #eee;
      padding: 15px 20px;
    }
    
    .option-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }
    
    .option-item {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 10px;
      background-color: #f8f8f8;
      border-radius: 4px;
      margin-bottom: 10px;
    }
    
    .btn {
      padding: 8px 16px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-weight: 500;
    }
    
    .btn-primary {
      background-color: #2AC1BC;
      color: white;
    }
    
    .btn-delete {
      background-color: #ff6b6b;
      color: white;
    }

    .btn-edit {
      background-color: #4a9eff;
      color: white;
      padding: 6px 12px;
      font-size: 0.9em;
    }
    
    input, select {
      padding: 8px 12px;
      border: 1px solid #ddd;
      border-radius: 4px;
      margin-right: 8px;
    }
    
    .option-form {
      margin-bottom: 15px;
    }
    
    .option-form input[type="text"] {
      width: 250px;
    }
    
    .option-form input[type="number"] {
      width: 120px;
    }

    .sub-options {
      margin: 15px 0 15px 20px;
      padding: 15px;
      border-left: 2px solid #ddd;
    }

    .sub-options input[readonly] {
      background-color: #f5f5f5;
    }

    .sub-option-row {
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .sub-option-row input[type="text"],
    .sub-option-row input[name="option_name"] {
      width: 200px;
    }

    .sub-option-row input[type="number"],
    .sub-option-row input[name="subOption"]:nth-child(2),
    .sub-option-row input[name="option_price"] {
      width: 120px;
    }
    
    .btn-container {
      display: flex;
      gap: 4px;
    }
  </style>
</head>
<body>
  <div class="menu-container">
    <div class="menu-header">
      <div class="menu-title">
        <img src="${pageContext.request.contextPath}/upload/menuItemProfile/${menuInfo.image_name}" 
             alt="${menuInfo.menu_name}" 
             onerror="this.src='${pageContext.request.contextPath}/image/noImage.png'">
        <h3>${menuInfo.menu_name}</h3>
      </div>
    </div>

    <div class="menu-content">
      <p class="menu-description">${menuInfo.content}</p>
      <p class="menu-price">${menuInfo.price}원</p>
    </div>

    <div class="option-group">
      <div class="option-header">
        <h4>옵션 카테고리 추가</h4>
      </div>
      <form action="/store/addOption" method="post" class="option-form">
        <input type="hidden" name="menu_category_id" value="${menuInfo.menu_category_id}"/>
        <input type="text" id="category_name" name="category_name" placeholder="카테고리 이름 (예: 소스 선택)">
        <input type="submit" value="카테고리 추가" class="btn btn-primary"/>
      </form>
    </div>

   <div id="categories-list">
  <c:if test="${not empty optionList}">
    <c:forEach var="category" items="${optionList}">
      <div class="option-group">
        <div class="option-item">
          <div><strong>${category.option_group_name}</strong></div>
          <div class="btn-container">
            <form action="/store/updateOptionCategory" method="post" style="display: inline-block; margin-right: 4px;"
            	onsubmit="return updateOptionCategory()">
              <input type="hidden" name="option_group_id" value="${category.option_group_id}"/>
              <input type="hidden" id="newOptionName" name="newOptionName"/>
              <button type="submit" class="btn btn-edit">수정</button>
            </form>
            <form action="/store/deleteOptionCategory" method="post" style="display: inline-block;"
            	onsubmit="return deleteOptionCategory()">
              <input type="hidden" name="option_group_id" value="${category.option_group_id}"/>
              <button type="submit" class="btn btn-delete">삭제</button>
            </form>
          </div>
        </div>
        <div class="sub-options">
          <c:forEach var="optionSet" items="${subOptionList}">
            <c:if test="${category.option_group_id == optionSet.option_group_id}">
              <div class="sub-option-row">
                <input type="text" name="subOption" value="${optionSet.option_name}" readonly="readonly"/>
                <input type="text" name="subOption" value="${optionSet.option_price}" readonly="readonly"/>
                <div class="btn-container">
                  <form action="/store/goUpdateSubOption" method="get" style="display: inline-block; margin-right: 4px;">
                    <input type="hidden" name="option_group_id" value="${category.option_group_id}"/>
                    <input type="hidden" name="option_id" value="${optionSet.option_id}"/>
                    <button type="submit" class="btn btn-edit">수정</button>
                  </form>
                  <form action="/store/deleteSubOption" method="post" style="display: inline-block;"
                      onsubmit="return deleteCheck()">
                    <input type="hidden" name="option_group_id" value="${category.option_group_id}"/>
                    <input type="hidden" name="option_id" value="${optionSet.option_id}"/>
                    <button type="submit" class="btn btn-delete">삭제</button>
                  </form>
                </div>
              </div>
            </c:if>
          </c:forEach>
          <form action="/store/addSubOption" method="post">
            <input type="hidden" name="option_group_id" value="${category.option_group_id}"/>
            <div class="sub-option-row">
              <input type="text" name="option_name" placeholder="하위 옵션 이름">
              <input type="text" name="option_price" placeholder="추가 가격">
              <button type="submit" class="btn btn-primary">하위 옵션 추가</button>
            </div>
          </form>
        </div>
      </div>
    </c:forEach>
  </c:if>
</div>
  </div>
 <script type="text/javascript">
 function deleteCheck(){
	 if(confirm("정말로 옵션을 삭제하시겠습니까?")){
		 return true;
	 } else {
		 return false;
	 }
 }
 
 function updateOptionCategory(){
	 const 	 newOption = prompt("수정할 옵션명을 입력하세요.");
	 if(newOption!== null && newOption !== "" ){
		 const input = document.getElementById('newOptionName');
		 input.value = newOption;
		 return true;
	 } else {
		 alert("옵션명을 입력해주세요.");
		 return false;
	 }
 }
 
 function deleteOptionCategory(){
	 if(confirm("정말로 옵션 카테고리를 삭제하시겠습니까?")){
		 return true;
	 } else {
		 return false;
	 }
 }
 </script>
</body>
</html>