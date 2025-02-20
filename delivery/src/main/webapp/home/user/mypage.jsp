<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container">
    <div class="row">
        <div class="col-lg-8 mx-auto">
            <h2 class="mb-4">마이페이지</h2>
            
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">회원 정보</h5>
                </div>
                <div class="card-body">
                    <table class="table">
                        <tr>
                            <th>아이디</th>
                            <td>${userInfo.user_id}</td>
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td>${userInfo.user_name}</td>
                        </tr>
                        <tr>
                            <th>비밀번호</th>
                            <td>••••••••</td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td>${userInfo.user_phone}</td>
                        </tr>
                        <tr>
                            <th>생년월일</th>
                            <td>${userInfo.birth}</td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td>${userInfo.email}</td>
                        </tr>
                        <c:if test="${not empty userInfo.point}">
                            <tr>
                                <th>포인트</th>
                                <td>${userInfo.point}</td>
                            </tr>
                        </c:if>
                    </table>
                    
                    <div class="mt-3">
                        <a href="<c:url value='/user/updateForm'/>" class="btn btn-primary">회원정보 수정</a>
                    </div>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">서비스 바로가기</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <a href="#" class="btn btn-outline-secondary w-100">리뷰 관리</a>
                        </div>
                        <div class="col-md-6 mb-3">
                            <a href="#" class="btn btn-outline-secondary w-100">결제수단 관리</a>
                        </div>
                        <div class="col-md-6 mb-3">
                            <a href="#" class="btn btn-outline-secondary w-100">주소 관리</a>
                        </div>
                        <div class="col-md-6 mb-3">
                            <a href="#" class="btn btn-outline-secondary w-100">쿠폰함</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>