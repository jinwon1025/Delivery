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
        .track-step {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background-color: #fff;
            border: 4px solid #dee2e6;
            z-index: 2;
            position: relative;
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
        .btn-continue {
            background-color: #ff6b6b;
            border: none;
            padding: 10px 20px;
        }
        .btn-continue:hover {
            background-color: #fa5252;
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
        </div>

        <div class="order-info mb-4">
            <h4 class="brand-color mb-3">주문 정보</h4>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">주문 번호:</div>
                <div class="col-md-8">${orderCart.order_id}</div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">주문 시간:</div>
                <div class="col-md-8">${orderDate}</div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">배달 주소:</div>
                <div class="col-md-8">${userAddress}</div>
            </div>
            <div class="row mb-2">
                <div class="col-md-4 fw-bold">결제 금액:</div>
                <div class="col-md-8">${totalPrice}원</div>
            </div>
        </div>

        <div class="order-info">
            <h4 class="brand-color mb-3">배달 상태</h4>
            <div class="delivery-track">
                <div class="d-flex flex-column align-items-center">
                    <div class="track-step active"></div>
                    <div class="track-label">주문 완료</div>
                </div>
                <div class="d-flex flex-column align-items-center">
                    <div class="track-step"></div>
                    <div class="track-label">가게 접수</div>
                </div>
                <div class="d-flex flex-column align-items-center">
                    <div class="track-step"></div>
                    <div class="track-label">조리 중</div>
                </div>
                <div class="d-flex flex-column align-items-center">
                    <div class="track-step"></div>
                    <div class="track-label">배달 중</div>
                </div>
                <div class="d-flex flex-column align-items-center">
                    <div class="track-step"></div>
                    <div class="track-label">배달 완료</div>
                </div>
            </div>
            <p class="text-center text-muted mt-2">배달 예상 시간: 약 35-45분</p>
        </div>

        <div class="text-center mt-4">
            <a href="/user/main" class="btn btn-continue text-white">쇼핑 계속하기</a>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>