<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 리뷰 관리 페이지 시작 -->
<div class="section-title">
  <h2>리뷰 관리</h2>
</div>

<!-- 리뷰 목록 -->
<div class="card mb-4">
  <div class="card-body">
    <c:choose>
      <c:when test="${empty rarList}">
        <!-- 리뷰가 하나도 없는 경우 -->
        <div class="empty-state">
          <div class="empty-state-icon">
            <i class="fas fa-star fa-3x text-gray-400"></i>
          </div>
          <h3 class="font-medium mb-2">작성된 리뷰가 없습니다</h3>
          <p class="text-gray-500 mb-3">아직 고객이 작성한 리뷰가 없습니다.</p>
        </div>
      </c:when>
      <c:otherwise>
        <!-- 리뷰가 있는 경우 -->
        <c:forEach var="review" items="${rarList}">
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
                    <fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd HH:mm" />
                  </span>
                </div>
              </div>
            </div>
            
            <!-- 리뷰 작성자 정보 -->
            <div class="reviewer-info mb-2">
              <span class="reviewer-name">${review.userName}님</span>
            </div>
            
            <!-- 리뷰 제목 (있는 경우) -->
            <c:if test="${not empty review.reviewTitle}">
              <div class="review-title mb-2">
                <h6>${review.reviewTitle}</h6>
              </div>
            </c:if>
            
            <!-- 리뷰 내용 -->
            <div class="review-content mb-3">
              <p>${review.reviewContent}</p>
            </div>
            
            <!-- 리뷰 이미지 (있는 경우) -->
            <c:if test="${not empty review.reviewImageName}">
              <div class="review-image mb-3">
                <img src="${pageContext.request.contextPath}/upload/reviewProfile/${review.reviewImageName}" 
                     class="img-fluid rounded" style="max-height: 200px;" alt="리뷰 이미지">
              </div>
            </c:if>
            
            <!-- 사업자 답변 (있는 경우) - 말풍선 형태로 변경 -->
            <c:if test="${review.replyId != null}">
              <div class="reply-container">
                <div class="owner-info">
                  <div class="owner-name">${review.ownerName} 사장님</div>
                  <c:if test="${not empty review.ownerImageName}">
                    <img src="${pageContext.request.contextPath}/upload/ownerProfile/${review.ownerImageName}" 
                        alt="사장님 이미지" class="owner-image">
                  </c:if>
                </div>
                <div class="reply-bubble">
                  <div class="reply-content">
                    ${review.replyContent}
                  </div>
                </div>
                <div class="reply-date">
                  <fmt:formatDate value="${review.replyDate}" pattern="yyyy-MM-dd HH:mm" />
                </div>
              </div>
            </c:if>
            
            <!-- 답글 버튼 (답변이 없는 경우에만 표시) -->
            <c:if test="${review.replyId == null}">
              <div class="text-right mt-3">
                <button type="button" class="btn btn-warning btn-sm open-reply-btn" 
                        onclick="openReplyModal(
                          '${review.reviewId}', 
                          '${review.storeId}', 
                          '${review.ownerId}', 
                          '${review.userId}',
                          '${review.orderId}'
                        )">
                  답글 등록
                </button>
              </div>
            </c:if>
          </div>
        </c:forEach>
      </c:otherwise>
    </c:choose>
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
          <c:if test="${not empty owner_image_name}">
            <img src="${pageContext.request.contextPath}/upload/ownerProfile/${owner_image_name}" 
                 class="rounded-circle mr-2" style="width: 30px; height: 30px;" alt="사장님 이미지">
          </c:if>
          <h6 class="mb-0">사장님</h6>
        </div>
      </div>
      
      <form id="replyForm" action="${pageContext.request.contextPath}/owner/addReviewReply" method="post">
        <input type="hidden" id="modalReviewId" name="reviewId" value="">
        <input type="hidden" id="modalStoreId" name="storeId" value="">
        <input type="hidden" id="modalOwnerId" name="ownerId" value="">
        <input type="hidden" id="modalUserId" name="userId" value="">
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
function openReplyModal(reviewId, storeId, ownerId, userId, orderId) {
  // 모달 폼 데이터 설정
  document.getElementById('modalReviewId').value = reviewId;
  document.getElementById('modalStoreId').value = storeId;
  document.getElementById('modalOwnerId').value = ownerId;
  document.getElementById('modalUserId').value = userId;
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
</script>

<!-- 추가 스타일 -->
<style>
/* 별점 스타일 */
.stars {
  font-size: 20px;
  letter-spacing: 2px;
}

.review-item {
  position: relative;
  background-color: #fff;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 3px 10px rgba(0,0,0,0.05);
  margin-bottom: 25px !important;
  border: 1px solid #f0f0f0 !important;
  transition: transform 0.2s, box-shadow 0.2s;
}

.review-item:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 15px rgba(0,0,0,0.1);
}

.reviewer-name {
  font-weight: 600;
  color: #495057;
  background-color: #f8f9fa;
  padding: 3px 10px;
  border-radius: 15px;
  font-size: 0.9rem;
}

.review-content {
  background-color: #f9f9f9;
  padding: 15px;
  border-radius: 8px;
  font-size: 0.95rem;
  line-height: 1.6;
  color: #495057;
}

.review-image img {
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
  transition: transform 0.3s;
}

.review-image img:hover {
  transform: scale(1.02);
}

/* 답변 말풍선 스타일 개선 */
.reply-container {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  margin-top: 20px;
  margin-bottom: 20px;
  background-color: #f8fbff;
  padding: 15px;
  border-radius: 10px;
  position: relative;
}

.reply-container:before {
  content: '사장님 답변';
  position: absolute;
  top: -10px;
  right: 15px;
  background-color: #4a90e2;
  color: white;
  padding: 2px 10px;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 600;
}

.owner-info {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  margin-bottom: 8px;
  width: 100%;
}

.owner-name {
  font-size: 0.95rem;
  color: #4a90e2;
  font-weight: 600;
  margin-right: 10px;
}

.owner-image {
  width: 35px;
  height: 35px;
  border-radius: 50%;
  border: 2px solid white;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.reply-bubble {
  position: relative;
  background-color: #e8f4ff;
  border-radius: 12px;
  padding: 15px;
  width: 90%;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
  margin-left: auto;
  border: 1px solid #d1e6ff;
}

.reply-bubble:after {
  content: '';
  position: absolute;
  top: 15px;
  right: -12px;
  border-width: 10px 0 10px 12px;
  border-style: solid;
  border-color: transparent transparent transparent #e8f4ff;
}

.reply-content {
  line-height: 1.7;
  color: #333;
  word-break: break-word;
  font-size: 0.95rem;
}

.reply-date {
  color: #888;
  font-size: 0.8rem;
  text-align: right;
  margin-top: 5px;
  width: 90%;
}

/* 답글 등록 버튼 스타일 개선 */
.open-reply-btn {
  background-color: #ffc107;
  border: none;
  color: #212529;
  padding: 5px 15px;
  font-weight: 600;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
  transition: all 0.3s;
}

.open-reply-btn:hover {
  background-color: #e0a800;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}

/* 커스텀 모달 스타일 개선 */
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
  backdrop-filter: blur(3px);
}

.modal-container {
  background-color: white;
  width: 90%;
  max-width: 550px;
  border-radius: 12px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
  overflow: hidden;
  animation: modalFadeIn 0.3s ease;
}

@keyframes modalFadeIn {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 18px 20px;
  background-color: #f8f9fa;
  border-bottom: 1px solid #e9ecef;
}

.modal-header h5 {
  font-weight: 700;
  color: #343a40;
  margin: 0;
}

.modal-close {
  font-size: 28px;
  cursor: pointer;
  color: #adb5bd;
  transition: color 0.2s;
}

.modal-close:hover {
  color: #495057;
}

.modal-body {
  padding: 20px;
}

.modal-footer {
  padding: 15px 20px;
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  border-top: 1px solid #e9ecef;
}

.modal-footer .btn {
  border-radius: 5px;
  padding: 8px 20px;
  font-weight: 600;
  transition: all 0.3s;
}

.modal-footer .btn-secondary {
  background-color: #e9ecef;
  color: #495057;
  border: none;
}

.modal-footer .btn-secondary:hover {
  background-color: #dee2e6;
}

.modal-footer .btn-primary {
  background-color: #4a90e2;
  border: none;
}

.modal-footer .btn-primary:hover {
  background-color: #3a80d2;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

textarea.form-control {
  border: 1px solid #ced4da;
  border-radius: 8px;
  font-size: 0.95rem;
  padding: 12px;
  transition: border-color 0.2s;
  resize: vertical;
  min-height: 150px;
  box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
}

textarea.form-control:focus {
  border-color: #4a90e2;
  box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.1);
  outline: none;
}

/* 빈 상태 스타일 */
.empty-state {
  text-align: center;
  padding: 3rem 1rem;
  border: 1px dashed #ddd;
  border-radius: 0.5rem;
  background-color: #f9f9f9;
  margin: 2rem 0;
}

.empty-state-icon {
  margin-bottom: 1.5rem;
  color: #aaa;
}

.empty-state h3 {
  font-weight: 600;
  color: #343a40;
  margin-bottom: 0.5rem;
}

.empty-state p {
  color: #6c757d;
}
</style>
<!-- 리뷰 관리 페이지 끝 -->