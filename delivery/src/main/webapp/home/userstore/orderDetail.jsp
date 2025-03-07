<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 상세 정보</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            max-width: 800px;
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
        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            padding: 20px;
        }
        .status-banner {
            background-color: #4caf50;
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: bold;
            font-size: 18px;
            border-radius: 10px 10px 0 0;
            margin: -20px -20px 15px -20px;
        }
        .store-name {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .menu-item {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }
        .menu-name {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 8px;
        }
        .menu-option {
            margin-left: 20px;
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }
        .menu-price {
            margin-top: 8px;
            text-align: right;
            font-weight: 500;
            color: #333;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
            font-size: 15px;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .info-label {
            color: #777;
        }
        .info-value {
            font-weight: 500;
            text-align: right;
        }
        .section-title {
            font-size: 16px;
            font-weight: bold;
            margin: 15px 0 10px 0;
            color: #333;
        }
        .total-price {
            font-size: 18px;
            font-weight: bold;
            color: #ff6b6b;
        }
        .request-box {
            background-color: #f9f9f9;
            border-radius: 5px;
            padding: 15px;
            margin-top: 10px;
        }
        .request-title {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .request-content {
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>주문 상세</h1>
            <a href="${pageContext.request.contextPath}/userstore/myOrderList" class="back-btn">← 목록으로</a>
        </div>
        
        <!-- 주문 상태 및 기본 정보 카드 -->
        <div class="card">
            <c:choose>
                <c:when test="${orderInfo.ORDER_STATUS == 4}">
                    <div class="status-banner" style="background-color: #4caf50;">배달이 완료되었어요</div>
                </c:when>
                <c:when test="${orderInfo.ORDER_STATUS == 3}">
                    <div class="status-banner" style="background-color: #ff9800;">배달 중이에요</div>
                </c:when>
                <c:when test="${orderInfo.ORDER_STATUS == 2}">
                    <div class="status-banner" style="background-color: #2196f3;">음식을 준비 중이에요</div>
                </c:when>
                <c:when test="${orderInfo.ORDER_STATUS == 1}">
                    <div class="status-banner" style="background-color: #9c27b0;">주문이 접수되었어요</div>
                </c:when>
                <c:otherwise>
                    <div class="status-banner" style="background-color: #795548;">주문 접수 대기 중이에요</div>
                </c:otherwise>
            </c:choose>
            
            <div class="store-name">${orderInfo.STORE_NAME}</div>
            
            <!-- 메뉴 정보 -->
            <c:forEach var="item" items="${orderItems}">
                <div class="menu-item">
                    <div class="menu-name">${item.MENU_NAME} × ${item.QUANTITY}개</div>
                    <c:if test="${not empty item.OPTION_NAMES}">
                        <c:forEach var="option" items="${fn:split(item.OPTION_NAMES, '|')}">
                            <div class="menu-option">- ${option}</div>
                        </c:forEach>
                    </c:if>
                    <div class="menu-price">
                        <c:if test="${item.TOTAL_OPTION_PRICE > 0}">
                            <span>메뉴: <fmt:formatNumber value="${item.MENU_PRICE}" pattern="#,###원" /> + 옵션: <fmt:formatNumber value="${item.TOTAL_OPTION_PRICE}" pattern="#,###원" /></span>
                            <br/>
                        </c:if>
                        <span>합계: <fmt:formatNumber value="${item.ITEM_TOTAL_PRICE}" pattern="#,###원" /></span>
                    </div>
                </div>
            </c:forEach>
            
            <div class="info-row">
                <div class="info-label">주문일시</div>
                <div class="info-value">
                    <fmt:formatDate value="${orderInfo.ORDER_TIME}" pattern="yyyy.MM.dd HH:mm" />
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">주문번호</div>
                <div class="info-value">${orderInfo.ORDER_ID}</div>
            </div>
        </div>
        
        <!-- 결제 정보 카드 -->
        <div class="card">
            <div class="section-title">결제 정보</div>
            
            <div class="info-row">
                <div class="info-label">메뉴 금액</div>
                <div class="info-value">
                    <fmt:formatNumber value="${orderInfo.MENU_PRICE}" pattern="#,###원" />
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">배달 요금</div>
                <div class="info-value">
                    <fmt:formatNumber value="${orderInfo.DELIVERY_FEE}" pattern="#,###원" />
                </div>
            </div>
            <c:if test="${orderInfo.DISCOUNT_AMOUNT > 0}">
                <div class="info-row">
                    <div class="info-label">할인 금액</div>
                    <div class="info-value" style="color: #2196F3;">
                        -<fmt:formatNumber value="${orderInfo.DISCOUNT_AMOUNT}" pattern="#,###원" />
                    </div>
                </div>
            </c:if>
            <div class="info-row">
                <div class="info-label">총 결제 금액</div>
                <div class="info-value total-price">
                    <fmt:formatNumber value="${orderInfo.TOTALPRICE}" pattern="#,###원" />
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">결제 방법</div>
                <div class="info-value">${orderInfo.PAYMENT_METHOD}</div>
            </div>
        </div>
        
        <!-- 배달 정보 카드 -->
        <div class="card">
            <div class="section-title">배달 정보</div>
            
            <div class="info-row">
                <div class="info-label">배달 주소</div>
                <div class="info-value">${orderInfo.DELIVERY_ADDRESS}</div>
            </div>
            <div class="info-row">
                <div class="info-label">전화번호</div>
                <div class="info-value">
                    가게: ${orderInfo.STORE_PHONE} / 고객: ${orderInfo.USER_PHONE}
                </div>
            </div>
            
            <c:if test="${not empty orderInfo.MESSAGE_TO_OWNER}">
                <div class="request-box">
                    <div class="request-title">가게 사장님께</div>
                    <div class="request-content">${orderInfo.MESSAGE_TO_OWNER}</div>
                </div>
            </c:if>
            
            <c:if test="${not empty orderInfo.MESSAGE_TO_RIDER}">
                <div class="request-box">
                    <div class="request-title">라이더님께</div>
                    <div class="request-content">${orderInfo.MESSAGE_TO_RIDER}</div>
                </div>
            </c:if>
        </div>
    </div>
    
    <%-- 디버그 정보 (필요시 주석 해제) --%>
    <%-- 
    <div style="margin-top: 40px; padding: 20px; background-color: #f0f0f0; border-radius: 5px; font-family: monospace; font-size: 12px;">
        <h3>Debug Info - orderInfo:</h3>
        <pre>${orderInfo}</pre>
        <h3>Debug Info - orderItems:</h3>
        <pre>${orderItems}</pre>
    </div>
    --%>
</body>
</html>