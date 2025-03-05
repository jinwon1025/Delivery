<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="page-header">
    <h1 class="page-title">즐겨찾기</h1>
    <p class="page-subtitle">내가 자주 찾는 가게를 모아봤어요!</p>
</div>

<!-- 즐겨찾기 목록 -->
<c:choose>
    <c:when test="${not empty bmsList}">
        <div class="store-list">
            <c:forEach items="${bmsList}" var="store">
                <div class="store-item">
                    <div class="store-logo">
                        <c:choose>
                            <c:when test="${not empty store.store_image_name}">
                                <img src="${pageContext.request.contextPath}/upload/storeProfile/${store.store_image_name}" 
                                     alt="${store.store_name}">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/image/noStoreProfile.png" 
                                     alt="기본 이미지">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="store-info" onclick="goToStoreDetail('${store.store_id}')">
                        <div class="store-name">
                            ${store.store_name}
                            <span class="store-type">배달</span>
                        </div>
                        <div class="store-details">
                            <div class="min-order">
                                <span class="min-order-label">최소주문금액:</span> 
                                <span class="min-order-value">${store.last_price}원</span> 이상 배달
                                <c:if test="${store.last_price > 12000}">
                                    <span class="coupon-tag">쿠폰할인</span>
                                </c:if>
                            </div>
                            <div class="delivery-time">
                                ${empty store.delivery_time ? '20-30분' : store.delivery_time}
                            </div>
                        </div>
                    </div>
                    
                    <div class="location">
                        ${empty store.store_address ? '지구' : store.store_address}
                    </div>
                    
                    <!-- 즐겨찾기 버튼 (이미 즐겨찾기된 상태) -->
                    <button class="favorite-btn" onclick="bookmarkStore(event, '${store.store_id}');">
                        <i class="fa-heart fas"></i>
                    </button>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="no-stores">
            <i class="fas fa-heart-broken mb-3" style="font-size: 3rem; color: var(--gray-400);"></i>
            <p>즐겨찾기한 가게가 없습니다.</p>
            <a href="<c:url value='/user/categoryStores'/>" class="btn btn-primary mt-3">가게 찾아보기</a>
        </div>
    </c:otherwise>
</c:choose>

<!-- 유틸리티 버튼 그룹 -->
<c:if test="${not empty bmsList}">
    <div class="d-flex justify-content-center mt-4">
        <a href="<c:url value='/user/categoryStores'/>" class="btn btn-primary">다른 가게 찾기</a>
        <a href="<c:url value='/user/index'/>" class="btn btn-outline-gold ml-2">홈으로</a>
    </div>
</c:if>

<!-- 가게 상세 페이지로 이동하기 위한 숨겨진 폼 -->
<form id="storeDetailForm" action="<c:url value='/userstore/detail'/>">
    <input type="hidden" id="store_id" name="store_id" value="">
</form>

<!-- 즐겨찾기 처리를 위한 숨겨진 폼 -->
<form id="bookmarkForm" action="<c:url value='/user/bookmark'/>" method="post" onsubmit="return false;">
    <input type="hidden" id="bm_store_id" name="bm_store_id" value="">
    <input type="hidden" id="loginStatus" name="loginStatus" value="${sessionScope.loginUser.user_id}">
</form>

<script>
function bookmarkStore(event, storeId) {
    event.stopPropagation(); // 이벤트 버블링 방지
    
    // 즐겨찾기 버튼의 아이콘 상태 변경
    var icon = event.currentTarget.querySelector('i');
    if (icon.classList.contains('fas')) {
        icon.classList.remove('fas');
        icon.classList.add('far');
        
        // 폼의 store_id 값을 설정하고 제출
        document.getElementById('bm_store_id').value = storeId;
        document.getElementById('bookmarkForm').action = "<c:url value='/user/removeBookmark'/>";
        document.getElementById('bookmarkForm').submit();
        
        // 페이지 리로드 (즐겨찾기 목록에서 항목 제거)
        setTimeout(function() {
            location.reload();
        }, 300);
    }
}

function goToStoreDetail(storeId) {
    // 폼의 store_id 값을 설정하고 제출
    document.getElementById('store_id').value = storeId;
    document.getElementById('storeDetailForm').submit();
}
</script>