<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>금베달리스트 메인</title>
<style>
/* 로그아웃 링크와 사용자 이름을 우측 상단에 배치 */
.logout-container {
   position: absolute;
   top: 20px;
   right: 20px;
   font-size: 16px;
   display: flex;
   align-items: center; /* 수직 중앙 정렬 */
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

/* 금베달리스트 텍스트와 로그아웃의 정렬을 맞추기 */
h1 {
   display: inline-block;
   vertical-align: middle;
   line-height: 50px; /* 원하는 높이에 맞게 설정 */
}
</style>
</head>
<body>

   <!-- 로그아웃 링크와 사용자 이름을 우측 상단에 배치 -->
   <div class="logout-container">
      <c:choose>
         <c:when test="${sessionScope.loginOwner != null}">
            <c:choose>
               <c:when test="${not empty sessionScope.loginOwner.image_name}">
                  <!-- 사업자의 프로필 사진이 있을 때 -->
                  <img alt="Profile Image" class="profile-image"
                     src="${pageContext.request.contextPath}/upload/ownerProfile/${sessionScope.loginOwner.image_name}" />
               </c:when>
               <c:otherwise>
                  <!-- 사업자의 프로필 사진이 없을 때 -->
                  <img alt="No Image" class="profile-image"
                     src="${pageContext.request.contextPath}/image/noImage.png" />
               </c:otherwise>
            </c:choose>
            <span>${sessionScope.loginOwner.name}님</span>
            <a href="">마이페이지</a>
            <a href="/owner/logout">로그아웃</a>

         </c:when>
         <c:otherwise>
            <a href="/owner/goLogin">로그인</a>

         </c:otherwise>
      </c:choose>
   </div>

   <div class="center-content">


      <!-- 메   뉴 (더 크게) -->
      <c:forEach var="category" items="${storeCategory}" varStatus="status">

         <a href="/userstore/menuList?menu_category_id=${category.menu_category_id }">${category.menu_category_name}</a>
         <c:if test="${!status.last}">
            <!-- 첫 번째 항목이 아닌 경우에만 '|' 출력 -->
        |
    </c:if>
      </c:forEach>
      <hr>
      <h1>${sessionScope.currentStore.store_name }(${sessionScope.currentStore.store_id })</h1>
      <c:choose>
         <c:when test="${STOREBODY != null}">
            <jsp:include page="${STOREBODY}" />
         </c:when>
      </c:choose>
   </div>
</body>
</html>