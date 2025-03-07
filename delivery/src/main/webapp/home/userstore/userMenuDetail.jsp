<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 상세</title>
<style>
body {
	font-family: Arial, sans-serif;
}

.container {
	display: flex;
	width: 80%;
	margin: auto;
	padding: 20px;
}

.menu-image {
	width: 50%;
	text-align: center;
}

.menu-image img {
	width: 100%;
	max-width: 400px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.menu-details {
	width: 50%;
	padding: 20px;
}

h2 {
	margin-bottom: 10px;
}

.option-group {
	margin-top: 20px;
}

.option-group h3 {
	margin-bottom: 5px;
}

.option-list {
	list-style: none;
	padding: 0;
}

.option-list li {
	list-style: none; /* 목록 스타일 제거 */
	padding: 0; /* 기본 패딩 제거 */
	margin: 0; /* 기본 마진 제거 */
}

.price {
	font-size: 20px;
	color: #ff5722;
	font-weight: bold;
}

.add-to-cart {
	margin-top: 20px;
	padding: 10px;
	background-color: #ff5722;
	color: white;
	border: none;
	cursor: pointer;
	font-size: 18px;
	border-radius: 5px;
}

.add-to-cart:hover {
	background-color: #e64a19;
}
/* 수량 선택 컨트롤 스타일 추가 */
.quantity-container {
	display: flex;
	align-items: center;
	margin: 20px 0;
}

.quantity-input {
	width: 50px;
	height: 40px;
	text-align: center;
	font-size: 18px;
	border: 1px solid #ddd;
	border-radius: 4px;
	margin: 0 10px;
	/* 입력 필드의 기본 화살표 제거 */
	-webkit-appearance: none;
	-moz-appearance: textfield;
}
/* 브라우저별 화살표 제거 */
.quantity-input::-webkit-outer-spin-button, .quantity-input::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

.quantity-btn {
	width: 40px;
	height: 40px;
	background-color: #f1f1f1;
	border: none;
	border-radius: 50%;
	font-size: 20px;
	cursor: pointer;
	display: flex;
	justify-content: center;
	align-items: center;
}

.quantity-btn:hover {
	background-color: #ddd;
}

/* 모달 스타일 변경 */
.modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    justify-content: center;
    align-items: center;
    z-index: 1000;
}

.modal-content {
    background: white;
    border-radius: 10px;
    width: 90%;
    max-width: 350px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

.modal-content p {
    color: #333;
    line-height: 1.5;
    margin-bottom: 15px;
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
    border-radius: 5px;
    font-weight: bold;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.cancel-btn {
    background-color: #f1f1f1;
    color: #333;
    margin-right: 10px;
}

.confirm-btn {
    background-color: #2196F3;
    color: white;
}

.cancel-btn:hover {
    background-color: #e0e0e0;
}

.confirm-btn:hover {
    background-color: #1976D2;
}
</style>
</head>
<body>
	<form action="${pageContext.request.contextPath}/userstore/addCart" method="post" id="cartForm">
		<div class="container">
			<input type="hidden" name="menuId" value="${menuDetail.menu_item_id}">
			<!-- 왼쪽: 메뉴 이미지 -->
			<div class="menu-image">
				<img
					src="${pageContext.request.contextPath}/upload/menuItemProfile/${menuDetail.image_name}"
					alt="${menuDetail.menu_name}">
			</div>

			<!-- 오른쪽: 메뉴 상세 정보 및 옵션 선택 -->
			<div class="menu-details">
				<h2>${menuDetail.menu_name}</h2>
				<hr>
				<p class="price">${menuDetail.price}원</p>
				<hr>
				<p>${menuDetail.content}</p>
				<hr>
				<!-- 옵션 그룹 -->
				<div class="option-group">
					<ul class="option-list">
						<c:forEach var="entry" items="${optionGroups}">
							<h3>[${entry.key}]</h3>
							<ul>
								<c:forEach var="option" items="${entry.value}">
									<li><input type="checkbox" name="selectedOptions"
										value="${option.option_id}"> ${option.option_name}
										(+${option.option_price} 원) <!-- 체크된 항목에 대한 옵션 데이터 저장 --> <input
										type="hidden" name="allOptionIds" value="${option.option_id}">
										<input type="hidden" name="allOptionGroupIds"
										value="${option.option_group_id}"></li>
								</c:forEach>
							</ul>
						</c:forEach>
					</ul>
				</div>

				<!-- 수량 선택 컨트롤 추가 -->
				<div class="quantity-container">
					<button type="button" class="quantity-btn"
						onclick="decreaseQuantity()">-</button>
					<input type="number" id="quantity" name="quantity"
						class="quantity-input" value="1" min="1" max="10">
					<button type="button" class="quantity-btn"
						onclick="increaseQuantity()">+</button>
				</div>

				<!-- 장바구니 버튼 -->
				<button type="button" class="add-to-cart" onclick="submitForm()">장바구니에 추가</button>
			</div>
		</div>
	</form>
	
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
	</script>
</body>
</html>