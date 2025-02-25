<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="center-content">
    <c:forEach var="category" items="${storeCategory}" varStatus="status">
        <a href="/userstore/menuList?menu_category_id=${category.menu_category_id}">${category.menu_category_name}</a>
        <c:if test="${!status.last}"> | </c:if>
    </c:forEach>
    <hr>
    <h1>${sessionScope.currentStore.store_name} (${sessionScope.currentStore.store_id})</h1>
    <c:choose>
        <c:when test="${STOREBODY != null}">
            <jsp:include page="${STOREBODY}" />
        </c:when>
    </c:choose>
</div>
