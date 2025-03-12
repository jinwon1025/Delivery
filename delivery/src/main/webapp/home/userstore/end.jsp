<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .order-complete-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .success-icon {
            color: #198754;
            font-size: 5rem;
            margin-bottom: 20px;
        }
        .order-info {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .brand-color {
            color: #ff6b6b;
        }
        .delivery-track {
            display: flex;
            justify-content: space-between;
            margin: 30px 0;
            position: relative;
        }
        .delivery-track::before {
            content: "";
            position: absolute;
            height: 4px;
            background-color: #dee2e6;
            top: 15px;
            left: 50px;
            right: 50px;
            z-index: 1;
        }
        .delivery-track::after {
            content: "";
            position: absolute;
            height: 4px;
            background-color: #198754;
            top: 15px;
            left: 50px;
            width: var(--progress, 0%);
            z-index: 1;
        }
        .track-step {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background-color: #fff;
            border: 4px solid #dee2e6;
            z-index: 2;
            position: relative;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .track-step.active {
            border-color: #198754;
            background-color: #198754;
        }
        .track-label {
            font-size: 12px;
            margin-top: 8px;
            text-align: center;
            width: 80px;
            margin-left: -23px;
        }
        .status-text {
            font-weight: bold;
            color: #198754;
            transition: all 0.3s ease;
        }
        .btn-continue {
            background-color: #ff6b6b;
            border: none;
            padding: 10px 20px;
        }
        .btn-continue:hover {
            background-color: #fa5252;
        }
        .status-badge {
            font-size: 16px;
            padding: 8px 15px;
            border-radius: 20px;
            display: inline-block;
            transition: all 0.3s ease;
        }
        .pulse {
            animation: pulse-animation 1s infinite;
        }
        @keyframes pulse-animation {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        #deliveryTimeCounter {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container order-complete-container">
        <div class="text-center mb-4">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h1 class="mb-3">주문이 완료되었습니다!</h1>
            <p class="lead text-muted">고객님의 주문이 성공적으로 접수되었습니다. 맛있는 음식이 곧 배달될 예정입니다.</p>
            <div id="status-badge-container" class="mt-3">
                <span id="status-badge" class="status-badge bg-warning pulse">주문 완료</span>
            </div>
        </div>

        <div class="order-info mb-4">
            <h4 class="brand-color mb-3">주문 정보</h4>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">주문 번호:</div>
                <div class="col-md-8" id="order-id">${orderCart.order_id}</div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">주문 시간:</div>
                <div class="col-md-8">${orderCart.order_time}</div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">배달 주소:</div>
                <div class="col-md-8">${orderCart.user_address}</div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">결제 금액:</div>
                <div class="col-md-8">${orderCart.totalPrice}원</div>
            </div>
        </div>

        <div class="order-info">
            <h4 class="brand-color mb-3">배달 상태</h4>
            <div class="text-center mb-3">
                <span class="status-text" id="status-text">접수 대기 중입니다.</span>
            </div>
            <div class="delivery-track" id="delivery-track">
                <div class="d-flex flex-column align-items-center">
                    <div class="track-step active" data-step="0"></div>
                    <div class="track-label">주문 완료</div>
                </div>
                <div class="d-flex flex-column align-items-center">
                    <div class="track-step" data-step="1"></div>
                    <div class="track-label">접수 완료</div>
                </div>
                <div class="d-flex flex-column align-items-center">
                    <div class="track-step" data-step="2"></div>
                    <div class="track-label">준비 시작</div>
                </div>
                <div class="d-flex flex-column align-items-center">
                    <div class="track-step" data-step="3"></div>
                    <div class="track-label">배달 시작</div>
                </div>
                <div class="d-flex flex-column align-items-center">
                    <div class="track-step" data-step="4"></div>
                    <div class="track-label">배달 완료</div>
                </div>
            </div>
            <p class="text-center text-muted mt-3">
                <span id="delivery-estimate">배달 예상 시간: 약 <span id="deliveryTimeCounter">${orderCart.delivery_time}</span>분</span>
            </p>
        </div>

        <div class="text-center mt-4">
            <a href="/user/index" class="btn btn-continue text-white">쇼핑 계속하기</a>
            <a href="/userstore/orderDetail?orderId=${orderCart.order_id}" class="btn btn-outline-secondary ms-2">주문 내역 보기</a>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    $(document).ready(function() {
        const orderId = $('#order-id').text();
        let currentStatus = 0;
        let pointCanceled = false; // 포인트 차감 여부를 추적하는 플래그
        
        // 주문 완료는 항상 활성화
        $(`.track-step[data-step="0"]`).addClass('active');
        
        // 초기 상태 업데이트
        updateOrderStatus();
        
        // 주기적으로 주문 상태 확인 (1초마다)
        const statusInterval = setInterval(updateOrderStatus, 1000);
        
        // 주문 상태 확인 및 업데이트 함수
        function updateOrderStatus() {
            $.ajax({
                url: '/user/getOrderStatus',
                type: 'GET',
                data: { orderId: orderId },
                success: function(response) {
                    if (response && response.status !== undefined) {
                        const newStatus = parseInt(response.status);
                        
                        // 상태가 변경된 경우에만 UI 업데이트
                        if (newStatus !== currentStatus) {
                            currentStatus = newStatus;
                            updateUI(currentStatus);
                        }
                        
                        // 주문이 취소되거나 배달이 완료된 경우 interval 중지
                        if (newStatus === 4 || newStatus === 5) {
                            clearInterval(statusInterval);
                        }
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching order status:", error);
                }
            });
        }
        
        // UI 업데이트 함수
        function updateUI(status) {
            // 상태 텍스트 업데이트
            const statusTextMap = {
                0: "접수 대기 중입니다.",
                1: "매장에서 주문을 접수했습니다.",
                2: "매장에서 음식을 준비하고 있습니다.",
                3: "배달이 시작되었습니다.",
                4: "배달이 완료되었습니다. 맛있게 드세요!",
                5: "주문이 취소되었습니다."
            };
            
            const statusBadgeMap = {
                0: { text: "주문 완료", class: "bg-warning" },
                1: { text: "접수 완료", class: "bg-info" },
                2: { text: "준비 중", class: "bg-primary" },
                3: { text: "배달 중", class: "bg-secondary" },
                4: { text: "배달 완료", class: "bg-success" },
                5: { text: "주문 취소", class: "bg-danger" }
            };
          
            // 배달 트래커 막대 업데이트
            const progressWidth = status === 5 ? 0 : Math.min(status, 4) * 25;
            
            // CSS 변수 설정 방법 변경 - 더 명확하게
            $('.delivery-track').css('--progress', progressWidth + '%');
            
            // 스텝 표시 업데이트 (주문 완료는 항상 활성화)
            $('.track-step').removeClass('active').css('background-color', '#fff');
            
            // 주문 완료는 항상 활성화
            $(`.track-step[data-step="0"]`).addClass('active').css('background-color', '#198754');
            
            if (status !== 5) { // 취소가 아닌 경우
                for (let i = 1; i <= Math.min(status, 4); i++) {
                    $(`.track-step[data-step="${i}"]`).addClass('active').css('background-color', '#198754');
                }
            }
            
            // 상태 텍스트 업데이트
            $('#status-text').text(statusTextMap[status]);
            
            // 상태 배지 업데이트
            const badgeInfo = statusBadgeMap[status];
            const $statusBadge = $('#status-badge');
            $statusBadge.text(badgeInfo.text);
            $statusBadge.removeClass();
            $statusBadge.addClass('status-badge ' + badgeInfo.class);
            
            // 배달 완료 또는 취소일 때 배지 애니메이션 제거
            if (status === 4 || status === 5) {
                $statusBadge.removeClass('pulse');
            } else {
                $statusBadge.addClass('pulse');
            }
            
            // 예상 배달 시간 업데이트 (정적 표시로 변경)
            let deliveryTimeText = $('#deliveryTimeCounter').text().trim();
            if (!deliveryTimeText || deliveryTimeText === "") {
                deliveryTimeText = "30"; // 기본값
                $('#deliveryTimeCounter').text(deliveryTimeText);
            }
            
            if (status === 3) {
                $('#delivery-estimate').text(`배달 중입니다. 예상 도착 시간: 약 ${deliveryTimeText}분`);
            } else if (status === 4) {
                $('#delivery-estimate').text('배달이 완료되었습니다.');
            } else if (status === 5) {
                $('#delivery-estimate').text('주문이 취소되었습니다.');
            } else {
                $('#delivery-estimate').text(`배달 예상 시간: 약 ${deliveryTimeText}분`);
            }
        }
    });
    </script>
</body>
</html>