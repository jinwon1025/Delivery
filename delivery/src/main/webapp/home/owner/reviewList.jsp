<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
  <h2 class="text-center mb-4">리뷰관리</h2>
  
  <!-- 탭 메뉴 -->
  <div class="tab-menu mb-4">
    <div class="row">
      <div class="col-6">
        <div class="tab-item active text-center py-3 border-bottom border-dark">배달·포장</div>
      </div>
      <div class="col-6">
        <div class="tab-item text-center py-3 border-bottom">장보기·쇼핑</div>
      </div>
    </div>
  </div>
  
  <!-- 리뷰 목록 -->
  <div class="review-list">
    <c:forEach var="review" items="${reviewList}">
      <div class="review-item mb-4 pb-4 border-bottom">
        <!-- 가게 정보 및 별점 -->
        <div class="d-flex justify-content-between align-items-center mb-3">
          <div>
            <h5 class="mb-0">${review.storeName} <i class="fas fa-chevron-right"></i></h5>
            <!-- 별점 표시 -->
            <div class="stars">
              <c:forEach begin="1" end="5" var="i">
                <c:choose>
                  <c:when test="${i <= review.rating}">
                    <span class="text-warning">★</span>
                  </c:when>
                  <c:otherwise>
                    <span class="text-warning">☆</span>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
              <span class="ml-2 text-muted">
                <fmt:formatDate value="${review.writeDate}" pattern="M개월 전"/> , ${review.orderType}
              </span>
            </div>
          </div>
          <button class="btn btn-sm btn-light rounded-pill delete-btn">삭제</button>
        </div>
        
        <!-- 리뷰 내용 - 비공개 표시 -->
        <c:if test="${review.isPrivate}">
          <div class="mb-3">
            <i class="fas fa-lock mr-2"></i> 사장님에게만 보이는 리뷰에요
          </div>
        </c:if>
        
        <!-- 리뷰 내용 -->
        <div class="review-content mb-3">
          <p>${review.reviewContent}</p>
        </div>
        
        <!-- 리뷰 답변 버튼 -->
        <div class="reply-buttons mb-2">
          <button class="btn btn-outline-primary btn-sm mr-2 reply-toggle-btn" data-review-id="${review.reviewId}">
            <i class="far fa-comment"></i> 모둠까스
          </button>
          <button class="btn btn-outline-primary btn-sm">
            <i class="far fa-comment"></i> 생돈까스
          </button>
        </div>
        
        <!-- 사장님 답변 폼 (기본적으로 숨겨져 있음) -->
        <div class="owner-reply-form mt-3 d-none" id="replyForm-${review.reviewId}">
          <div class="owner-info d-flex align-items-center mb-3">
            <div class="owner-avatar mr-3">
              <img src="${pageContext.request.contextPath}/resources/images/owner-avatar.png" class="rounded-circle" width="40" height="40" alt="사장님">
            </div>
            <div>
              <h6 class="mb-0">사장님 <small class="text-muted"><fmt:formatDate value="${review.writeDate}" pattern="M개월 전"/></small></h6>
            </div>
          </div>
          
          <form action="${pageContext.request.contextPath}/owner/addReviewReply" method="post" class="reply-form">
            <input type="hidden" name="reviewId" value="${review.reviewId}">
            <input type="hidden" name="storeId" value="${review.storeId}">
            
            <div class="form-group">
              <textarea name="replyContent" class="form-control mb-2" rows="5" placeholder="고객님 안녕하세요!&#13;&#10;소중한 리뷰 감사합니다 ❤&#13;&#10;추운 날씨 속에서도 저희 맨부리를 선택해주셔서 감사합니다.&#13;&#10;더욱 따뜻하고 맛있게 드실 수 있도록 최선을 다해 준비하며 앞으로도 더 나은 맛과&#13;&#10;서비스를 제공하기 위해 꾸준히 노력하겠습니다.&#13;&#10;소중한 주문에 다시한번 감사드리며, 언제나 건강하고 따뜻한 것을 보내세요!"></textarea>
            </div>
            
            <div class="text-right">
              <button type="submit" class="btn btn-primary">등록하기</button>
            </div>
          </form>
        </div>
        
        <!-- 이미 등록된 답변이 있는 경우 -->
        <c:if test="${not empty review.replyContent}">
          <div class="owner-reply mt-3 bg-light p-3 rounded">
            <div class="owner-info d-flex align-items-center mb-2">
              <div class="owner-avatar mr-3">
                <img src="${pageContext.request.contextPath}/resources/images/owner-avatar.png" class="rounded-circle" width="40" height="40" alt="사장님">
              </div>
              <div>
                <h6 class="mb-0">사장님 <small class="text-muted"><fmt:formatDate value="${review.replyDate}" pattern="M개월 전"/></small></h6>
              </div>
            </div>
            <p class="mb-0">${review.replyContent}</p>
          </div>
        </c:if>
      </div>
    </c:forEach>
    
    <!-- 리뷰가 없는 경우 -->
    <c:if test="${empty reviewList}">
      <div class="text-center py-5">
        <p class="text-muted">아직 등록된 리뷰가 없습니다.</p>
      </div>
    </c:if>
  </div>
</div>

<!-- JavaScript -->
<script>
$(document).ready(function() {
  // 리뷰 답변 토글 버튼
  $('.reply-toggle-btn').on('click', function() {
    const reviewId = $(this).data('review-id');
    $(`#replyForm-${reviewId}`).toggleClass('d-none');
  });
  
  // 탭 메뉴 전환
  $('.tab-item').on('click', function() {
    $('.tab-item').removeClass('active').removeClass('border-dark');
    $(this).addClass('active').addClass('border-dark');
  });
  
  // 리뷰 삭제 버튼 (확인 모달 표시)
  $('.delete-btn').on('click', function() {
    if(confirm('이 리뷰를 정말 삭제하시겠습니까?')) {
      // 삭제 로직 구현
    }
  });
});
</script>

<!-- 추가 스타일 -->
<style>
.tab-item.active {
  font-weight: bold;
}
.stars {
  font-size: 20px;
}
.review-item {
  position: relative;
}
.owner-reply {
  background-color: #f8f9fa;
  border-radius: 8px;
}
.delete-btn {
  font-size: 0.8rem;
}
</style>