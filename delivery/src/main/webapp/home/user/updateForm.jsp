<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="page-header">
    <h1 class="page-title">회원정보 수정</h1>
    <p class="page-subtitle">나의 정보를 안전하게 관리하세요</p>
</div>

<div class="mypage-container">
    <!-- 사이드바 메뉴 -->
    <div class="mypage-sidebar">
        <div class="mypage-menu">
            <div class="mypage-menu-header">
                마이 금베달
            </div>
            <ul class="mypage-menu-list">
                <li class="mypage-menu-item">
                    <a href="<c:url value='/user/mypage'/>" class="mypage-menu-link active">
                        <i class="fas fa-user"></i>
                        <span>내 정보</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="<c:url value='/user/bookMarkList'/>" class="mypage-menu-link">
                        <i class="fas fa-heart"></i>
                        <span>즐겨찾기</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="<c:url value='/userstore/viewCart'/>" class="mypage-menu-link">
                        <i class="fas fa-shopping-cart"></i>
                        <span>장바구니</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="#" class="mypage-menu-link">
                        <i class="fas fa-history"></i>
                        <span>주문 내역</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="#" class="mypage-menu-link">
                        <i class="fas fa-ticket-alt"></i>
                        <span>쿠폰함</span>
                    </a>
                </li>
                <li class="mypage-menu-item">
                    <a href="#" class="mypage-menu-link">
                        <i class="fas fa-star"></i>
                        <span>리뷰 관리</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- 메인 컨텐츠 영역 -->
    <div class="mypage-content">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title mb-0">회원정보 수정</h3>
            </div>
            <div class="card-body">
                <form action="<c:url value='/user/updateUser'/>" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="form-label">아이디</label>
                        <input type="text" class="form-control-plaintext" name="user_id" value="${userInfo.user_id}" readonly>
                    </div>

                    <div class="form-group">
                        <label class="form-label">이메일</label>
                        <input type="email" class="form-control-plaintext" name="email" value="${userInfo.email}" readonly>
                    </div>

                    <div class="form-group">
                        <label class="form-label">이름</label>
                        <input type="text" class="form-control" name="user_name" value="${userInfo.user_name}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">비밀번호</label>
                        <input type="password" class="form-control" name="password" value="${userInfo.password}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">전화번호</label>
                        <div class="d-flex align-items-center">
                            <select class="form-select mr-2" name="phone1" style="width: 80px;" required>
                                <option value="010" ${userInfo.user_phone.startsWith('010') ? 'selected' : ''}>010</option>
                                <option value="011" ${userInfo.user_phone.startsWith('011') ? 'selected' : ''}>011</option>
                                <option value="016" ${userInfo.user_phone.startsWith('016') ? 'selected' : ''}>016</option>
                                <option value="017" ${userInfo.user_phone.startsWith('017') ? 'selected' : ''}>017</option>
                                <option value="018" ${userInfo.user_phone.startsWith('018') ? 'selected' : ''}>018</option>
                                <option value="019" ${userInfo.user_phone.startsWith('019') ? 'selected' : ''}>019</option>
                            </select>
                            -
                            <c:set var="phone2" value="${userInfo.user_phone.length() >= 7 ? userInfo.user_phone.substring(3, 7) : ''}"/>
                            <input type="text" class="form-control mx-2" name="phone2" value="${phone2}" maxlength="4" 
                                   style="width: 80px;" required>
                            -
                            <c:set var="phone3" value="${userInfo.user_phone.length() >= 11 ? userInfo.user_phone.substring(7) : ''}"/>
                            <input type="text" class="form-control ml-2" name="phone3" value="${phone3}" maxlength="4" 
                                   style="width: 80px;" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">생년월일</label>
                        <input type="date" class="form-control" name="birth" value="${userInfo.birth}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">주소</label>
                        <input type="text" class="form-control" name="user_address" value="${userInfo.user_address}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">프로필 사진</label>
                        <div class="d-flex align-items-center mb-3">
                            <c:choose>
                                <c:when test="${not empty userInfo.image_name}">
                                    <img src="${pageContext.request.contextPath}/upload/userProfile/${userInfo.image_name}" 
                                         alt="Profile Image" class="rounded-circle mr-3" 
                                         style="width: 80px; height: 80px; object-fit: cover;">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/image/noImage.png" 
                                         alt="No Image" class="rounded-circle mr-3" 
                                         style="width: 80px; height: 80px; object-fit: cover;">
                                </c:otherwise>
                            </c:choose>
                            <div>
                                <input type="file" name="image" class="form-control-file" />
                                <small class="text-muted">새 이미지를 선택하지 않으면 기존 이미지가 삭제됩니다</small>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-center mt-4">
                        <button type="submit" class="btn btn-primary mr-2">정보 수정하기</button>
                        <a href="<c:url value='/user/mypage'/>" class="btn btn-outline-gold">취소</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>