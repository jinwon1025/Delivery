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
                    <!-- 페이지 정보 표시 -->
                    <div align="right" style="padding: 0 10px 10px 0;">
                        ${START + 1}~${END - 1}/${TOTAL}
                    </div>
                    
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
                                <c:if test="${empty LIST}">
                                    <tr>
                                        <td colspan="5" class="text-center py-4">등록된 공지사항이 없습니다.</td>
                                    </tr>
                                </c:if>
                                
                                <c:forEach var="notice" items="${LIST}">
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
                    
                    <!-- 페이지네이션 -->
                    <div align="center" style="margin-top: 20px;">
                        <c:set var="currentPage" value="${currentPage}"/>
                        <c:set var="pageCount" value="${(TOTAL + 4) / 5}"/>
                        <c:set var="startPage" value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1}"/>
                        <c:set var="endPage" value="${startPage + 9}"/>
                        
                        <c:if test="${endPage > pageCount}">
                            <c:set var="endPage" value="${pageCount}"/>
                        </c:if>
                        
                        <c:if test="${startPage > 10}">
                            <a href="<c:url value='/owner/notice?PAGE_NUM=${startPage - 1}'/>" style="margin: 0 5px;">[이전]</a>
                        </c:if>
                        
                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                            <c:if test="${currentPage == i}">
                                <font size="5">
                            </c:if>
                            <a href="<c:url value='/owner/notice?PAGE_NUM=${i}'/>" style="margin: 0 5px;">${i}</a>
                            <c:if test="${currentPage == i}">
                                </font>
                            </c:if>
                        </c:forEach>
                        
                        <c:if test="${endPage < pageCount}">
                            <a href="<c:url value='/owner/notice?PAGE_NUM=${endPage + 1}'/>" style="margin: 0 5px;">[다음]</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </main>

    
    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>