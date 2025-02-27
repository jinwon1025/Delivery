<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="card">
    <div class="card-header">
        <h5 class="mb-0"><i class="fas fa-bullhorn"></i> 사용자 공지사항 관리</h5>
    </div>
    <div class="card-body">
        <div class="d-flex justify-content-end mb-3">
            <a href="/admin/userNotice/write" class="btn btn-primary">
                <i class="fas fa-plus"></i> 공지사항 작성
            </a>
        </div>
        
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th>중요</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty noticeList}">
                        <tr>
                            <td colspan="7" class="text-center">등록된 공지사항이 없습니다.</td>
                        </tr>
                    </c:if>
                    
                    <c:forEach var="notice" items="${noticeList}">
                        <tr>
                            <td>${notice.notice_id}</td>
                            <td>
                                <c:if test="${notice.important == 'Y'}">
                                    <span class="badge bg-danger">중요</span>
                                </c:if>
                                ${notice.title}
                            </td>
                            <td>${notice.writer}</td>
                            <td><fmt:formatDate value="${notice.reg_date}" pattern="yyyy-MM-dd"/></td>
                            <td>${notice.view_count}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${notice.important == 'Y'}">
                                        <span class="badge bg-success">O</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">X</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="/admin/userNotice/edit/${notice.notice_id}" class="btn btn-sm btn-secondary">
                                    <i class="fas fa-edit"></i> 수정
                                </a>
                                <a href="#" onclick="if(confirm('정말 삭제하시겠습니까?')) { location.href='/admin/userNotice/delete/${notice.notice_id}'; return false; }" class="btn btn-sm btn-danger">
                                    <i class="fas fa-trash"></i> 삭제
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>