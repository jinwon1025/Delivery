<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container">
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <h2 class="mb-4">회원정보 수정</h2>
            
            <div class="card">
                <div class="card-body">
                    <form action="<c:url value='/user/updateUser'/>" method="post">
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">아이디</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control-plaintext" name="user_id" value="${userInfo.user_id}" readonly>
                            </div>
                        </div>
                        
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">이메일</label>
                            <div class="col-sm-9">
                                <input type="email" class="form-control-plaintext" name="email" value="${userInfo.email}" readonly>
                            </div>
                        </div>
                        
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">이름</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" name="user_name" value="${userInfo.user_name}" required>
                            </div>
                        </div>
                        
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">전화번호</label>
                            <div class="col-sm-9">
                                <div class="row">
                                    <div class="col-3">
                                        <select class="form-select" name="phone1" required>
                                            <option value="010" ${userInfo.user_phone.startsWith('010') ? 'selected' : ''}>010</option>
                                            <option value="011" ${userInfo.user_phone.startsWith('011') ? 'selected' : ''}>011</option>
                                            <option value="016" ${userInfo.user_phone.startsWith('016') ? 'selected' : ''}>016</option>
                                            <option value="017" ${userInfo.user_phone.startsWith('017') ? 'selected' : ''}>017</option>
                                            <option value="018" ${userInfo.user_phone.startsWith('018') ? 'selected' : ''}>018</option>
                                            <option value="019" ${userInfo.user_phone.startsWith('019') ? 'selected' : ''}>019</option>
                                        </select>
                                    </div>
                                    <div class="col-4">
                                        <c:set var="phone2" value="${userInfo.user_phone.length() >= 7 ? userInfo.user_phone.substring(3, 7) : ''}"/>
                                        <input type="text" class="form-control" name="phone2" value="${phone2}" maxlength="4" required>
                                    </div>
                                    <div class="col-4">
                                        <c:set var="phone3" value="${userInfo.user_phone.length() >= 11 ? userInfo.user_phone.substring(7) : ''}"/>
                                        <input type="text" class="form-control" name="phone3" value="${phone3}" maxlength="4" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3 row">
                            <label class="col-sm-3 col-form-label">생년월일</label>
                            <div class="col-sm-9">
                                <input type="date" class="form-control" name="birth" value="${userInfo.birth}" required>
                            </div>
                        </div>
                        
                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" class="btn btn-primary">정보 수정하기</button>
                            <a href="<c:url value='/user/mypage'/>" class="btn btn-secondary">취소</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>