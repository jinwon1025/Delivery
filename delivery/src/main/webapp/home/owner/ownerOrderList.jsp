<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>주문 목록 관리</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-4">
    <h2>주문 목록 관리</h2>
    
    <c:if test="${empty orderList}">
        <div class="alert alert-info mt-3">
            현재 주문 내역이 없습니다.
        </div>
    </c:if>
    
    <c:if test="${not empty storeList}">
        <div class="mb-3">
            <label for="storeFilter" class="form-label">매장 선택:</label>
            <select class="form-select" id="storeFilter">
                <option value="all">모든 매장</option>
                <c:forEach var="store" items="${storeList}">
                    <option value="${store.store_id}">${store.store_name}</option>
                </c:forEach>
            </select>
        </div>
    </c:if>
    
    <div class="mb-3">
        <label for="statusFilter" class="form-label">주문 상태:</label>
        <select class="form-select" id="statusFilter">
            <option value="all">모든 상태</option>
            <option value="0">접수 대기</option>
            <option value="1">접수 완료</option>
            <option value="2">준비 중</option>
            <option value="3">배달 중</option>
            <option value="4">배달 완료</option>
            <option value="5">주문 취소</option>
        </select>
    </div>
    
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>주문 번호</th>
                    <th>매장명</th>
                    <th>주문 시간</th>
                    <th>배달 주소</th>
                    <th>총 금액</th>
                    <th>상태</th>
                    <th>주문 상세</th>
                </tr>
            </thead>
            <tbody id="orderTableBody">
                <c:forEach var="order" items="${orderList}">
                    <tr class="order-row" data-store-id="${order.STORE_ID}" data-status="${order.ORDER_STATUS}">
                        <td>${order.ORDER_ID}</td>
                        <td>${order.STORE_NAME}</td>
                        <td><fmt:formatDate value="${order.ORDER_TIME}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>${order.STORE_ADDRESS}</td>
                        <td>
                            <c:choose>
                                <c:when test="${empty order.TOTALPRICE}">금액 정보 없음</c:when>
                                <c:otherwise><fmt:formatNumber value="${order.TOTALPRICE}" pattern="#,###원"/></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${order.ORDER_STATUS == 0}">
                                    <span class="badge bg-warning">접수 대기</span>
                                </c:when>
                                <c:when test="${order.ORDER_STATUS == 1}">
                                    <span class="badge bg-info">접수 완료</span>
                                </c:when>
                                <c:when test="${order.ORDER_STATUS == 2}">
                                    <span class="badge bg-primary">준비 중</span>
                                </c:when>
                                <c:when test="${order.ORDER_STATUS == 3}">
                                    <span class="badge bg-secondary">배달 중</span>
                                </c:when>
                                <c:when test="${order.ORDER_STATUS == 4}">
                                    <span class="badge bg-success">배달 완료</span>
                                </c:when>
                                <c:when test="${order.ORDER_STATUS == 5}">
                                    <span class="badge bg-danger">주문 취소</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-dark">상태 미정</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button class="btn btn-sm btn-primary view-details" 
                                    data-order-id="${order.ORDER_ID}"
                                    data-store-id="${order.STORE_ID}">
                                상세 보기
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- 주문 상세 정보 모달 -->
<div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="orderDetailModalLabel">주문 상세 정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="orderDetailBody">
                <!-- 여기에 주문 상세 정보가 동적으로 로드됩니다 -->
                <div class="text-center">
                    <div class="spinner-border" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="status-buttons">
                    <button type="button" class="btn btn-success update-status" data-status="1">주문 접수</button>
                    <button type="button" class="btn btn-primary update-status" data-status="2">준비 시작</button>
                    <button type="button" class="btn btn-info update-status" data-status="3">배달 시작</button>
                    <button type="button" class="btn btn-secondary update-status" data-status="4">배달 완료</button>
                    <button type="button" class="btn btn-danger update-status" data-status="5">주문 취소</button>
                </div>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // 매장 필터링
    $('#storeFilter').change(function() {
        filterOrders();
    });
    
    // 상태 필터링
    $('#statusFilter').change(function() {
        filterOrders();
    });
    
    // 주문 상세 보기 버튼 클릭 이벤트
    $(document).on('click', '.view-details', function() {
        const orderId = $(this).data('order-id');
        const storeId = $(this).data('store-id');
        
        console.log("Order ID:", orderId); // 디버깅용
        console.log("Store ID:", storeId); // 디버깅용
        
        // 주문 상세 정보를 가져오는 AJAX 호출
        $.ajax({
            url: '/owner/getOrderDetail',
            type: 'GET',
            data: {
                orderId: orderId,
                storeId: storeId
            },
            success: function(response) {
                console.log("Response received:", response); // 디버깅용
                $('#orderDetailBody').html(response);
                $('#orderDetailModal').modal('show');
                
                // 현재 주문 ID를 모달의 상태 변경 버튼에 설정
                $('.update-status').each(function() {
                    $(this).attr('data-order-id', orderId);
                });
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", status, error);
                console.log(xhr.responseText);
                alert('주문 상세 정보를 불러오는 데 실패했습니다.');
            }
        });
    });
    
    // 주문 상태 업데이트 버튼 클릭 이벤트
    $(document).on('click', '.update-status', function() {
        const status = $(this).attr('data-status');
        const orderId = $(this).attr('data-order-id');
        
        console.log("Updating status:", status, "for order:", orderId); // 디버깅용
        
        if (confirm('주문 상태를 변경하시겠습니까?')) {
            $.ajax({
                url: '/owner/updateOrderStatus',
                type: 'POST',
                data: {
                    orderId: orderId,
                    status: status
                },
                success: function(response) {
                    console.log("Status update response:", response); // 디버깅용
                    if (response === 'success') {
                        alert('주문 상태가 변경되었습니다.');
                        location.reload(); // 페이지 새로고침
                    } else {
                        alert('주문 상태 변경에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX Error:", status, error);
                    alert('주문 상태 변경 중 오류가 발생했습니다.');
                }
            });
        }
    });
    
    // 필터링 함수
    function filterOrders() {
        const storeId = $('#storeFilter').val();
        const status = $('#statusFilter').val();
        
        console.log("Filtering - Store:", storeId, "Status:", status); // 디버깅용
        
        $('.order-row').each(function() {
            const rowStoreId = $(this).attr('data-store-id');
            const rowStatus = parseInt($(this).attr('data-status'));
            
            console.log("Row - Store:", rowStoreId, "Status:", rowStatus); // 디버깅용
            
            let showRow = true;
            
            if (storeId !== 'all' && rowStoreId !== storeId) {
                showRow = false;
            }
            
            if (status !== 'all' && rowStatus !== parseInt(status)) {
                showRow = false;
            }
            
            if (showRow) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }
});
</script>
</body>
</html>