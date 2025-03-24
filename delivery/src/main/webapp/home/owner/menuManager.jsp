<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메뉴 관리 - 금베달리스트 사업자</title>
    
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
            <div class="section-title mb-4">
                <h2>메뉴 관리</h2>
            </div>
            
            <div class="card mb-4">
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty menuList}">
                            <!-- 등록된 카테고리가 없는 경우 -->
                            <div class="empty-state p-5 text-center">
                                <div class="empty-state-icon mb-4">
                                    <i class="fas fa-list fa-3x text-gray-400"></i>
                                </div>
                                <h3 class="font-medium mb-2">등록된 카테고리가 없습니다</h3>
                                <p class="text-gray-500 mb-4">아래에서 새로운 카테고리를 추가해 주세요.</p>
                                <i class="fas fa-arrow-down fa-2x text-gold animate-bounce"></i>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- 카테고리가 있는 경우 -->
                            <c:forEach items="${menuList}" var="category" varStatus="status">
                                <div class="menu-category ${status.first ? 'active' : ''}">
                                    <div class="menu-category-header d-flex justify-content-between align-items-center p-3 bg-gray-100 rounded">
                                        <h3 class="m-0 font-medium">${category.menu_category_name}</h3>
                                        <div class="d-flex align-items-center">
                                            <form action="/store/categoryUpdate" method="post" class="mr-2" onsubmit="return confirmCategoryUpdate(${category.menu_category_id});">
                                                <input type="hidden" name="menu_category_id" value="${category.menu_category_id}"/>
                                                <input type="hidden" id="menu_category_name_${category.menu_category_id}" name="menu_category_name" value="${category.menu_category_name}"/>
                                                <button type="submit" class="btn btn-sm btn-primary">수정</button>
                                            </form>
                                            <form action="/store/categoryDelete" method="post" class="mr-2" onsubmit="return confirmCategoryDelete();">
                                                <input type="hidden" name="menu_category_id" value="${category.menu_category_id}"/>
                                                <button type="submit" class="btn btn-sm btn-outline-gold">삭제</button>
                                            </form>
                                            <i class="fas fa-chevron-down toggle-icon"></i>
                                        </div>
                                    </div>
                                    
                                    <div class="menu-items p-3">
                                        <!-- 해당 카테고리에 메뉴 아이템이 있는지 확인 -->
                                        <c:set var="hasMenuItems" value="false" />
                                        <c:forEach items="${menuItemList}" var="menuItem">
                                            <c:if test="${menuItem.menu_category_id eq category.menu_category_id}">
                                                <c:set var="hasMenuItems" value="true" />
                                            </c:if>
                                        </c:forEach>
                                        
                                        <c:choose>
                                            <c:when test="${hasMenuItems eq 'false'}">
                                                <!-- 해당 카테고리에 등록된 메뉴가 없는 경우 -->
                                                <div class="empty-menu-state p-4 text-center bg-gray-50 rounded border border-dashed border-gray-300 mb-3">
                                                    <div class="empty-state-icon mb-3">
                                                        <i class="fas fa-utensils fa-2x text-gray-400"></i>
                                                    </div>
                                                    <h4 class="font-medium mb-2">등록된 메뉴가 없습니다</h4>
                                                    <p class="text-gray-500 mb-3">아래 버튼을 클릭하여 새로운 메뉴를 추가해 보세요.</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- 해당 카테고리에 메뉴가 있는 경우 -->
                                                <c:forEach items="${menuItemList}" var="menuItem">
                                                    <c:if test="${menuItem.menu_category_id eq category.menu_category_id}">
                                                        <div class="menu-item mb-3 border rounded p-3 bg-white">
                                                            <div class="d-flex">
                                                                <div class="menu-item-image mr-3">
                                                                    <c:choose>
                                                                        <c:when test="${not empty menuItem.image_name}">
                                                                            <img src="${pageContext.request.contextPath}/upload/menuItemProfile/${menuItem.image_name}" 
                                                                                 alt="${menuItem.menu_name}" class="rounded">
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="bg-gray-200 rounded d-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                                                                <i class="fas fa-image text-gray-500"></i>
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                
                                                                <div class="menu-item-details flex-grow-1">
                                                                    <h4 class="font-medium mb-1">${menuItem.menu_name}</h4>
                                                                    <p class="text-sm text-gray-600 mb-2">${menuItem.content}</p>
                                                                    <p class="text-primary font-medium">${menuItem.price}원</p>
                                                                    
                                                                    <div class="menu-item-actions mt-2">
                                                                        <form action="/store/menuDetail" method="post" class="d-inline-block mr-2">
                                                                            <input type="hidden" name="menu_item_id" value="${menuItem.menu_item_id}"/>
                                                                            <button type="submit" class="btn btn-sm btn-primary">수정</button>
                                                                        </form>
                                                                        <form action="/store/menuDelete" method="post" class="d-inline-block mr-2" onsubmit="return confirmDelete();">
                                                                            <input type="hidden" name="menu_item_id" value="${menuItem.menu_item_id}"/>
                                                                            <button type="submit" class="btn btn-sm btn-outline-gold">삭제</button>
                                                                        </form>
                                                                        <form action="/store/optionManage" method="get" class="d-inline-block">
                                                                            <input type="hidden" name="menu_item_id" value="${menuItem.menu_item_id}"/>
                                                                            <button type="submit" class="btn btn-sm btn-white">옵션 관리</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <!-- 메뉴 추가 버튼 -->
                                        <div class="text-center py-3">
                                            <form action="/store/menuInsert" method="post">
                                                <input type="hidden" name="menu_category_id" value="${category.menu_category_id}"/>
                                                <button type="submit" class="btn btn-outline-gold">
                                                    <i class="fas fa-plus mr-2"></i>메뉴 추가
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <!-- 카테고리 추가 폼 -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">새 카테고리 추가</h3>
                </div>
                <div class="card-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-error mb-3">
                            ${errorMessage}
                        </div>
                    </c:if>
                    
                    <form:form action="/store/categoryRegister" modelAttribute="menuCategory" method="post">
                        <div class="form-group">
                            <label class="form-label" for="menu_category_name">카테고리명:</label>
                            <form:input path="menu_category_name" cssClass="form-control" />
                            <form:errors path="menu_category_name" cssClass="text-error" />
                        </div>
                        <button type="submit" class="btn btn-primary">카테고리 추가</button>
                    </form:form>
                </div>
            </div>
        </div>
    </main>

    
    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // 카테고리 클릭 시 토글 기능
        $(document).ready(function() {
            $('.menu-category-header').click(function(e) {
                // 버튼 클릭시 토글 동작 방지
                if($(e.target).is('button') || $(e.target).closest('button').length || $(e.target).closest('form').length) {
                    return;
                }
                
                var $category = $(this).closest('.menu-category');
                $category.toggleClass('active');
                $(this).find('.toggle-icon').toggleClass('fa-chevron-down fa-chevron-up');
                $category.find('.menu-items').slideToggle(300);
            });
            
            // 첫 번째 카테고리는 기본적으로 열려있도록
            $('.menu-category:first-child .menu-items').show();
            $('.menu-category:first-child .toggle-icon').addClass('fa-chevron-up').removeClass('fa-chevron-down');
            
            // 빈 상태 아이콘 애니메이션
            setInterval(function() {
                $('.animate-bounce').animate({
                    marginTop: '10px'
                }, 1000).animate({
                    marginTop: '0px'
                }, 1000);
            }, 2000);
        });
        
        // 메뉴 삭제 확인
        function confirmDelete() {
            return confirm("정말로 이 메뉴를 삭제하시겠습니까?");
        }
        
        // 카테고리 삭제 확인
        function confirmCategoryDelete() {
            return confirm("이 카테고리와 관련된 모든 메뉴가 삭제됩니다.\n정말로 삭제하시겠습니까?");
        }
        
        // 카테고리 수정
        function confirmCategoryUpdate(categoryId) {
            const newCategoryName = prompt("새 카테고리명을 입력하세요", "");
            
            if(newCategoryName !== null && newCategoryName.trim() !== "") {
                const inputElement = document.getElementById('menu_category_name_' + categoryId);
                inputElement.value = newCategoryName;
                return true;
            } else {
                alert("카테고리명을 입력해주세요.");
                return false;
            }
        }
    </script>
</body>
</html>