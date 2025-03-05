<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메뉴 등록 - 금베달리스트 사업자</title>
    
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
            <div class="add-menu-form">
                <h2 class="form-title">메뉴 등록</h2>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error mb-4">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <form:form action="/store/menuRegister" method="post" modelAttribute="menuItem" enctype="multipart/form-data">
                    <div class="form-row">
                        <div class="form-col">
                            <div class="form-group">
                                <label class="form-label" for="menu_name">메뉴명</label>
                                <form:input path="menu_name" id="menu_name" cssClass="form-control" />
                                <form:errors path="menu_name" cssClass="text-error" />
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label" for="price">가격</label>
                                <form:input path="price" id="price" type="number" cssClass="form-control" />
                                <form:errors path="price" cssClass="text-error" />
                            </div>
                        </div>
                        
                        <div class="form-col">
                            <div class="form-group">
                                <label class="form-label" for="content">메뉴 설명</label>
                                <form:textarea path="content" id="content" cssClass="form-control" rows="4" />
                                <form:errors path="content" cssClass="text-error" />
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="image">메뉴 이미지</label>
                        <input type="file" id="image" name="image" class="form-control" 
                               onchange="previewImage(this);" accept="image/*" />
                    </div>
                    
                    <div class="menu-preview mb-4">
                        <div class="preview-img" id="image-preview">
                            <i class="fas fa-image"></i>
                        </div>
                        <div class="preview-info">
                            <h3 class="preview-name" id="preview-name">메뉴명</h3>
                            <p class="preview-price" id="preview-price">0원</p>
                            <p class="preview-desc" id="preview-desc">메뉴 설명</p>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn-white" onclick="history.back()">취소</button>
                        <button type="submit" class="btn btn-primary">등록하기</button>
                    </div>
                </form:form>
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
                    var preview = document.getElementById('image-preview');
                    preview.innerHTML = '<img src="' + e.target.result + '" alt="Preview" />';
                }
                
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        // 실시간 메뉴 정보 미리보기 업데이트
        $(document).ready(function() {
            $('#menu_name').on('input', function() {
                $('#preview-name').text($(this).val() || '메뉴명');
            });
            
            $('#price').on('input', function() {
                $('#preview-price').text(($(this).val() || '0') + '원');
            });
            
            $('#content').on('input', function() {
                $('#preview-desc').text($(this).val() || '메뉴 설명');
            });
        });
    </script>
</body>
</html>