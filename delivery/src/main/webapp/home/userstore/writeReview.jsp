<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰작성</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 768px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        .header h1 {
            font-size: 22px;
            margin: 0;
        }
        .back-btn {
            color: #666;
            text-decoration: none;
            font-size: 14px;
            border: 1px solid #ddd;
            padding: 8px 12px;
            border-radius: 4px;
        }
        .review-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .store-name {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .rating-container {
            margin-bottom: 30px;
            text-align: center;
        }
        .rating-text {
            font-size: 16px;
            margin-bottom: 10px;
            font-weight: 500;
        }
        .stars {
            font-size: 36px;
            color: #ddd;
            cursor: pointer;
            margin-bottom: 10px;
        }
        .stars .fas {
            color: #ffcc00;
        }
        .rating-value {
            font-size: 18px;
            font-weight: 700;
            color: #333;
        }
        .photo-upload {
            margin-bottom: 30px;
        }
        .photo-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
            border: 1px dashed #ddd;
            height: 100px;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .photo-btn:hover {
            background-color: #e9ecef;
        }
        .photo-btn i {
            font-size: 24px;
            color: #999;
            margin-right: 10px;
        }
        .photo-btn span {
            color: #666;
            font-weight: 500;
        }
        .review-content {
            margin-bottom: 30px;
        }
        .review-content textarea {
            width: 100%;
            height: 150px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            font-size: 16px;
            font-family: 'Noto Sans KR', sans-serif;
            resize: none;
            box-sizing: border-box;
        }
        .review-content textarea:focus {
            outline: none;
            border-color: #3E90FF;
        }
        .submit-btn {
            width: 100%;
            padding: 15px 0;
            background-color: #3E90FF;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .submit-btn:hover {
            background-color: #2e7ad8;
        }
        .submit-btn:disabled {
            background-color: #b3d1ff;
            cursor: not-allowed;
        }
        .photo-preview {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 15px;
        }
        .photo-item {
            width: 100px;
            height: 100px;
            position: relative;
            border-radius: 5px;
            overflow: hidden;
        }
        .photo-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .photo-remove {
            position: absolute;
            top: 5px;
            right: 5px;
            background-color: rgba(0,0,0,0.5);
            color: white;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        #fileInput {
            display: none;
        }
        .error {
            color: #ff3860;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>리뷰 작성</h1>
            <a href="${pageContext.request.contextPath}/userstore/myOrderList" class="back-btn">← 목록으로</a>
        </div>
        
        <form:form id="reviewForm" modelAttribute="review" action="/userstore/submitReview" method="post" enctype="multipart/form-data">
            <form:hidden path="order_id" value="${orderId}"/>
            <form:hidden path="store_id" value="${storeId}"/>
            <form:hidden path="rating" id="ratingValue" value="0"/>
            
            <div class="review-card">
                <div class="store-name">${orderInfo.STORE_NAME}</div>
                
                <div class="rating-container">
                    <div class="rating-text">음식은 어떠셨나요?</div>
                    <div class="stars" id="stars">
                        <i class="far fa-star" data-rating="1"></i>
                        <i class="far fa-star" data-rating="2"></i>
                        <i class="far fa-star" data-rating="3"></i>
                        <i class="far fa-star" data-rating="4"></i>
                        <i class="far fa-star" data-rating="5"></i>
                    </div>
                    <div class="rating-value" id="ratingText">별점을 선택해주세요</div>
                    <form:errors path="rating" cssClass="error"/>
                </div>
                
                <div class="photo-upload">
                    <label for="fileInput" class="photo-btn" id="photoLabel">
                        <i class="fas fa-camera"></i>
                        <span>사진 첨부하기</span>
                    </label>
                    <input type="file" id="fileInput" name="image" >
                    <div class="photo-preview" id="photoPreview"></div>
                </div>
                
                <div class="review-content">
                    <form:textarea path="review_content" id="reviewContent" placeholder="음식의 맛, 양, 포장 상태 등 음식에 대한 솔직한 리뷰를 남겨주세요."/>
                    <form:errors path="review_content" cssClass="error"/>
                </div>
                
                <button type="submit" class="submit-btn" id="submitBtn" disabled>완료</button>
            </div>
        </form:form>
    </div>
    
    <script>
    // 별점 기능
    const stars = document.querySelectorAll('#stars i');
    const ratingValue = document.getElementById('ratingValue');
    const ratingText = document.getElementById('ratingText');
    const ratingTexts = ['매우 별로예요', '별로예요', '보통이에요', '좋아요', '매우 좋아요'];

    stars.forEach(star => {
        star.addEventListener('click', () => {
            const rating = parseInt(star.getAttribute('data-rating'));
            ratingValue.value = rating;
            
            // 별 채우기
            stars.forEach((s, index) => {
                if (index < rating) {
                    s.className = 'fas fa-star';
                } else {
                    s.className = 'far fa-star';
                }
            });
            
            // 텍스트 변경 (템플릿 리터럴 대신 문자열 연결 사용)
            const ratingDescription = ratingTexts[rating-1] || '';
            ratingText.textContent = rating + "점 - " + ratingDescription;
            console.log("별점 선택:", rating, "설명:", ratingDescription);
            
            validateForm();
        });
        
        // 호버 효과
        star.addEventListener('mouseover', () => {
            const rating = parseInt(star.getAttribute('data-rating'));
            stars.forEach((s, index) => {
                if (index < rating) {
                    s.className = 'fas fa-star';
                } else {
                    s.className = 'far fa-star';
                }
            });
        });
        
        star.addEventListener('mouseout', () => {
            const currentRating = parseInt(ratingValue.value);
            stars.forEach((s, index) => {
                if (index < currentRating) {
                    s.className = 'fas fa-star';
                } else {
                    s.className = 'far fa-star';
                }
            });
        });
    });

    // 사진 업로드 미리보기 (1개만 허용)
    const fileInput = document.getElementById('fileInput');
    const photoPreview = document.getElementById('photoPreview');
    const photoLabel = document.getElementById('photoLabel');

    fileInput.addEventListener('change', function() {
        photoPreview.innerHTML = '';
        
        if (this.files && this.files.length > 0) {
            const file = this.files[0];
            const reader = new FileReader();
            
            reader.onload = function(e) {
                const div = document.createElement('div');
                div.className = 'photo-item';
                
                const img = document.createElement('img');
                img.src = e.target.result;
                
                const removeBtn = document.createElement('div');
                removeBtn.className = 'photo-remove';
                removeBtn.innerHTML = '<i class="fas fa-times"></i>';
                removeBtn.addEventListener('click', function() {
                    div.remove();
                    fileInput.value = ''; // 파일 입력 필드 초기화
                    // 사진 첨부 버튼 다시 표시
                    photoLabel.style.display = 'flex';
                });
                
                div.appendChild(img);
                div.appendChild(removeBtn);
                photoPreview.appendChild(div);
                
                // 사진이 첨부되면 사진 첨부 버튼 숨기기
                photoLabel.style.display = 'none';
            }
            
            reader.readAsDataURL(file);
        }
    });

    // 폼 유효성 검사
    const reviewContent = document.getElementById('reviewContent');
    const submitBtn = document.getElementById('submitBtn');

    function validateForm() {
        if (parseInt(ratingValue.value) > 0 && reviewContent.value.trim().length >= 1) {
            submitBtn.disabled = false;
        } else {
            submitBtn.disabled = true;
        }
    }

    reviewContent.addEventListener('input', validateForm);
    </script>
</body>
</html>