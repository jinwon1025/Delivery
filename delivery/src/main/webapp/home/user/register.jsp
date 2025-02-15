<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery 라이브러리 추가 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- jQuery UI 라이브러리 추가 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

    <style>
        /* 간단한 스타일링 */
        body {
            font-family: Arial, sans-serif;
        }
    </style>
<title>사용자 가입화면</title>
</head>
<body>
<h2>회원가입</h2>
<form:form action="/user/insertRegister" method="post" modelAttribute="user">
<table>
	<tr><th>아이디</th><td><form:input path="user_id" id="user_id" placeholder="아이디 입력(15자 이하)"/><font color="red"><form:errors path="user_id"/></font>
	<tr><th>비밀번호</th><td><form:password path="password" id="password" placeholder="비밀번호 입력(8자이상 영문+숫자)"/><font color="red"><form:errors path="password"/></font>
	<tr><th>이름</th><td><form:input path="user_name" id="user_name" placeholder="이름을 입력해주세요"/><font color="red"><form:errors path="user_name"/></font>
	<tr><th>전화번호</th><td><form:input path="user_phone" id="user_phone" placeholder="전화번호를 입력해주세요"/><font color="red"><form:errors path="user_phone"/></font>
	<tr><th>이메일</th><td><form:input path="email" id="email" placeholder="이메일을 입력해주세요"/><font color="red"><form:errors path="email"/></font>
	<tr><th>생년월일</th><td><form:input path="birth" id="birth" placeholder="생일을 선택하세요"/><font color="red"><form:errors path="birth"/></font>
</table>
	<input type="submit" value="가입하기">
<script>
        // jQuery UI Datepicker 활성화
        $(document).ready(function(){
            $("#birth").datepicker({
                dateFormat: "yy-mm-dd", // 날짜 형식 설정 (예: 2025-02-14)
                changeMonth: true,      // 월 선택
                changeYear: true,       // 연도 선택
                yearRange: "1900:2025", // 선택 가능한 연도 범위 설정
            });
        });
    </script>
</form:form>
</body>
</html>