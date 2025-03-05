<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<c:if test="${FAIL == 'YES'}">
    <div class="alert alert-error mt-3">
        <i class="fas fa-exclamation-circle mr-2"></i>
        로그인에 실패했습니다. 아이디와 비밀번호를 확인해주세요.
    </div>
</c:if>