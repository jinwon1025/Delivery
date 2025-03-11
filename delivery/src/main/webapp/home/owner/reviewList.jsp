<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
  <h2 class="text-center mb-4">리뷰관리</h2>
  
  <!-- 리뷰 목록 -->
  <div class="review-list">
    <c:forEach var="review" items="${reviewList}">
      <div class="review-item mb-4 pb-4 border-bottom">
        <!-- 가게 정보 및 별점 -->
        <div class="d-flex justify-content-between align-items-center mb-3">
          <div>
            <h5 class="mb-0">${review.store_name} <i class="fas fa-chevron-right"></i></h5>
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
                ${review.write_date}
              </span>
            </div>
          </div>
          <button class="btn btn-sm btn-light rounded-pill delete-btn">삭제</button>
        </div>
        
        <!-- 리뷰 작성자 정보 -->
        <div class="reviewer-info mb-2">
          <span class="reviewer-name">${review.user_name}님</span>
        </div>
        
        <!-- 리뷰 제목 (있는 경우) -->
        <c:if test="${not empty review.review_title}">
          <div class="review-title mb-2">
            <h6>${review.review_title}</h6>
          </div>
        </c:if>
        
        <!-- 리뷰 내용 -->
        <div class="review-content mb-3">
          <p>${review.review_content}</p>
        </div>
        
        <!-- 리뷰 이미지 (있는 경우) -->
        <c:if test="${not empty review.review_image_name}">
          <div class="review-image mb-3">
            <img src="${pageContext.request.contextPath}/upload/reviewProfile/${review.review_image_name}" 
                 class="img-fluid rounded" style="max-height: 200px;" alt="리뷰 이미지">
          </div>
        </c:if>
        
        <!-- 답글 버튼 -->
        <div class="text-right mt-3">
          <button type="button" class="btn btn-warning btn-sm open-reply-btn" 
                  onclick="openReplyModal(
                    '${review.review_id}', 
                    '${review.store_id}', 
                    '${review.owner_id}', 
                    '${review.user_id}', 
                    '${review.group_id}', 
                    '${review.parent_id}', 
                    '${review.order_no}',
                    '${review.order_id}'
                  )">
            답글 등록
          </button>
        </div>
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

<!-- 답글 모달 (페이지 하단에 위치) -->
<div id="replyModalBackground" class="modal-background" style="display: none;">
  <div id="replyModalContainer" class="modal-container">
    <div class="modal-header">
      <h5>리뷰 답글 작성</h5>
      <span class="modal-close" onclick="closeReplyModal()">&times;</span>
    </div>
    <div class="modal-body">
      <div class="owner-info d-flex align-items-center mb-3">
        <div>
          <h6 class="mb-0">사장님</h6>
        </div>
      </div>
      
      <form id="replyForm" action="${pageContext.request.contextPath}/owner/addReviewReply" method="post">
        <input type="hidden" id="modalReviewId" name="reviewId" value="">
        <input type="hidden" id="modalStoreId" name="storeId" value="">
        <input type="hidden" id="modalOwnerId" name="ownerId" value="">
        <input type="hidden" id="modalUserId" name="userId" value="">
        <input type="hidden" id="modalGroupId" name="groupId" value="">
        <input type="hidden" id="modalParentId" name="parentId" value="">
        <input type="hidden" id="modalOrderNo" name="orderNo" value="">
        <input type="hidden" id="modalOrderId" name="orderId" value="">
        
        <div class="form-group">
          <textarea name="replyContent" id="replyContent" class="form-control mb-2" rows="5" placeholder="고객님 안녕하세요!&#13;&#10;소중한 리뷰 감사합니다 ❤&#13;&#10;추운 날씨 속에서도 저희 가게를 선택해주셔서 감사합니다.&#13;&#10;더욱 따뜻하고 맛있게 드실 수 있도록 최선을 다해 준비하며 앞으로도 더 나은 맛과&#13;&#10;서비스를 제공하기 위해 꾸준히 노력하겠습니다.&#13;&#10;소중한 주문에 다시한번 감사드리며, 언제나 건강하고 따뜻한 하루 보내세요!"></textarea>
        </div>
      </form>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-secondary" onclick="closeReplyModal()">취소</button>
      <button type="button" class="btn btn-primary" onclick="submitReply()">등록</button>
    </div>
  </div>
</div>

<!-- JavaScript -->
<script>
function openReplyModal(reviewId, storeId, ownerId, userId, groupId, parentId, orderNo, orderId) {
  // 모달 폼 데이터 설정
  document.getElementById('modalReviewId').value = reviewId;
  document.getElementById('modalStoreId').value = storeId;
  document.getElementById('modalOwnerId').value = ownerId;
  document.getElementById('modalUserId').value = userId;
  document.getElementById('modalGroupId').value = groupId;
  document.getElementById('modalParentId').value = parentId;
  document.getElementById('modalOrderNo').value = orderNo;
  document.getElementById('modalOrderId').value = orderId;
  
  // 모달 표시
  document.getElementById('replyModalBackground').style.display = 'flex';
  document.body.style.overflow = 'hidden'; // 배경 스크롤 방지
}

function closeReplyModal() {
  // 모달 숨김
  document.getElementById('replyModalBackground').style.display = 'none';
  document.body.style.overflow = 'auto'; // 배경 스크롤 복원
  
  // 폼 초기화
  document.getElementById('replyForm').reset();
}

function submitReply() {
  // 폼 제출
  document.getElementById('replyForm').submit();
}

// 리뷰 삭제 버튼 이벤트
document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.delete-btn').forEach(button => {
    button.addEventListener('click', function() {
      if(confirm('이 리뷰를 정말 삭제하시겠습니까?')) {
        // 삭제 로직 구현
      }
    });
  });
});
</script>

<!-- 추가 스타일 -->
<style>
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
.reviewer-name {
  font-weight: bold;
  color: #333;
}

/* 커스텀 모달 스타일 */
.modal-background {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-container {
  background-color: white;
  width: 90%;
  max-width: 500px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px;
  border-bottom: 1px solid #eee;
}

.modal-close {
  font-size: 24px;
  cursor: pointer;
}

.modal-body {
  padding: 15px;
}

.modal-footer {
  padding: 15px;
  text-align: right;
  border-top: 1px solid #eee;
}
</style>