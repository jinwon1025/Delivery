<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복체크중</title>
</head>
<body>
<h2 align="center">아이디 중복 확인</h2>
<form action="/owner/idcheck">
계정 : <input type="text" name="owner_id" value="${owner_id }"/>
	<input type="submit" value="중복검사"/>
</form>
<c:choose>
	<c:when test="${DUP == 'NO' }">
		${owner_id }는 사용 가능합니다.
		<input type="button" value="아이디 사용" onclick="idOk('${owner_id}')"/>
	</c:when>
	<c:otherwise>
				${owner_id }는 사용중입니다.
		<script type="text/javascript">
			opener.document.frm.owner_id.value="";
		</script>
	</c:otherwise>

</c:choose>
	<script type="text/javascript">
	function idOk(id){
	opener.document.frm.owner_id.value=id;
	opener.document.frm.owner_id.readOnly = true;
	opener.document.frm.idchecked.value="yes";
	self.close();
	}
	
	</script>
</body>
</html>