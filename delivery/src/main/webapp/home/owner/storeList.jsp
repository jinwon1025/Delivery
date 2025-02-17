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

        .store-box {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            padding: 15px;
            margin: 10px auto;
            width: 350px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }

        .store-image {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 10px;
            margin-right: 15px;
        }

        .store-info {
            flex-grow: 1;
        }

        .store-name {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
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
    </style>
</head>
<body>
    <h2>가게 리스트</h2>

    <c:forEach var="store" items="${storeList}">
        <div class="store-box">
            <!-- 가게 프로필 사진 -->
            <c:choose>
                <c:when test="${store.store_image_name != null}">
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
            </div>
        </div>
    </c:forEach>

</body>
</html>
