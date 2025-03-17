<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="page-header">
    <h1 class="page-title">마이페이지</h1>
    <p class="page-subtitle">나의 계정 정보와 주문 내역을 확인할 수 있습니다.</p>
</div>
    
    <div class="mypage-content">
        <div class="card">
            <div class="card-header">
                <h3 class="card-title mb-0">신용카드 관리</h3>
            </div>
            <div class="card-body">
            <c:choose>
                <c:when test="${not empty cardList}">
                    <div class="card-slider-container">
                        <!-- 왼쪽 화살표 -->
                        <div class="slider-arrow prev-arrow" id="prevCard">
                            <i class="fas fa-chevron-left"></i>
                        </div>
                        
                        <!-- 카드 슬라이더 -->
                        <div class="card-slider">
                            <c:forEach var="card" items="${cardList}" varStatus="status">
                                <div class="payment-card-slide" data-index="${status.index}">
                                    <div class="payment-card card-${card.card_type}">
                                        <div class="card-chip"></div>
                                        <div class="card-info">
                                            <div class="card-label">카드 종류</div>
                                            <h5 class="card-name">${card.card_type}</h5>
                                            
                                            <div class="card-label">카드 번호</div>
                                            <p class="card-number">**** **** **** ${fn:substring(card.card_number, fn:length(card.card_number) - 4, fn:length(card.card_number))}</p>
                                            
                                            <div class="card-details">
                                                <div>
                                                    <div class="card-label">유효기간</div>
                                                    <p class="card-expiry">${card.expiry_date}</p>
                                                </div>
                                                <div>
                                                    <div class="card-label">카드 소유자</div>
                                                    <p class="card-holder">${card.card_holder}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 카드 액션 버튼 -->
                                    <div class="card-actions">
                                        <button type="button" class="btn btn-delete" onclick="confirmDelete('${card.pay_id}')">
                                            <i class="fas fa-trash-alt"></i> 삭제
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- 오른쪽 화살표 -->
                        <div class="slider-arrow next-arrow" id="nextCard">
                            <i class="fas fa-chevron-right"></i>
                        </div>
                    </div>
                    
                    <!-- 카드 인디케이터 -->
                    <div class="card-indicator">
                        <c:forEach var="card" items="${cardList}" varStatus="status">
                            <span class="indicator-dot" data-index="${status.index}"></span>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-card-container">
                        <div class="empty-card-icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        <p class="text-muted">등록된 결제수단이 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>
                <div class="d-flex justify-content-center mt-4">
                    <a href="<c:url value='/user/payRegister'/>" class="btn btn-primary">결제수단 등록하기</a>
                    <a href="<c:url value='/user/paypassword'/>" class="btn btn-primary">결제비밀번호 관리</a>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- JavaScript 스크립트 -->
<script>
    // 페이지 로드 시 실행
    document.addEventListener('DOMContentLoaded', function() {
        // 카드 슬라이더 초기화
        initCardSlider();
    });
    
    // 카드 슬라이더 초기화 함수
    function initCardSlider() {
        const slides = document.querySelectorAll('.payment-card-slide');
        const dots = document.querySelectorAll('.indicator-dot');
        const prevBtn = document.getElementById('prevCard');
        const nextBtn = document.getElementById('nextCard');
        let currentIndex = 0;
        
        // 초기 상태 설정
        if (slides.length > 0) {
            updateSlider();
        }
        
        // 이전 카드 버튼 클릭 이벤트
        if (prevBtn) {
            prevBtn.addEventListener('click', function() {
                currentIndex = (currentIndex - 1 + slides.length) % slides.length;
                updateSlider();
            });
        }
        
        // 다음 카드 버튼 클릭 이벤트
        if (nextBtn) {
            nextBtn.addEventListener('click', function() {
                currentIndex = (currentIndex + 1) % slides.length;
                updateSlider();
            });
        }
        
        // 인디케이터 클릭 이벤트
        dots.forEach(dot => {
            dot.addEventListener('click', function() {
                currentIndex = parseInt(this.getAttribute('data-index'));
                updateSlider();
            });
        });
        
        // 슬라이더 업데이트 함수
        function updateSlider() {
            // 모든 슬라이드 비활성화
            slides.forEach(slide => {
                slide.classList.remove('active');
            });
            
            // 모든 인디케이터 비활성화
            dots.forEach(dot => {
                dot.classList.remove('active');
            });
            
            // 현재 슬라이드와 인디케이터 활성화
            slides[currentIndex].classList.add('active');
            dots[currentIndex].classList.add('active');
        }
    }
    
    // 카드 삭제 확인 함수
    function confirmDelete(payId) {
        if (confirm("정말로 이 카드를 삭제하시겠습니까?")) {
            location.href = "/user/deleteCard?payId=" + payId;
        }
    }
</script>