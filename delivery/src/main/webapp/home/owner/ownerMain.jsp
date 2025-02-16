<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 메인 화면</title>
<style>
    /* 로그아웃 링크와 사용자 이름을 우측 상단에 배치 */
    .logout-container {
        position: absolute;
        top: 20px;
        right: 20px;
        font-size: 16px;
    }

    .logout-container a {
        margin-left: 10px;
    }

    /* 중앙 정렬된 div */
    .center-content {
        text-align: center;
    }

    /* 메뉴 크기 조정 */
    h2 {
        font-size: 20px;
    }

    /* 이미지 크기 고정 */
    .profile-image {
        width: 35px;
        height: 35px;
        object-fit: cover; /* 비율을 맞추기 위해 이미지 자르기 */
    }
</style>
</head>
<body>
	
    <!-- 로그아웃 링크와 사용자 이름을 우측 상단에 배치 -->
    <div class="logout-container">
        <c:choose>
            <c:when test="${owner.owner_image_name != null}">
                <img alt="Profile Image" class="profile-image" src="${pageContext.request.contextPath}/upload/${owner.owner_image_name}" />
            </c:when>
            <c:otherwise>
                <img alt="No Image" class="profile-image" src="${pageContext.request.contextPath}/image/noImage.png" />
            </c:otherwise>
        </c:choose>
        <span>${owner.owner_name}님</span>
        <a href="/owner/logout">로그아웃</a>
    </div>
    
    <div class="center-content">
        <h3>사업자 메인 페이지</h3> <!-- 제목 크기 작게 조정 -->

        <hr>

        <!-- 메뉴 (더 크게) -->
        <h2>
            <a href="/store/list">매장 목록</a> |
            <a href="/owner/storeRegister">매장 등록</a>
        </h2>

        <hr>
    </div>
</body>
</html>
