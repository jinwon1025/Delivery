<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>가게 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            padding: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .store-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .store-box {
            display: flex;
            align-items: flex-start;
            border: 1px solid #ddd;
            padding: 15px;
            width: calc(50% - 30px); /* 두 개의 박스가 한 줄에 맞도록 너비 조정 */
            background-color: white;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
        }

        .store-image {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 10px;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .store-info {
            flex-grow: 1;
            min-width: 0; /* 텍스트가 너무 길 경우 오버플로우 방지 */
        }

        .store-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .store-details {
            font-size: 14px;
            color: #666;
            margin: 3px 0;
        }

        /* 이모지 스타일 */
        .emoji {
            margin-right: 5px;
        }

        .store-actions {
            margin-top: 15px;
            display: flex;
            gap: 8px;
        }

        .store-actions form {
            flex: 1;
        }

        .store-actions input[type="submit"] {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            border-radius: 5px;
            cursor: pointer;
            border: 1px solid #007bff;
            background-color: white;
            color: #007bff;
            transition: all 0.3s ease;
        }

        .store-actions input[type="submit"]:hover {
            background-color: #f0f0f0;
        }

        .store-actions input[value="가게 삭제"] {
            color: #e74c3c;
            border-color: #e74c3c;
        }

        .store-actions input[value="가게 삭제"]:hover {
            background-color: #f9d6d6;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .store-box {
                width: 100%; /* 모바일에서는 한 줄에 하나만 */
            }
        }
    </style>
</head>
<body>
    <h2>가게 리스트</h2>

    <div class="store-container">
        <c:forEach var="store" items="${storeList}">
            <div class="store-box">
                <!-- 가게 프로필 사진 -->
                <c:choose>
                    <c:when test="${not empty store.store_image_name}">
                        <img src="${pageContext.request.contextPath}/upload/storeProfile/${store.store_image_name}" alt="가게 프로필" class="store-image">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/image/noStoreProfile.png" class="store-image">
                    </c:otherwise>
                </c:choose>

                <!-- 가게 정보 -->
                <div class="store-info">
                    <p class="store-name">${store.store_name} (${store.store_id})</p>
                    <p class="store-details"><span class="emoji">🚚</span>배달 요금: ${store.delivery_fee}원</p>
                    <p class="store-details"><span class="emoji">💰</span>최소 주문 금액: ${store.last_price}원</p>
                    
                    <!-- 가게 관리 및 삭제 버튼을 최소 주문 금액 아래에 배치 -->
                    <div class="store-actions">
                        <form action="/store/storeMain" method="get">
                            <input type="hidden" name="store_id" value="${store.store_id}"/>
                            <input type="submit" value="가게 관리" name="BTN"/>
                        </form>
                        <form action="/store/delete" method="post" onsubmit="return confirm('정말 가게를 삭제하시겠습니까?');">
                            <input type="hidden" name="store_id" value="${store.store_id}"/>
                            <input type="submit" value="가게 삭제" name="BTN"/>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</body>
</html>