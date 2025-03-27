<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="card">
    <div class="card-header">
        <h5 class="mb-0"><i class="fas fa-edit"></i> 사업자 공지사항 수정</h5>
    </div>
    <div class="card-body">
        <form action="/admin/ownerNotice/edit" method="post">
        	<input type="hidden" name="notice_id" value="${notice.notice_id}">
            <div class="mb-3">
                <label for="title" class="form-label">제목</label>
                <input type="text" class="form-control" id="title" name="title" required value="${notice.title}">
            </div>

            <div class="mb-3">
                <label for="content" class="form-label">내용</label>
                <textarea class="form-control" id="content" name="content" rows="10" required>${notice.content}</textarea>
            </div>

            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="important" name="important" value="Y" <c:if test="${notice.important eq 'Y'}">checked</c:if>>
                <label class="form-check-label" for="important">중요 공지사항</label>
            </div>

            <div class="text-center mt-4">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> 저장하기
                </button>
                <a href="/admin/userNotice" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> 취소
                </a>
            </div>
        </form>
    </div>
</div>