<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 수정 - 금베달리스트 사업자</title>
    
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
            <div class="mypage-container">
                <!-- 사이드바 -->
                <div class="mypage-sidebar">
                    <div class="mypage-menu">
                        <div class="mypage-menu-header">
                            <i class="fas fa-user-circle mr-2"></i> 마이페이지
                        </div>
                        <ul class="mypage-menu-list">
                            <li class="mypage-menu-item">
                                <a href="<c:url value='/owner/myPage'/>" class="mypage-menu-link">
                                    <i class="fas fa-home"></i> 대시보드
                                </a>
                            </li>
                            <li class="mypage-menu-item">
                                <a href="<c:url value='/owner/editInfo'/>" class="mypage-menu-link active">
                                    <i class="fas fa-user-edit"></i> 내 정보 수정
                                </a>
                            </li>
                            <li class="mypage-menu-item">
                                <a href="<c:url value='/store/storeList'/>" class="mypage-menu-link">
                                    <i class="fas fa-store"></i> 내 매장 관리
                                </a>
                            </li>
                            <li class="mypage-menu-item">
                                <a href="#" class="mypage-menu-link">
                                    <i class="fas fa-bell"></i> 알림 설정
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <!-- 메인 컨텐츠 -->
                <div class="mypage-content">
                    <div class="section-title mb-4">
                        <h2>내 정보 수정</h2>
                    </div>
                    
                    <div class="edit-profile-form">
                        <form:form modelAttribute="owner" action="/owner/updateInfo" method="post" enctype="multipart/form-data">
                            <!-- 프로필 사진 섹션 -->
                            <div class="form-section">
                                <h3 class="form-section-title">프로필 사진</h3>
                                <div class="upload-area">
                                    <div class="avatar-preview">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.loginOwner.image_name && sessionScope.loginOwner.image_name != 'none'}">
                                                <img src="${pageContext.request.contextPath}/upload/ownerProfile/${sessionScope.loginOwner.image_name}" alt="프로필 이미지" id="preview-image" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/image/noImage.png" alt="기본 이미지" id="preview-image" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="upload-controls">
                                        <p class="mb-2 text-sm text-gray-600">JPG, PNG 형식의 이미지를 업로드하세요.</p>
                                        <input type="file" name="image" id="profile-image" class="form-control" onchange="previewImage(this)" />
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 기본 정보 섹션 -->
                            <div class="form-section">
                                <h3 class="form-section-title">기본 정보</h3>
                                <div class="form-row">
                                    <div class="form-col">
                                        <div class="form-group">
                                            <label class="form-label" for="owner_id">아이디</label>
                                            <form:input path="owner_id" id="owner_id" cssClass="form-control" readonly="true" />
                                        </div>
                                        
                                        <div class="form-group">
                                            <label class="form-label" for="owner_name">사업자명</label>
                                            <form:input path="owner_name" id="owner_name" cssClass="form-control" />
                                            <form:errors path="owner_name" cssClass="text-error" />
                                        </div>
                                    </div>
                                    
                                    <div class="form-col">
                                        <div class="form-group">
                                            <label class="form-label" for="owner_email">이메일</label>
                                            <form:input path="owner_email" id="owner_email" type="email" cssClass="form-control" />
                                            <form:errors path="owner_email" cssClass="text-error" />
                                        </div>
                                        
                                        <div class="form-group">
                                            <label class="form-label" for="owner_phone">전화번호</label>
                                            <form:input path="owner_phone" id="owner_phone" cssClass="form-control" />
                                            <form:errors path="owner_phone" cssClass="text-error" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 비밀번호 섹션 -->
                            <div class="form-section">
                                <h3 class="form-section-title">비밀번호 변경</h3>
                                <div class="form-group">
                                    <label class="form-label" for="owner_password">새 비밀번호</label>
                                    <form:password path="owner_password" id="owner_password" cssClass="form-control" />
                                    <form:errors path="owner_password" cssClass="text-error" />
                                </div>
                            </div>
                            
                            <!-- 버튼 영역 -->
                            <div class="form-actions">
                                <button type="button" class="btn btn-white" onclick="history.back()">취소</button>
                                <button type="submit" class="btn btn-primary">저장하기</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </main>
           

    
    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // 이미지 미리보기
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    document.getElementById('preview-image').src = e.target.result;
                }
                
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>