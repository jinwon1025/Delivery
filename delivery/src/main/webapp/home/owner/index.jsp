<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 메인화면</title>
</head>
<body>

<!-- 배경색 적용 -->
<table width="100%" height="100%" bgcolor="#f8f9fa">
    <tr>
        <td align="center" valign="middle">

            <!-- 사업자 로그인 창 -->
            <div style="background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); width: 350px; text-align: center;">
                <h1>금베달리스트</h1>
                <hr>
                <h2>사업자 로그인</h2>

                <form:form action="/owner/loginDo" method="post" modelAttribute="loginOwner">
                    <table align="center">
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

        </td>
    </tr>
</table>

</body>
</html>
