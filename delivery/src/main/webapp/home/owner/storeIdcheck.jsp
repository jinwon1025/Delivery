<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가게 아이디 중복체크</title>
</head>
<body>
<h2 align="center">가게 아이디 중복 확인</h2>
<form action="/store/idcheck">
계정 : <input type="text" name="store_id" value="${store_id }"/>
	<input type="submit" value="중복검사"/>
</form>
<c:choose>
	<c:when test="${DUP == 'NO' }">
		${store_id }는 사용 가능합니다.
		<input type="button" value="아이디 사용" onclick="idOk('${store_id}')"/>
	</c:when>
	<c:otherwise>
				${store_id }는 사용중입니다.
		<script type="text/javascript">
			opener.document.frm.store_id.value="";
		</script>
	</c:otherwise>

</c:choose>
	<script type="text/javascript">
	function idOk(id){
	opener.document.frm.store_id.value=id;
	opener.document.frm.store_id.readOnly = true;
	opener.document.frm.idchecked.value="yes";
	self.close();
	}
	
	</script>
</body>
</html>