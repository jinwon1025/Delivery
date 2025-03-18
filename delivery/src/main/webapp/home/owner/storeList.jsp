<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>
    /* 영업 상태 표시 스타일 */
    .store-status {
        display: inline-block;
        padding: 5px 10px;
        color: white;
        font-weight: bold;
        border-radius: 4px;
        font-size: 12px;
        position: absolute;
        top: 10px;
        right: 10px;
        text-shadow: 0 1px 2px rgba(0,0,0,0.2);
        box-shadow: 0 1px 3px rgba(0,0,0,0.2);
        z-index: 5;
    }
    
    .status-open {
        background-color: #4CAF50;
    }
    
    .status-closed {
        background-color: #F44336;
    }
    
    /* 카드 스타일 조정 */
    .store-card-img {
        position: relative;
        overflow: hidden;
        height: 160px;
        border-radius: 8px 8px 0 0;
        background-color: #f5f5f5;
    }
    
    .store-card-img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .store-card {
        transition: transform 0.2s ease, box-shadow 0.2s ease;
        margin-bottom: 20px;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    
    .store-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 16px rgba(0,0,0,0.1);
    }
    
    .store-card-body {
        padding: 15px;
    }
    
    .store-card-footer {
        padding: 10px 15px;
        border-top: 1px solid #eee;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .store-stats {
        display: flex;
    }
    
    .store-stat {
        margin-right: 15px;
        font-size: 14px;
        color: #666;
    }
    
    .store-stat i {
        margin-right: 5px;
        color: #FFD700;
    }
    
    .store-card-list {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
    }
</style>

<div class="page-header">
    <h1 class="page-title">내 가게 관리</h1>
    <p class="page-subtitle">등록한 가게 목록과 상세 정보를 확인하고 관리할 수 있습니다.</p>

    <div class="d-flex justify-content-between align-items-center mt-4">
        <div>
            <a href="<c:url value='/store/goRegister'/>" class="btn btn-primary">
                <i class="fas fa-plus mr-2"></i> 새 가게 등록
            </a>
        </div>

        <div class="d-flex">
            <div class="form-group mb-0 mr-2">
                <select class="form-select" id="statusFilter">
                    <option value="all">모든 가게</option>
                    <option value="1">영업 중</option>
                    <option value="0">영업 종료</option>
                </select>
            </div>
            <div class="form-group mb-0">
                <input type="text" class="form-control" id="storeSearch" placeholder="가게 이름 검색">
            </div>
        </div>
    </div>
</div>

<div class="store-card-list" id="storeCardContainer">
    <c:forEach var="store" items="${storeList}" varStatus="status">
        <c:set var="storeInfo" value="${null}" />
        <c:forEach var="info" items="${storeInfoList}">
            <c:if test="${info.STORE_ID eq store.store_id}">
                <c:set var="storeInfo" value="${info}" />
            </c:if>
        </c:forEach>
        
        <div class="store-card" data-status="${store.store_status}">
            <div class="store-card-img">
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
                
                <!-- 영업 상태 표시 배지 -->
                <div class="store-status ${store.store_status == 1 ? 'status-open' : 'status-closed'}">
                    ${store.store_status == 1 ? '영업 중' : '영업 종료'}
                </div>
            </div>
            
            <div class="store-card-body">
                <h3 class="store-card-title">${store.store_name}</h3>
                <div class="store-card-info">
                    <p><i class="fas fa-won-sign"></i> 최소주문: <fmt:formatNumber value="${store.last_price}" pattern="#,###"/>원</p>
                    <p><i class="fas fa-truck"></i> 배달비: <fmt:formatNumber value="${store.delivery_fee}" pattern="#,###"/>원</p>
                </div>
            </div>
            
            <div class="store-card-footer">
                <div class="store-stats">
                    <div class="store-stat">
                        <i class="fas fa-star"></i> <span>${storeInfo.AVG_RATING == null || storeInfo.AVG_RATING == 0 ? '-' : storeInfo.AVG_RATING}</span>
                    </div>
                    <div class="store-stat">
                        <i class="fas fa-shopping-cart"></i> <span>${storeInfo.ORDER_COUNT == null ? '0' : storeInfo.ORDER_COUNT}건</span>
                    </div>
                </div>

                <div class="store-card-btns">
                    <form action="/store/storeMain" method="get" class="d-inline">
                        <input type="hidden" name="store_id" value="${store.store_id}" />
                        <button type="submit" class="btn btn-sm btn-primary">관리</button>
                    </form>
                    <form action="/store/delete" method="post" class="d-inline"
                        onsubmit="return confirm('${store.store_name} 가게를 정말 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.');">
                        <input type="hidden" name="store_id" value="${store.store_id}" />
                        <button type="submit" class="btn btn-sm btn-outline-gold">삭제</button>
                    </form>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<c:if test="${empty storeList}">
    <div class="text-center py-5">
        <div class="mb-4">
            <i class="fas fa-store-slash" style="font-size: 4rem; color: var(--gray-400);"></i>
        </div>
        <h3 class="mb-3">등록된 가게가 없습니다</h3>
        <p class="text-muted mb-4">아직 등록된 가게가 없습니다. 새로운 가게를 등록해보세요!</p>
        <a href="<c:url value='/store/goRegister'/>" class="btn btn-primary">
            <i class="fas fa-plus mr-2"></i> 가게 등록하기
        </a>
    </div>
</c:if>

<script>
$(document).ready(function() {
    // 상태 필터링
    $('#statusFilter').change(function() {
        filterStores();
    });
    
    // 가게 이름 검색
    $('#storeSearch').on('keyup', function() {
        filterStores();
    });
    
    function filterStores() {
        const status = $('#statusFilter').val();
        const searchText = $('#storeSearch').val().toLowerCase();
        
        $('.store-card').each(function() {
            const storeStatus = $(this).data('status').toString();
            const storeName = $(this).find('.store-card-title').text().toLowerCase();
            
            let showStore = true;
            
            // 상태 필터링
            if (status !== 'all' && storeStatus !== status) {
                showStore = false;
            }
            
            // 이름 검색 필터링
            if (searchText && !storeName.includes(searchText)) {
                showStore = false;
            }
            
            if (showStore) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
        
        // 표시된 가게가 없을 경우 메시지 표시
        if ($('.store-card:visible').length === 0) {
            if ($('#noStoresMessage').length === 0) {
                const noStoresMessage = $('<div id="noStoresMessage" class="text-center py-4 w-100">' +
                    '<p class="text-muted">검색 조건에 맞는 가게가 없습니다.</p>' +
                    '</div>');
                $('#storeCardContainer').after(noStoresMessage);
            }
        } else {
            $('#noStoresMessage').remove();
        }
    }
});
</script>