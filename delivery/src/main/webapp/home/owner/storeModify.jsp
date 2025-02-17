<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매장 등록</title>
</head>
<body>
	<h3 align="center">매장 등록</h3>
	<form:form action="/store/modify" method="post"
		modelAttribute="store" enctype="multipart/form-data" name="frm"
		onsubmit="return totalcheck()">
        
        아이디(5자 이상 15자 이하) : <br />
		<form:input path="store_id" readonly="true"/>
		<br />
        
        가게명 : <br />
		<form:input path="store_name" />
		<br />
		<font color="red"><form:errors path="store_name" /></font>
		<br />
        
        
        주소 : <br />
		<form:input path="store_address" />
		<br />
		<font color="red"><form:errors path="store_address" /></font>
		<br />
        
       	최소주문금액 : <br />
		<form:input path="last_price" />
		<br />
		<font color="red"><form:errors path="last_price" /></font>
		<br /><br/>
        
        메인 카테고리 :
        <form:select path="main_category_Id">
			<form:option value="1">치킨</form:option>
			<form:option value="2">중식</form:option>
			<form:option value="3">돈까스·회</form:option>
			<form:option value="4">피자</form:option>
			<form:option value="5">패스트푸드</form:option>
			<form:option value="6">찜·탕</form:option>
			<form:option value="7">족발·보쌈</form:option>
			<form:option value="8">분식</form:option>
			<form:option value="9">카페·디저트</form:option>
			<form:option value="10">한식</form:option>

		</form:select><br/><br/>
        
        가게 전화번호 : <br />
		<form:input path="store_phone" />
		<br />
		<font color="red"><form:errors path="store_phone" /></font>
		<br /><br/>
        
        가게 영업시간 : <br />
		<form:input path="store_openHour" />
		<br />
		<font color="red"><form:errors path="store_phone" /></font>
		<br /><br/>
        
        배달요금 : <br />
		<form:input path="delivery_fee" />
		<br />
		<font color="red"><form:errors path="delivery_fee" /></font>
		<br /><br/>
        
        가게 프로필 이미지 : 
		<input type="file" name="image">
		<br /><br/>
        
 
 		원산지 : <br />
		<form:input path="made_in" />
		<br />
		<font color="red"><form:errors path="made_in" /></font>
		<br />
 		
		<br />


		<input type="submit" value="매장등록" />

		<script type="text/javascript">

            function totalcheck() {
               if(confirm("정말로 수정하시겠습니까?")){
            	   return true;
               }
               else {
            	   return false;
               }
            }
        </script>

	</form:form>
</body>
</html>
