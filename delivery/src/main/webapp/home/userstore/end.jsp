<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료 | 금베달리스트</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        :root {
            --primary-color: #FFD700;
            --primary-dark: #DBA901;
            --gold-gradient: linear-gradient(135deg, #FFD700, #DBA901);
            --gold-gradient-hover: linear-gradient(135deg, #F1C40F, #B7950B);
            --gray-100: #f8f9fa;
            --gray-200: #e9ecef;
            --gray-300: #dee2e6;
            --gray-600: #6c757d;
            --gray-700: #495057;
            --gray-800: #343a40;
            --border-radius: 10px;
            --font-weight-medium: 500;
            --font-weight-bold: 700;
            --transition-normal: 0.3s;
        }
        
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            color: #343a40;
        }
        
        .order-complete-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0;
        }
        
        .card {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        
        .success-card {
            padding: 40px 20px;
            text-align: center;
            background: white;
            margin-bottom: 30px;
        }
        
        .success-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: var(--gold-gradient);
            color: white;
            font-size: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 5px 15px rgba(219, 169, 1, 0.3);
        }
        
        .order-info-card {
            padding: 30px;
            background: white;
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 1.25rem;
            font-weight: var(--font-weight-bold);
            color: var(--gray-800);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--primary-color);
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            padding-bottom: 12px;
            border-bottom: 1px solid var(--gray-200);
        }
        
        .info-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .info-label {
            color: var(--gray-600);
            font-weight: var(--font-weight-medium);
        }
        
        .info-value {
            font-weight: var(--font-weight-bold);
            color: var(--gray-800);
        }
        
        .delivery-status-card {
            padding: 30px;
            background: white;
            margin-bottom: 30px;
        }
        
        .status-badge {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 30px;
            font-size: 16px;
            font-weight: var(--font-weight-medium);
            margin-bottom: 25px;
            transition: all 0.5s ease;
        }
        
        .bg-warning {
            background-color: #FFD700 !important;
            color: #212529;
        }
        
        .bg-info {
            background-color: #17a2b8 !important;
            color: white;
        }
        
        .bg-primary {
            background-color: #007bff !important;
            color: white;
        }
        
        .bg-secondary {
            background-color: #6c757d !important;
            color: white;
        }
        
        .bg-success {
            background-color: #28a745 !important;
            color: white;
        }
        
        .bg-danger {
            background-color: #dc3545 !important;
            color: white;
        }
        
        .status-text {
            font-size: 18px;
            font-weight: var(--font-weight-medium);
            margin-bottom: 20px;
            color: var(--gray-800);
        }
        
        .delivery-track {
            display: flex;
            justify-content: space-between;
            margin: 40px 0;
            position: relative;
        }
        
        .delivery-track::before {
            content: "";
            position: absolute;
            height: 4px;
            background-color: var(--gray-300);
            top: 15px;
            left: 0;
            right: 0;
            z-index: 1;
        }
        
        .delivery-track::after {
            content: "";
            position: absolute;
            height: 4px;
            background: var(--gold-gradient);
            top: 15px;
            left: 0;
            width: var(--progress, 0%);
            z-index: 1;
            transition: width 0.8s ease;
        }
        
        .track-step {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background-color: white;
            border: 4px solid var(--gray-300);
            z-index: 2;
            position: relative;
            transition: all 0.5s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .track-step.active {
            border-color: var(--primary-color);
            background-color: var(--primary-color) !important; /* !important 추가 */
            color: white;
            box-shadow: 0 0 0 4px rgba(255, 215, 0, 0.2);
        }
        
        /* CSS의 ::after 체크 표시 제거 - 중요! */
        .track-step.active:after {
            content: none;
        }
        
        .check-mark {
            color: white;
            font-size: 16px;
            font-weight: bold;
            line-height: 1;
        }
        
        .track-label {
            position: absolute;
            top: 40px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 14px;
            font-weight: var(--font-weight-medium);
            color: var(--gray-600);
            width: 80px;
            text-align: center;
        }
        
        .track-step.active .track-label {
            color: var(--gray-800);
            font-weight: var(--font-weight-bold);
        }
        
        .delivery-info {
            text-align: center;
            margin-top: 20px;
            padding: 15px;
            background-color: var(--gray-100);
            border-radius: var(--border-radius);
            font-weight: var(--font-weight-medium);
        }
        
        .pulse {
            animation: pulse-animation 1.5s infinite;
        }
        
        @keyframes pulse-animation {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1); }
            100% { transform: scale(1); }
        }
        
        .btn-continue {
            background: var(--gold-gradient);
            color: white;
            font-weight: var(--font-weight-medium);
            border: none;
            padding: 12px 25px;
            border-radius: 30px;
            box-shadow: 0 4px 10px rgba(219, 169, 1, 0.2);
            transition: all var(--transition-normal) ease;
        }
        
        .btn-continue:hover {
            background: var(--gold-gradient-hover);
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(219, 169, 1, 0.3);
            color: white;
        }
        
        .btn-outline {
            color: var(--gray-700);
            background-color: white;
            border: 1px solid var(--gray-300);
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: var(--font-weight-medium);
            transition: all var(--transition-normal) ease;
        }
        
        .btn-outline:hover {
            background-color: var(--gray-100);
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.05);
        }
        
        .action-buttons {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        @media (max-width: 768px) {
            .delivery-track {
                margin: 50px 0 70px;
            }
            
            .track-label {
                top: 45px;
                font-size: 12px;
                width: 70px;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 10px;
            }
            
            .btn-continue, .btn-outline {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container order-complete-container">
        <!-- 성공 메시지 카드 -->
        <div class="card success-card">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            <h1 class="mb-3 fw-bold">주문이 완료되었습니다!</h1>
            <p class="lead text-muted">고객님의 주문이 성공적으로 접수되었습니다. 맛있는 음식이 곧 배달될 예정입니다.</p>
            <div id="status-badge-container" class="mt-3">
                <span id="status-badge" class="status-badge bg-warning pulse">주문 완료</span>
            </div>
        </div>

        <!-- 주문 정보 카드 -->
        <div class="card order-info-card">
            <h4 class="section-title">주문 정보</h4>
            <div class="info-row">
                <div class="info-label">주문 번호</div>
                <div class="info-value" id="order-id">${orderCart.order_id}</div>
            </div>
            <div class="info-row">
                <div class="info-label">주문 시간</div>
                <div class="info-value">${orderCart.order_time}</div>
            </div>
            <div class="info-row">
                <div class="info-label">배달 주소</div>
                <div class="info-value">${orderCart.user_address}</div>
            </div>
            <div class="info-row">
                <div class="info-label">결제 금액</div>
                <div class="info-value">${orderCart.totalPrice}원</div>
            </div>
        </div>

        <!-- 배달 상태 카드 -->
        <div class="card delivery-status-card">
            <h4 class="section-title">배달 상태</h4>
            <div class="text-center">
                <div class="status-text" id="status-text">접수 대기 중입니다.</div>
            </div>
            <div class="delivery-track" id="delivery-track">
                <div class="track-step" data-step="0" id="step0">
                    <div class="track-label">주문 완료</div>
                </div>
                <div class="track-step" data-step="1" id="step1">
                    <div class="track-label">접수 완료</div>
                </div>
                <div class="track-step" data-step="2" id="step2">
                    <div class="track-label">준비 시작</div>
                </div>
                <div class="track-step" data-step="3" id="step3">
                    <div class="track-label">배달 시작</div>
                </div>
                <div class="track-step" data-step="4" id="step4">
                    <div class="track-label">배달 완료</div>
                </div>
            </div>
            <div class="delivery-info">
                <span id="delivery-estimate">배달 예상 시간: 약 <span id="deliveryTimeCounter">${orderCart.estimated_delivery_time}</span>분</span>
            </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="action-buttons">
            <a href="/user/index" class="btn btn-continue">쇼핑 계속하기</a>
            <a href="/userstore/orderDetail?orderId=${orderCart.order_id}" class="btn btn-outline">주문 내역 보기</a>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    $(document).ready(function() {
        const orderId = $('#order-id').text().trim();
        let currentStatus = 0;
        
        // 초기 배달 시간 값 확인 및 출력
        let initialTime = $('#deliveryTimeCounter').text().trim();
        console.log("초기 배달 시간 값:", initialTime);
        
        // 초기값이 없거나 "null"인 경우 기본값 설정
        if (!initialTime || initialTime === "" || initialTime === "null") {
            console.log("초기 배달 시간이 없어서 기본값 설정");
            $('#deliveryTimeCounter').text("30");
        }
        // 초기 상태를 확실히 설정
        setActiveState(0);
        
        // 초기 상태 업데이트
        updateOrderStatus();
        
        // 주기적으로 주문 상태 확인 (2초마다)
        const statusInterval = setInterval(updateOrderStatus, 2000);
        
        // 주문 상태 확인 및 업데이트 함수
        function updateOrderStatus() {
    console.log("Checking order status for ID:", orderId);
    
    $.ajax({
        url: '/user/getOrderStatus',
        type: 'GET',
        data: { orderId: orderId },
        success: function(response) {
            console.log("전체 응답 데이터:", JSON.stringify(response));
            
            if (response && response.status !== undefined) {
                const newStatus = parseInt(response.status);
                console.log("상태:", newStatus, "현재 상태:", currentStatus);
                
                // 배달 시간 정보가 있으면 업데이트
                if (response.deliveryTime !== undefined) {
                    console.log("배달 시간 데이터 타입:", typeof response.deliveryTime);
                    console.log("배달 시간 값:", response.deliveryTime);
                    
                    if (response.deliveryTime && response.deliveryTime > 0) {
                        console.log("배달 시간을 업데이트합니다:", response.deliveryTime);
                        $('#deliveryTimeCounter').text(response.deliveryTime);
                        console.log("업데이트 후 요소 텍스트:", $('#deliveryTimeCounter').text());
                    } else {
                        console.log("배달 시간이 없거나 0 이하입니다:", response.deliveryTime);
                    }
                } else {
                    console.log("응답에 배달 시간 정보가 없습니다.");
                }
                
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
            console.error("Response:", xhr.responseText);
        }
    });
}
        
        // 스텝을 활성화하는 함수
        function setActiveState(maxStep) {
            // 모든 스텝 초기화
            for (let i = 0; i <= 4; i++) {
                const step = document.getElementById('step' + i);
                step.style.backgroundColor = 'white';
                step.style.borderColor = '#dee2e6';
                $(step).removeClass('active');
                $(step).empty(); // 체크표시 제거
                
                // 라벨 다시 추가
                const label = document.createElement('div');
                label.className = 'track-label';
                
                // 각 단계별 라벨 텍스트 설정
                const labelTexts = ['주문 완료', '접수 완료', '준비 시작', '배달 시작', '배달 완료'];
                label.textContent = labelTexts[i];
                
                step.appendChild(label);
            }
            
            // 활성화된 스텝 설정 (0부터 maxStep까지)
            for (let i = 0; i <= Math.min(maxStep, 4); i++) {
                const step = document.getElementById('step' + i);
                step.style.backgroundColor = '#FFD700';
                step.style.borderColor = '#FFD700';
                $(step).addClass('active');
                
                // 체크 표시 추가 (하나만 추가되도록)
                if ($(step).find('.check-mark').length === 0) {
                    const checkMark = document.createElement('span');
                    checkMark.className = 'check-mark';
                    checkMark.textContent = '✓';
                    
                    // 라벨 요소를 먼저 찾고 그 앞에 체크마크 추가
                    const label = $(step).find('.track-label')[0];
                    step.insertBefore(checkMark, label);
                }
            }
        }
        
        // UI 업데이트 함수
        function updateUI(status) {
            console.log("Updating UI for status:", status);
            
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
            console.log("Setting progress width to:", progressWidth + '%');
            
            // CSS 변수 설정
            $('#delivery-track').css('--progress', progressWidth + '%');
            
            // 스텝 표시 업데이트 - 직접 적용
            if (status === 5) {
                // 취소인 경우 첫 번째 단계만 활성화
                setActiveState(0);
            } else {
                // 취소가 아닌 경우 해당 단계까지 활성화
                setActiveState(status);
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
            
            // 예상 배달 시간 업데이트
            let deliveryTimeText = $('#deliveryTimeCounter').text().trim();
            if (!deliveryTimeText || deliveryTimeText === "") {
                deliveryTimeText = "30"; // 기본값
                $('#deliveryTimeCounter').text(deliveryTimeText);
            }
            
            if (status === 3) {
                $('#delivery-estimate').text(`배달 중입니다. 예상 도착 시간: 약 ${deliveryTimeText}분 이내`);
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