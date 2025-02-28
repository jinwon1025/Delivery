<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<!-- 가게 목록 -->
<c:choose>
    <c:when test="${not empty storeList}">
        <div class="store-list">
            <c:forEach items="${storeList}" var="store">
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
                    
                    <!-- 즐겨찾기 버튼 -->
                    <button class="favorite-btn" onclick="bookmarkStore(event, '${store.store_id}');">
                        <c:choose>
                            <c:when test="${bmsList.contains(store.store_id)}">
                                <!-- 즐겨찾기된 가게 -->
                                <i class="fa-heart fas"></i>
                            </c:when>
                            <c:otherwise>
                                
                                <i class="fa-heart far"></i>
                            </c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <div class="no-stores">
            <i class="fas fa-store-slash mb-3" style="font-size: 3rem; color: var(--gray-400);"></i>
            <p>해당 카테고리에 등록된 가게가 없습니다.</p>
        </div>
    </c:otherwise>
</c:choose>

<!-- 페이지네이션 (필요시 추가) -->
<c:if test="${not empty paging}">
    <div class="d-flex justify-content-center mt-4">
        <ul class="pagination">
            <!-- 페이징 코드 -->
        </ul>
    </div>
</c:if>

<!-- 유틸리티 버튼 그룹 -->
<div class="btn-group mt-4">
    <a href="<c:url value='/user/categoryStores'/>" class="btn btn-primary">전체보기</a>
    <a href="<c:url value='/user/index'/>" class="btn btn-outline-gold">홈으로</a>
</div>

<!-- 가게 상세 페이지로 이동하기 위한 숨겨진 폼 -->
<form id="storeDetailForm" action="<c:url value='/userstore/detail'/>">
    <input type="hidden" id="store_id" name="store_id" value="">
</form>

<!-- 즐겨찾기 처리를 위한 숨겨진 폼 -->
<form id="bookmarkForm" action="<c:url value='/user/bookmark'/>" method="post" onsubmit="return bookmarkStore(event)">
    <input type="hidden" id="bm_store_id" name="bm_store_id" value="">
    <input type="hidden" id="loginStatus" name="loginStatus" value="${sessionScope.loginUser.user_id}">
</form>

<script>
function bookmarkStore(event, storeId) {
    event.stopPropagation(); // 이벤트 버블링 방지

    // 숨겨진 input에서 로그인 상태 값 가져오기
    var loginStatusInput = document.getElementById('loginStatus');
    var loginUser = loginStatusInput.value.trim(); // 값 가져와서 앞뒤 공백 제거

    // 로그인 여부 확인
    if (loginUser === null || loginUser === "") {
        loginStatusInput.value = "no";
        alert("즐겨찾기를 하려면 로그인해야 합니다.");
        return false;
    } else {
        loginStatusInput.value = "yes";
    }

    // 버튼의 아이콘을 토글하기 위해 현재 클릭된 버튼의 아이콘을 찾음
    var icon = event.currentTarget.querySelector('i');
    if (icon.classList.contains('far')) {
        icon.classList.remove('far');
        icon.classList.add('fas');
    } else {
        icon.classList.remove('fas');
        icon.classList.add('far');
    }

    // 폼의 store_id 값을 설정하고 제출
    document.getElementById('bm_store_id').value = storeId;
    document.getElementById('bookmarkForm').submit();
    
    return false;
}

function goToStoreDetail(storeId) {
    // 폼의 store_id 값을 설정하고 제출
    document.getElementById('store_id').value = storeId;
    document.getElementById('storeDetailForm').submit();
}
</script>