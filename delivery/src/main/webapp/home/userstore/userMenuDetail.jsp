<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${menuDetail.menu_name} - 메뉴 상세</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f9f9f9;
	color: #333;
	line-height: 1.6;
	margin: 0;
	padding: 0;
}

.page-wrapper {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}

.store-info {
	margin-bottom: 20px;
	padding-bottom: 10px;
	border-bottom: 1px solid #e0e0e0;
}

.store-category {
	color: #666;
	font-size: 14px;
	margin-bottom: 5px;
}

.store-name {
	font-size: 24px;
	font-weight: bold;
	margin: 0;
	padding-bottom: 10px;
}

.container {
	display: flex;
	flex-wrap: wrap;
	max-width: 900px;
	margin: 20px auto;
	padding: 20px;
	background: white;
	border-radius: 8px;
	box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

.menu-header {
    max-width: 900px;
    margin: 20px auto 0;
    padding: 0 20px;
}

.menu-category {
    color: #666;
    font-size: 14px;
    margin-bottom: 5px;
}

.menu-title {
    font-size: 28px;
    font-weight: 700;
    margin: 0 0 5px 0;
    color: #333;
}

.menu-image {
	width: 40%;
	padding: 10px;
}

.menu-image img {
	width: 100%;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.menu-details {
	width: 60%;
	padding: 15px 20px;
}

h2 {
	font-size: 24px;
	font-weight: 700;
	margin: 0 0 12px 0;
	color: #333;
}

.price {
	font-size: 22px;
	color: #D4AF37;
	font-weight: 700;
	margin: 12px 0;
}

.menu-description {
	font-size: 14px;
	color: #666;
	margin: 12px 0;
	line-height: 1.5;
}

.option-group {
	margin: 20px 0;
	background: #f9f9f9;
	padding: 15px;
	border-radius: 8px;
}

.option-group h3 {
	font-size: 16px;
	font-weight: 600;
	margin: 0 0 12px 0;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.selection-type {
	font-size: 13px;
	color: #777;
	background: #f0f0f0;
	padding: 3px 8px;
	border-radius: 15px;
	font-weight: normal;
}

.option-list {
	list-style: none;
	padding: 0;
	margin: 0;
}

.option-list li {
	padding: 10px 12px;
	margin: 6px 0;
	background: white;
	border-radius: 6px;
	display: flex;
	align-items: center;
	transition: all 0.2s ease;
}

.option-list li:hover {
	box-shadow: 0 1px 5px rgba(0,0,0,0.08);
}

.option-name {
	flex-grow: 1;
	font-size: 14px;
}

.option-price {
	color: #D4AF37;
	font-weight: 600;
	font-size: 14px;
}

.quantity-container {
	display: flex;
	align-items: center;
	margin: 20px 0;
	background: #f9f9f9;
	padding: 10px;
	border-radius: 8px;
	justify-content: center;
}

.quantity-btn {
	width: 36px;
	height: 36px;
	border-radius: 50%;
	background: white;
	border: 1px solid #ddd;
	font-size: 16px;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	transition: all 0.2s;
}

.quantity-btn:hover {
	background: #eee;
}

.quantity-input {
	width: 50px;
	height: 36px;
	text-align: center;
	font-size: 16px;
	border: none;
	background: transparent;
	margin: 0 12px;
	font-weight: 600;
}

.add-to-cart {
	width: 100%;
	padding: 12px;
	background-color: #D4AF37;
	color: white;
	border: none;
	border-radius: 6px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s;
}

.add-to-cart:hover {
	background-color: #BF9B30;
}

input[type="radio"], input[type="checkbox"] {
	appearance: none;
	width: 18px;
	height: 18px;
	border: 2px solid #ddd;
	border-radius: 4px;
	margin-right: 10px;
	position: relative;
	cursor: pointer;
}

input[type="radio"] {
	border-radius: 50%;
}

input[type="radio"]:checked, input[type="checkbox"]:checked {
	background-color: #D4AF37;
	border-color: #D4AF37;
}

input[type="radio"]:checked::after, input[type="checkbox"]:checked::after {
	content: '✓';
	position: absolute;
	color: white;
	font-size: 12px;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.6);
	z-index: 1000;
	justify-content: center;
	align-items: center;
}

.modal-content {
	background: white;
	border-radius: 10px;
	width: 90%;
	max-width: 350px;
	padding: 25px;
	box-shadow: 0 5px 20px rgba(0,0,0,0.2);
	text-align: center;
}

.modal-content p {
	font-size: 15px;
	color: #555;
	margin-bottom: 8px;
}

.modal-buttons {
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
}

.modal-buttons button {
	flex: 1;
	padding: 12px;
	border: none;
	border-radius: 6px;
	font-weight: 600;
	font-size: 15px;
	cursor: pointer;
	transition: all 0.3s;
}

.cancel-btn {
	background: #f1f1f1;
	color: #333;
	margin-right: 12px;
}

.confirm-btn {
	background: #D4AF37;
	color: white;
}

.cancel-btn:hover {
	background: #e0e0e0;
}

.confirm-btn:hover {
	background: #BF9B30;
}

@media (max-width: 768px) {
	.container {
		flex-direction: column;
		padding: 15px;
	}
	
	.menu-image, .menu-details {
		width: 100%;
		padding: 10px;
	}
	
	h2 {
		font-size: 22px;
	}
	
	.price {
		font-size: 20px;
	}
	
	.option-group {
		padding: 12px;
	}
    
    .menu-header {
        padding: 0 15px;
    }
    
    .menu-title {
        font-size: 24px;
    }
}
</style>
</head>
<body>
    <div class="page-wrapper">
        <form action="${pageContext.request.contextPath}/userstore/addCart" method="post" id="cartForm">
            <input type="hidden" name="menuId" value="${menuDetail.menu_item_id}">

            
            <div class="container">

                <div class="menu-image">
                    <img
                        src="${pageContext.request.contextPath}/upload/menuItemProfile/${menuDetail.image_name}"
                        alt="${menuDetail.menu_name}">
                </div>


                <div class="menu-details">
                    <p class="price"><fmt:formatNumber value="${menuDetail.price}" pattern="#,###" />원</p>
                    <p class="menu-description">${menuDetail.content}</p>
                    
                    <!-- 옵션 그룹 -->
                    <c:forEach var="entry" items="${optionGroups}">
                    <c:set var="selectionType" value="${entry.value[0].selection_type}" />
                    <div class="option-group">
                        <h3>
                            ${entry.key}
                            <c:choose>
                                <c:when test="${selectionType eq 'single' }">
                                    <span class="selection-type">(단일 선택)</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="selection-type">(중복 선택)</span>
                                </c:otherwise>
                            </c:choose>
                        </h3>
                        
                        <ul class="option-list">
                            <c:forEach var="option" items="${entry.value}">
                                <li>
                                    <c:choose>
                                        <c:when test="${selectionType eq 'single'}">
                                            <input type="radio" name="optionGroup_${option.option_group_id}" value="${option.option_id}" id="option_${option.option_id}" data-group-id="${option.option_group_id}">
                                        </c:when>
                                        <c:otherwise>
                                            <input type="checkbox" name="selectedOptions" value="${option.option_id}" id="option_${option.option_id}" data-group-id="${option.option_group_id}">
                                        </c:otherwise>
                                    </c:choose>
                                    <label for="option_${option.option_id}" class="option-name">
                                        ${option.option_name}
                                    </label>
                                    <span class="option-price">+<fmt:formatNumber value="${option.option_price}" pattern="#,###" />원</span>
                                    <input type="hidden" name="allOptionIds" value="${option.option_id}">
                                    <input type="hidden" name="allOptionGroupIds" value="${option.option_group_id}">
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    </c:forEach>


                    <div class="quantity-container">
                        <button type="button" class="quantity-btn" onclick="decreaseQuantity()">
                            <i class="fas fa-minus"></i>
                        </button>
                        <input type="number" id="quantity" name="quantity" class="quantity-input" value="1" min="1" max="10" readonly>
                        <button type="button" class="quantity-btn" onclick="increaseQuantity()">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>


                    <button type="button" class="add-to-cart" onclick="submitForm()">
                        <i class="fas fa-shopping-cart"></i> 장바구니에 추가
                    </button>
                </div>
            </div>
        </form>
    </div>
    
    <div id="customModal" class="modal">
        <div class="modal-content">
            <p>장바구니에는 같은 가게의 메뉴만 담을 수 있습니다.</p>
            <p>선택하신 메뉴를 장바구니에 담을 경우 이전에 담은 메뉴가 삭제됩니다.</p>
            <div class="modal-buttons">
                <button class="cancel-btn" onclick="closeModal()">취소</button>
                <button class="confirm-btn" onclick="confirmAddToCart()">담기</button>
            </div>
        </div>
    </div>

    <script>
        function increaseQuantity() {
            const quantityInput = document.getElementById('quantity');
            const currentValue = parseInt(quantityInput.value);
            if (currentValue < 10) {
                quantityInput.value = currentValue + 1;
            }
        }

        function decreaseQuantity() {
            const quantityInput = document.getElementById('quantity');
            const currentValue = parseInt(quantityInput.value);
            if (currentValue > 1) {
                quantityInput.value = currentValue - 1;
            }
        }
        
        function submitForm() {
            // 로그인 여부 확인 (가장 먼저 체크)
            if (${sessionScope.loginUser == null}) {
                alert('장바구니에 추가하려면 로그인해야 합니다.');
                window.location.href = '/user/loginForm';
                return false;
            }
            
            // 이후 기존의 옵션 유효성 검사 코드...
            const form = document.getElementById('cartForm');
            const optionGroups = {};
            
            // 폼에서 이전에 추가된 hidden input 제거
            document.querySelectorAll('input[name="selectedOptions"][type="hidden"]').forEach(el => {
                el.remove();
            });
            
            // 모든 라디오 버튼을 확인하여 그룹별로 분류
            document.querySelectorAll('input[type="radio"]').forEach(radio => {
                const groupId = radio.getAttribute('data-group-id');
                if (!optionGroups[groupId]) {
                    optionGroups[groupId] = {
                        name: groupId,
                        hasSelection: false
                    };
                }
                
                if (radio.checked) {
                    optionGroups[groupId].hasSelection = true;
                    
                    // 선택된 라디오 버튼의 값을 hidden input으로 추가
                    const hiddenInput = document.createElement('input');
                    hiddenInput.type = 'hidden';
                    hiddenInput.name = 'selectedOptions';
                    hiddenInput.value = radio.value;
                    form.appendChild(hiddenInput);
                }
            });
            
            // 모든 단일 선택 옵션 그룹에 선택이 있는지 확인
            let allGroupsHaveSelection = true;
            for (const groupId in optionGroups) {
                if (!optionGroups[groupId].hasSelection) {
                    allGroupsHaveSelection = false;
                    alert('옵션을 모두 선택해주세요.');
                    break;
                }
            }
            
            if (!allGroupsHaveSelection) {
                return;
            }
            
            // 컨트롤러에서 이미 비교 작업이 수행되었으므로 
            // showModal이 true인 경우 모달을 표시하고, 아니면 바로 폼 제출
            if (${showModal}) {
                document.getElementById('customModal').style.display = 'flex';
            } else {
                document.getElementById('cartForm').submit();
            }
        }
        
        function confirmAddToCart() {
            document.getElementById('cartForm').submit();
        }

        function closeModal() {
            document.getElementById('customModal').style.display = 'none';
        }
        
        // 수량 입력 필드를 읽기 전용으로 만들기
        document.addEventListener('DOMContentLoaded', function() {
            const quantityInput = document.getElementById('quantity');
            
            // 직접 입력 방지
            quantityInput.addEventListener('keydown', function(e) {
                e.preventDefault();
            });
            
            // 마우스 휠로 값 변경 방지
            quantityInput.addEventListener('wheel', function(e) {
                e.preventDefault();
            });
        });
    </script>
</body>
</html>