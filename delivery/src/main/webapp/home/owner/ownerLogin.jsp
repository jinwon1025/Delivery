<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 메인화면</title>
<style>
    /* 테이블 중앙 정렬 */
    .login-box table {
        margin-left: auto;
        margin-right: auto;
    }
</style>
</head>
<body>

<!-- 사업자 로그인 창 -->
<div class="login-box">
    <h2>사업자 로그인</h2>

    <form:form action="/owner/loginDo" method="post" modelAttribute="loginOwner">
        <table>
            <tr>
                <td><label for="id">아이디</label></td>
                <td><form:input path="id" id="id" size="12"/></td>
                <td><font color="red"><form:errors path="id"/></font></td>
            </tr>
            <tr>
                <td><label for="password">비밀번호</label></td>
                <td><form:input path="password" id="password" size="12" type="password"/></td>
                <td><font color="red"><form:errors path="password"/></font></td>
            </tr>
        </table>

        <p><input type="submit" value="로그인"/></p>
    </form:form>

    <hr>
    <p><a href="/owner/goRegister">회원가입</a></p>
</div>

</body>
</html>
