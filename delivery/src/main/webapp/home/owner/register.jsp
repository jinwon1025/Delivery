<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 회원가입</title>
</head>
<body>
	<h3 align="center">사업자 회원가입</h3>
	<form:form action="/owner/register" method="post"
		modelAttribute="owner" enctype="multipart/form-data" name="frm" onsubmit="return totalcheck()">
		<form:hidden path="idchecked" />
아이디 : <br />
		<form:input path="owner_id" />
		<input type="button" value="중복검사" onclick="idcheck()" />
		<br />
		<font color="red"><form:errors path="owner_id" /></font>
		<br />
		<font color="red"><form:errors path="idchecked" /></font>
		<br />


비밀번호 : <br />
		<form:password path="owner_password" onkeyup="checkPassword()" />
		<br />
		<font color="red"><form:errors path="owner_password" /></font>
		<br />
비밀번호 확인 : <br />
		<input type="password" name="CONFIRM" onkeyup="checkPassword()" />
		<br />
		<div id="passwordMatch" style="color: red;"></div>
		<br />
이름 : <br />
		<form:input path="owner_name" />
		<br />
		<font color="red"><form:errors path="owner_name" /></font>
		<br />
		<br />
이메일 : <br />
		<form:input path="owner_email" />
		<br />
		<font color="red"><form:errors path="owner_email" /></font>
		<br />
		<br />
프로필 이미지 : <br />
		<input type="file" name="image">
		<br />
		<br />
전화번호 : <br />
		<form:input path="owner_phone" />
		<br />
		<font color="red"><form:errors path="owner_phone" /></font>
		<br />
		<br />


		<input type="submit" value="회원가입" />

		<script type="text/javascript">
function idcheck(){
if(document.frm.owner_id.value == ''){
alert("아이디를 입력하세요.");
document.frm.owner_id.focus();
return false;
} else {
if(document.frm.owner_id.value.length < 5 ||
document.frm.owner_id.value.length > 15){
alert("계정은 5자 이상, 15자 이하로 입력하세요.");
document.frm.owner_id.focus();
return false;
}
}
var url = "/owner/idcheck?owner_id=" + document.frm.owner_id.value;
window.open(url, "_blank_", "width=450, height=200");
}




function totalcheck() {
// 아이디가 비어있거나 공백만 있는 경우는 검사하지 않고 @NotBlank 메시지가 표시되도록 함
if(document.frm.owner_id.value.trim() === '') {
return true; // 폼 제출을 허용하여 서버 측 @NotBlank 검증이 동작하도록 함
}

// 아이디가 입력되어 있는데 중복검사를 하지 않은 경우
if(document.frm.idchecked.value == '') {
alert("아이디 중복검사를 해야합니다.");
return false;
}


return true;
}
</script>

	</form:form>
</body>
</html>