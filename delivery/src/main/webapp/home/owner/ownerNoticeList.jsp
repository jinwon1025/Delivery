<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 - 금베달리스트 사업자</title>
    
    <!-- 공통 CSS 파일 -->
    <link rel="stylesheet" href="<c:url value='/css/common/reset.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/common/typography.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/common/layout.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/common/utilities.css'/>">
    
    <!-- 사업자 CSS 파일 -->
    <link rel="stylesheet" href="<c:url value='/css/store/store-layout.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/store/store-components.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/store/store-pages.css'/>">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- Google Fonts - Noto Sans KR -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
</head>
<body>

    <!-- 메인 컨텐츠 -->
    <main class="main-content">
        <div class="store-container">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">사업자 공지사항</h2>
                </div>
                <div class="card-body">
                    <div class="table-container">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th style="width: 10%">번호</th>
                                    <th style="width: 55%">제목</th>
                                    <th style="width: 15%">작성자</th>
                                    <th style="width: 15%">작성일</th>
                                    <th style="width: 5%">조회</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty noticeList}">
                                    <tr>
                                        <td colspan="5" class="text-center py-4">등록된 공지사항이 없습니다.</td>
                                    </tr>
                                </c:if>
                                
                                <c:forEach var="notice" items="${noticeList}">
                                    <tr class="${notice.important == 'Y' ? 'bg-gray-100' : ''}">
                                        <td>${notice.notice_id}</td>
                                        <td>
                                            <a href="/owner/notice/${notice.notice_id}" class="text-gray-800 hover:text-primary">
                                                <c:if test="${notice.important == 'Y'}">
                                                    <span class="badge bg-primary text-white text-xs px-2 py-1 rounded-pill mr-2">중요</span>
                                                </c:if>
                                                ${notice.title}
                                            </a>
                                        </td>
                                        <td>${notice.writer}</td>
                                        <td class="text-gray-600">
                                            <fmt:formatDate value="${notice.reg_date}" pattern="yyyy-MM-dd"/>
                                        </td>
                                        <td class="text-center">${notice.view_count}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>

    
    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>