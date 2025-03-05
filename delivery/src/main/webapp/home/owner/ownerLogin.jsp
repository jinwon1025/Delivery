<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>   

<div class="auth-container">
    <div class="auth-header">
        <h2 class="auth-title">사업자 로그인</h2>
        <p class="auth-subtitle">금베달리스트 사업자 센터에 오신 것을 환영합니다</p>
    </div>
    
    <div class="auth-form">
        <form:form action="/owner/loginDo" method="post" modelAttribute="loginOwner">
            <div class="form-group">
                <label for="id" class="form-label">아이디</label>
                <form:input path="id" id="id" class="form-control" placeholder="사업자 아이디를 입력하세요"/>
                <font color="red"><form:errors path="id"/></font>
            </div>
            
            <div class="form-group">
                <label for="password" class="form-label">비밀번호</label>
                <form:password path="password" id="password" class="form-control" placeholder="비밀번호를 입력하세요"/>
                <font color="red"><form:errors path="password"/></font>
            </div>
            
            <div class="form-group form-check">
                <input type="checkbox" id="remember" class="form-check-input">
                <label for="remember" class="form-check-label">로그인 상태 유지</label>
            </div>
            
            <button type="submit" class="btn-auth">로그인</button>
        </form:form>
    </div>
    
    <c:if test="${BBODY != null}">
        <div class="mt-3">
            <jsp:include page="${BBODY}" />
        </div>
    </c:if>
    
    <div class="auth-footer">
        <p>아직 계정이 없으신가요? <a href="<c:url value='/owner/goRegister'/>" class="auth-link">회원가입</a></p>
    </div>
</div>