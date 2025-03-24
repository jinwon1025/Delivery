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
                <span id="delivery-estimate">배달 예상 시간: 약 <span id="deliveryTimeCounter">${delivery_time}</span>분</span>
            </div>
            
        <!-- 버튼 영역 -->
        <div class="action-buttons">
            <a href="/user/index" class="btn btn-continue">쇼핑 계속하기</a>
            <a href="/userstore/orderDetail?orderId=${orderCart.order_id}" class="btn btn-outline">주문 내역 보기</a>
        </div>
    </div><!-- 전체 컨테이너 닫기 -->

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
<script>
    $(document).ready(function () {
        console.log("주문 완료 페이지 스크립트 시작");

        const orderId = $('#order-id').text().trim();
        let currentStatus = 0;
        let initialDeliveryTime = $('#deliveryTimeCounter').text().trim() || "30";

        setActiveState(0);
        updateOrderStatus();
        const statusInterval = setInterval(updateOrderStatus, 2000);

        function updateOrderStatus() {
            console.log("주문 상태 확인 요청, 주문 ID:", orderId);

            $.ajax({
                url: '/user/getOrderStatus',
                type: 'GET',
                data: { orderId: orderId },
                dataType: 'json',
                success: function (response) {
                    console.log("응답 데이터:", JSON.stringify(response));

                    if (!response || response.status === undefined) {
                        console.warn("유효하지 않은 응답");
                        return;
                    }

                    const newStatus = parseInt(response.status);
                    const newDeliveryTime = response.deliveryTime ? String(response.deliveryTime) : "30";

                    if (newDeliveryTime !== initialDeliveryTime) {
                        console.log("배달 시간 업데이트:", newDeliveryTime);
                        $('#deliveryTimeCounter').text(newDeliveryTime);
                        initialDeliveryTime = newDeliveryTime;
                    }

                    if (newStatus !== currentStatus) {
                        console.log("상태 변경 감지:", currentStatus, "→", newStatus);
                        currentStatus = newStatus;
                        updateUI(currentStatus);
                    }

                    if (newStatus === 4 || newStatus === 5) {
                        clearInterval(statusInterval);
                    }
                },
                error: function (xhr, status, error) {
                    console.error("주문 상태 조회 오류:", error);
                    console.error("응답 상태:", status, "응답 텍스트:", xhr.responseText);
                }
            });
        }

        function setActiveState(maxStep) {
            for (let i = 0; i <= 4; i++) {
                const step = $('#step' + i);
                step.removeClass('active').css({ backgroundColor: 'white', borderColor: '#dee2e6' }).empty();

                const labelTexts = ['주문 완료', '접수 완료', '준비 시작', '배달 시작', '배달 완료'];
                step.append('<div class="track-label">' + labelTexts[i] + '</div>');
            }

            for (let i = 0; i <= Math.min(maxStep, 4); i++) {
                const step = $('#step' + i);
                step.addClass('active').css({ backgroundColor: '#FFD700', borderColor: '#FFD700' });

                if (step.find('.check-mark').length === 0) {
                    step.prepend('<span class="check-mark">✓</span>');
                }
            }
        }

        function updateUI(status) {
            console.log("UI 업데이트, 상태:", status);

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

            const progressWidth = status === 5 ? 0 : Math.min(status, 4) * 25;
            $('#delivery-track').css('--progress', progressWidth + '%');

            setActiveState(status === 5 ? 0 : status);
            $('#status-text').text(statusTextMap[status]);

            const badgeInfo = statusBadgeMap[status];
            $('#status-badge').text(badgeInfo.text).removeClass().addClass('status-badge ' + badgeInfo.class);

            $('#status-badge').toggleClass('pulse', status !== 4 && status !== 5);

            // 여기 부분이 변경됨
            if (status === 3) {
                $('#delivery-estimate-text').html(`배달 중입니다. 예상 도착 시간: 약 <span id="deliveryTimeCounter">${initialDeliveryTime}</span>분 이내`);
            } else if (status === 4) {
                $('#delivery-estimate-text').text('배달이 완료되었습니다.');
            } else if (status === 5) {
                $('#delivery-estimate-text').text('주문이 취소되었습니다.');
            } else {
                $('#delivery-estimate-text').html(`배달 예상 시간: 약 <span id="deliveryTimeCounter">${initialDeliveryTime}</span>분`);
            }

            console.log("UI 업데이트 완료");
        }
    });
</script>

</body>
</html>