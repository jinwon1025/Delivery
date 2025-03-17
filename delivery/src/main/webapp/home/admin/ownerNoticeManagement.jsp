<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="card">
    <div class="card-header">
        <h5 class="mb-0"><i class="fas fa-bullhorn"></i> 사업자 공지사항 관리</h5>
    </div>
    <div class="card-body">
        <div class="d-flex justify-content-between mb-3">
            <!-- 페이지 정보 표시 -->
            <div>
                ${START + 1}~${END - 1}/${TOTAL}
            </div>
            <a href="/admin/ownerNotice/write" class="btn btn-primary">
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
                    <c:if test="${empty LIST}">
                        <tr>
                            <td colspan="7" class="text-center">등록된 공지사항이 없습니다.</td>
                        </tr>
                    </c:if>

                    <c:forEach var="notice" items="${LIST}">
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
                                <a href="/admin/ownerNotice/edit/${notice.notice_id}" class="btn btn-sm btn-secondary">
                                    <i class="fas fa-edit"></i> 수정
                                </a>
                                <a href="#" onclick="if(confirm('정말 삭제하시겠습니까?')) { location.href='/admin/ownerNotice/delete/${notice.notice_id}'; return false; }" class="btn btn-sm btn-danger">
                                    <i class="fas fa-trash"></i> 삭제
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- 페이지네이션 (예제와 동일한 방식) -->
        <div align="center" style="margin-top: 20px;">
            <c:set var="currentPage" value="${currentPage}"/>
            <c:set var="pageCount" value="${pageCount}"/>
            <c:set var="startPage" value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1}"/>
            <c:set var="endPage" value="${startPage + 9}"/>
            
            <c:if test="${endPage > pageCount}">
                <c:set var="endPage" value="${pageCount}"/>
            </c:if>
            
            <c:if test="${startPage > 10}">
                <a href="/admin/ownerNotice?PAGE_NUM=${startPage - 1}">[이전]</a>
            </c:if>
            
            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                <c:if test="${currentPage == i}">
                    <font size="6">
                </c:if>
                <a href="/admin/ownerNotice?PAGE_NUM=${i}">${i}</a>
                <c:if test="${currentPage == i}">
                    </font>
                </c:if>
            </c:forEach>
            
            <c:if test="${endPage < pageCount}">
                <a href="/admin/ownerNotice?PAGE_NUM=${endPage + 1}">[다음]</a>
            </c:if>
        </div>
    </div>
</div>