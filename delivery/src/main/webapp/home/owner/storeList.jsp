<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

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
                <select class="form-select">
                    <option value="all">모든 가게</option>
                    <option value="open">영업 중</option>
                    <option value="closed">영업 종료</option>
                </select>
            </div>
            <div class="form-group mb-0">
                <input type="text" class="form-control" placeholder="가게 이름 검색">
            </div>
        </div>
    </div>
</div>

<div class="store-card-list">
    <c:forEach var="store" items="${storeList}" varStatus="status">
        <div class="store-card">
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
                <div class="store-status status-open">영업 중</div>
            </div>
            
            <div class="store-card-body">
                <h3 class="store-card-title">
                    ${store.store_name}
                    <span class="store-badge">배달</span>
                </h3>
                
                <div class="store-card-meta">
                    <div class="store-meta-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>${empty store.store_address ? '주소 미등록' : store.store_address}</span>
                    </div>
                    <div class="store-meta-item">
                        <i class="fas fa-phone"></i>
                        <span>${empty store.store_phone ? '연락처 미등록' : store.store_phone}</span>
                    </div>
                    <div class="store-meta-item">
                        <i class="fas fa-clock"></i>
                        <span>${empty store.store_openHour ? '영업시간 미등록' : store.store_openHour}</span>
                    </div>
                    <div class="store-meta-item">
                        <i class="fas fa-won-sign"></i>
                        <span>최소주문: ${store.last_price}원</span>
                    </div>
                    <div class="store-meta-item">
                        <i class="fas fa-truck"></i>
                        <span>배달비: ${store.delivery_fee}원</span>
                    </div>
                </div>
            </div>
            
            <div class="store-card-footer">
                <div class="store-stats">
                    <div class="store-stat">
                        <i class="fas fa-star"></i>
                        <span>4.8</span>
                    </div>
                    <div class="store-stat">
                        <i class="fas fa-shopping-cart"></i>
                        <span>123건</span>
                    </div>
                </div>
                
                <div class="store-card-btns">
                    <form action="/store/storeMain" method="get" class="d-inline">
                        <input type="hidden" name="store_id" value="${store.store_id}"/>
                        <button type="submit" class="btn btn-sm btn-primary">관리</button>
                    </form>
                    <form action="/store/delete" method="post" class="d-inline" 
                          onsubmit="return confirm('${store.store_name} 가게를 정말 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.');">
                        <input type="hidden" name="store_id" value="${store.store_id}"/>
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