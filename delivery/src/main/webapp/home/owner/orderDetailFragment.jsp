<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <div class="row mb-4">
        <div class="col-md-6">
            <h5>주문 정보</h5>
            <table class="table table-bordered">
                <tr>
                    <th>주문 번호</th>
                    <td>${orderInfo.ORDER_ID}</td>
                </tr>
                <tr>
                    <th>주문 시간</th>
                    <td><fmt:formatDate value="${orderInfo.ORDER_TIME}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
                <tr>
                    <th>주문 상태</th>
                    <td>
                        <c:choose>
                            <c:when test="${orderInfo.ORDER_STATUS == 0}">
                                <span class="badge bg-warning">접수 대기</span>
                            </c:when>
                            <c:when test="${orderInfo.ORDER_STATUS == 1}">
                                <span class="badge bg-info">접수 완료</span>
                            </c:when>
                            <c:when test="${orderInfo.ORDER_STATUS == 2}">
                                <span class="badge bg-primary">준비 중</span>
                            </c:when>
                            <c:when test="${orderInfo.ORDER_STATUS == 3}">
                                <span class="badge bg-secondary">배달 중</span>
                            </c:when>
                            <c:when test="${orderInfo.ORDER_STATUS == 4}">
                                <span class="badge bg-success">배달 완료</span>
                            </c:when>
                            <c:when test="${orderInfo.ORDER_STATUS == 5}">
                                <span class="badge bg-danger">주문 취소</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-dark">상태 미정</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>총 금액</th>
                    <td><fmt:formatNumber value="${orderInfo.TOTALPRICE}" pattern="#,###원"/></td>
                </tr>
            </table>
        </div>
        <div class="col-md-6">
            <h5>고객 정보</h5>
            <table class="table table-bordered">
                <tr>
                    <th>고객 ID</th>
                    <td>${orderInfo.USER_ID}</td>
                </tr>
                <tr>
                    <th>고객명</th>
                    <td>${orderInfo.USER_NAME}</td>
                </tr>
                <tr>
                    <th>연락처</th>
                    <td>${orderInfo.USER_PHONE}</td>
                </tr>
                <tr>
                    <th>배달 주소</th>
                    <td>${orderInfo.STORE_ADDRESS}</td>
                </tr>
            </table>
        </div>
    </div>
    
    <div class="row mb-4">
        <div class="col-12">
            <h5>요청사항</h5>
            <table class="table table-bordered">
            	<tr>
            		<th>결제 수단</th>
            		<td>${orderInfo.PAYMENT_METHOD}</td>
            	</tr>
                <tr>
                    <th width="20%">가게 요청사항</th>
                    <td>${empty orderInfo.OWNER_REQUEST ? '없음' : orderInfo.OWNER_REQUEST}</td>
                </tr>
                <tr>
                    <th>배달 요청사항</th>
                    <td>${empty orderInfo.RIDER_REQUEST ? '없음' : orderInfo.RIDER_REQUEST}</td>
                </tr>
            </table>
        </div>
    </div>
    
    <div class="row">
        <div class="col-12">
            <h5>주문 상품 목록</h5>
            <table class="table table-bordered">
                <thead>
                    <tr class="table-dark">
                        <th>상품명</th>
                        <th>옵션</th>
                        <th>가격</th>
                        <th>수량</th>
                        <th>합계</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${orderItems}">
                        <tr>
                            <td>
                                <c:if test="${not empty item.IMAGE_NAME}">
                                    <img src="/upload/menuItem/${item.IMAGE_NAME}" alt="${item.MENU_NAME}" style="width: 50px; height: 50px;" class="me-2">
                                </c:if>
                                ${item.MENU_NAME}
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty item.OPTION_NAMES}">기본</c:when>
                                    <c:otherwise>${item.OPTION_NAMES}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatNumber value="${item.MENU_PRICE}" pattern="#,###원"/> 
                                <c:if test="${not empty item.OPTION_PRICES}">
                                    + <fmt:formatNumber value="${item.TOTAL_OPTION_PRICE}" pattern="#,###원"/>
                                </c:if>
                            </td>
                            <td>${item.QUANTITY}개</td>
                            <td><fmt:formatNumber value="${item.ITEM_TOTAL_PRICE}" pattern="#,###원"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr class="table-secondary">
                        <th colspan="4" class="text-end">총 주문 금액</th>
                        <th><fmt:formatNumber value="${orderInfo.TOTALPRICE}" pattern="#,###원"/></th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>