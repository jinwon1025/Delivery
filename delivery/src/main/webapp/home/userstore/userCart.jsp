<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>장바구니</title>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<style>
:root {
<<<<<<< HEAD
	--primary-color: #D4AF37; /* 금색으로 변경 */
	--primary-light: #F5E7A3; /* 연한 금색으로 변경 */
	--secondary-color: #333;
	--gray-light: #f8f9fa;
	--gray-medium: #e9ecef;
	--gray-dark: #6c757d;
	--success-color: #4CAF50;
	--warning-color: #FFC107;
	--danger-color: #F44336;
	--border-radius: 8px;
	--shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.05);
	--shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
	--shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
	--font-family: 'Noto Sans KR', -apple-system, BlinkMacSystemFont,
		'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans',
		'Helvetica Neue', sans-serif;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
=======
    --primary-color: #FFD700;
    --primary-dark: #E6C200;
    --primary-light: #FFF8E1;
    --secondary-color: #333333;
    --accent-color: #FF3D00;
    --light-gray: #F7F7F7;
    --medium-gray: #E0E0E0;
    --dark-gray: #757575;
    --text-color: #212121;
    --white: #FFFFFF;
    --success-color: #00C853;
    --error-color: #FF3D00;
    --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 8px rgba(0, 0, 0, 0.1);
    --border-radius: 12px;
    --transition: all 0.3s ease;
    --header-height: 60px;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f8f8f8;
    color: var(--text-color);
    line-height: 1.6;
    margin: 0;
    padding: 0;
}

.cart-logo {
    width: 28px;
    height: 28px;
    margin-right: 10px;
>>>>>>> refs/remotes/origin/master
}

<<<<<<< HEAD
body {
	font-family: var(--font-family);
	background-color: var(--gray-light);
	color: var(--secondary-color);
	line-height: 1.6;
	padding: 0;
	margin: 0;
}

.container {
	max-width: 800px;
	margin: 20px auto;
	padding: 0 15px;
=======
.cart-container {
    max-width: 820px;
    margin: 20px auto;
    background-color: var(--white);
    border-radius: var(--border-radius);
    box-shadow: var(--shadow-md);
    overflow: hidden;
    display: flex;
    flex-direction: column;
>>>>>>> refs/remotes/origin/master
}

<<<<<<< HEAD
.card {
	background-color: #fff;
	border-radius: var(--border-radius);
	box-shadow: var(--shadow-md);
	overflow: hidden;
}

.card-header {
	padding: 20px 25px;
	border-bottom: 1px solid var(--gray-medium);
	background-color: #fff;
	position: relative;
}

.card-header h1 {
	font-size: 1.5rem;
	margin: 0;
	color: var(--secondary-color);
	font-weight: 700;
	display: flex;
	align-items: center;
}

.card-header h1 i {
	margin-right: 10px;
	color: var(--primary-color);
}

.card-body {
	padding: 0;
}

.empty-cart {
	padding: 60px 20px;
	text-align: center;
}

.empty-cart i {
	font-size: 4rem;
	color: var(--gray-dark);
	margin-bottom: 20px;
=======
.cart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 25px;
    border-bottom: 1px solid var(--medium-gray);
    background-color: var(--white);
>>>>>>> refs/remotes/origin/master
}

<<<<<<< HEAD
.empty-cart h2 {
	font-size: 1.5rem;
	margin-bottom: 10px;
	color: var(--secondary-color);
=======
.cart-header h1 {
    color: var(--text-color);
    font-size: 22px;
    font-weight: 700;
    display: flex;
    align-items: center;
}

.cart-empty {
    padding: 60px 20px;
    text-align: center;
}

.cart-empty h2 {
    font-size: 20px;
    color: var(--text-color);
    margin-bottom: 12px;
}

.cart-empty p {
    color: var(--dark-gray);
    margin-bottom: 24px;
}

.select-all-container {
    display: flex;
    align-items: center;
    padding: 16px 25px;
    background-color: var(--white);
    border-bottom: 1px solid var(--medium-gray);
}

.select-all-checkbox {
    position: relative;
    width: 20px;
    height: 20px;
    margin-right: 10px;
    cursor: pointer;
    appearance: none;
    border: 2px solid var(--dark-gray);
    border-radius: 4px;
    transition: var(--transition);
}

.select-all-checkbox:checked {
    background-color: var(--primary-color);
    border-color: var(--primary-color);
}

.select-all-checkbox:checked::after {
    content: '';
    position: absolute;
    left: 6px;
    top: 2px;
    width: 5px;
    height: 10px;
    border: solid white;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
}

.select-all-label {
    font-weight: 500;
    font-size: 15px;
}

.cart-items-container {
    flex: 1;
    overflow-y: auto;
    max-height: calc(100vh - 350px);
    min-height: 200px;
}

.cart-item {
    display: flex;
    align-items: center;
    padding: 20px 25px;
    border-bottom: 1px solid var(--medium-gray);
    position: relative;
    transition: var(--transition);
}

.cart-item:hover {
    background-color: var(--primary-light);
}

.cart-checkbox {
    position: relative;
    width: 20px;
    height: 20px;
    margin-right: 15px;
    cursor: pointer;
    appearance: none;
    border: 2px solid var(--dark-gray);
    border-radius: 4px;
    transition: var(--transition);
    flex-shrink: 0;
>>>>>>> refs/remotes/origin/master
}

<<<<<<< HEAD
.empty-cart p {
	color: var(--gray-dark);
	margin-bottom: 25px;
}

.btn {
	display: inline-block;
	font-weight: 600;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	user-select: none;
	border: none;
	padding: 12px 25px;
	font-size: 0.95rem;
	line-height: 1.5;
	border-radius: var(--border-radius);
	cursor: pointer;
	transition: all 0.2s ease-in-out;
	text-decoration: none;
}

.btn-primary {
	background-color: var(--primary-color);
	color: white;
}

.btn-primary:hover {
	background-color: #BF9B30; /* 어두운 금색으로 변경 */
}

.btn-outline {
	background-color: transparent;
	border: 1px solid var(--primary-color);
	color: var(--primary-color);
}

.btn-outline:hover {
	background-color: var(--primary-light);
}

.btn-danger {
	background-color: var(--danger-color);
	color: white;
}

.btn-danger:hover {
	background-color: #D32F2F;
}

.btn-sm {
	padding: 6px 12px;
	font-size: 0.875rem;
	border-radius: 4px;
}

.cart-items {
	padding: 0;
}

.cart-item {
	display: flex;
	align-items: center;
	padding: 20px 25px;
	border-bottom: 1px solid var(--gray-medium);
	position: relative;
}

.cart-item:last-child {
	border-bottom: none;
}

.cart-item:hover {
	background-color: rgba(0, 0, 0, 0.01);
}

.item-image {
	width: 80px;
	height: 80px;
	border-radius: var(--border-radius);
	object-fit: cover;
	box-shadow: var(--shadow-sm);
}

.item-details {
	flex: 1;
	margin-left: 15px;
	overflow: hidden;
}

.item-name {
	font-weight: 700;
	font-size: 1rem;
	margin-bottom: 5px;
	color: var(--secondary-color);
}

.item-options {
	margin-top: 8px;
	font-size: 0.85rem;
	color: var(--gray-dark);
}

.option-item {
	background-color: var(--gray-light);
	border-radius: 4px;
	padding: 4px 8px;
	margin-right: 5px;
	margin-bottom: 5px;
	display: inline-block;
	white-space: nowrap;
=======
.cart-checkbox:checked {
    background-color: var(--primary-color);
    border-color: var(--primary-color);
}

.cart-checkbox:checked::after {
    content: '';
    position: absolute;
    left: 6px;
    top: 2px;
    width: 5px;
    height: 10px;
    border: solid white;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
>>>>>>> refs/remotes/origin/master
}

<<<<<<< HEAD
.option-item span {
	color: var(--primary-color);
	font-weight: 500;
}

.item-actions {
	display: flex;
	align-items: center;
	margin-left: 15px;
}

.quantity-control {
	display: flex;
	align-items: center;
	margin-right: 15px;
=======
.menu-image {
    width: 70px;
    height: 70px;
    border-radius: 10px;
    object-fit: cover;
    margin-right: 15px;
    box-shadow: var(--shadow-sm);
    flex-shrink: 0;
}

.cart-item-details {
    flex-grow: 1;
    min-width: 0; /* Prevent flexbox items from overflowing */
    padding-right: 10px;
    align-self: center;
}

.cart-item-name {
    font-weight: 600;
    font-size: 16px;
    margin-bottom: 8px;
    color: var(--text-color);
}

.cart-item-options {
    color: var(--dark-gray);
    font-size: 14px;
    margin-bottom: 12px;
}

.option-item {
    margin-bottom: 4px;
    padding-left: 5px;
    display: block;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 13px;
}

.cart-item-actions {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    margin-left: 10px;
    flex-shrink: 0;
    width: 130px;
}

.cart-item-price {
    font-weight: 700;
    color: var(--text-color);
    margin-top: 8px;
    font-size: 17px;
>>>>>>> refs/remotes/origin/master
}

<<<<<<< HEAD
.quantity-btn {
	width: 32px;
	height: 32px;
	border-radius: 50%;
	border: 1px solid var(--gray-medium);
	background-color: white;
	color: var(--secondary-color);
	font-size: 1rem;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	transition: all 0.2s;
}

.quantity-btn:hover {
	background-color: var(--gray-medium);
}

.quantity-input {
	width: 40px;
	height: 32px;
	margin: 0 8px;
	text-align: center;
	border: 1px solid var(--gray-medium);
	border-radius: var(--border-radius);
	font-size: 0.95rem;
	font-weight: 500;
}

.quantity-input:focus {
	outline: none;
	border-color: var(--primary-color);
}

.item-price {
	font-weight: 700;
	font-size: 1.05rem;
	color: var(--secondary-color);
	white-space: nowrap;
	text-align: right;
	margin: 0 15px;
}

.delete-btn {
	background-color: transparent;
	border: none;
	color: var(--gray-dark);
	cursor: pointer;
	font-size: 1.1rem;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 8px;
	border-radius: 50%;
	transition: all 0.2s;
}

.delete-btn:hover {
	color: var(--danger-color);
	background-color: var(--gray-light);
}

.summary-card {
	margin-top: 20px;
	background-color: white;
	border-radius: var(--border-radius);
	box-shadow: var(--shadow-md);
	overflow: hidden;
}

.summary-header {
	padding: 15px 25px;
	border-bottom: 1px solid var(--gray-medium);
	background-color: var(--gray-light);
}

.summary-header h2 {
	font-size: 1.2rem;
	margin: 0;
	color: var(--secondary-color);
	font-weight: 600;
}

.summary-body {
	padding: 20px 25px;
}

.summary-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
}

.summary-row:last-child {
	margin-bottom: 0;
}

.summary-label {
	color: var(--gray-dark);
}

.summary-value {
	font-weight: 500;
}

.summary-total {
	display: flex;
	justify-content: space-between;
	padding-top: 15px;
	margin-top: 15px;
	border-top: 1px solid var(--gray-medium);
}

.summary-total-label {
	font-weight: 700;
	font-size: 1.1rem;
}

.summary-total-value {
	font-weight: 700;
	font-size: 1.2rem;
	color: var(--primary-color);
}

.action-buttons {
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
	align-items: stretch; /* 모든 아이템이 동일한 높이를 갖도록 */
	height: 50px; /* 전체 컨테이너의 높이 설정 */
}

.action-buttons form {
	margin: 0;
	padding: 0;
	display: flex;
}

.action-buttons form:first-child {
	margin-right: 10px;
	flex: 1;
}

.action-buttons form:last-child {
	flex: 2;
}

.btn-continue, .btn-checkout {
	width: 100%;
	height: 50px;
	padding: 0 25px;
	font-weight: 600;
	display: flex;
	align-items: center;
	justify-content: center;
	box-sizing: border-box;
	border-radius: var(--border-radius);
}

@media ( max-width : 768px) {
	.container {
		padding: 0 10px;
	}
	.cart-item {
		flex-direction: column;
		align-items: flex-start;
		padding: 20px 15px;
	}
	.item-image {
		width: 100%;
		height: 150px;
		margin-bottom: 15px;
	}
	.item-details {
		width: 100%;
		margin-left: 0;
		margin-bottom: 15px;
	}
	.item-actions {
		width: 100%;
		margin-left: 0;
		justify-content: space-between;
	}
	.action-buttons {
		flex-direction: column;
		height: auto;
	}
	.btn-continue {
		margin-right: 0;
		margin-bottom: 10px;
	}
	.action-buttons form:first-child {
		margin-right: 0;
		margin-bottom: 10px;
	}
}

@media ( max-width : 576px) {
	.action-buttons {
		flex-direction: column;
		height: auto;
	}
	.btn-continue, .btn-checkout {
		padding: 14px 25px;
		font-weight: 600;
		height: 50px;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.btn-continue {
		margin-right: 0;
		margin-bottom: 10px;
	}
	.action-buttons form:first-child {
		margin-right: 0;
		margin-bottom: 10px;
	}
}

/* Chrome, Safari, Edge에서 number 타입 input의 화살표 제거 */
input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
=======
.quantity-container {
    display: flex;
    align-items: center;
    margin: 10px 0;
    background-color: var(--light-gray);
    border-radius: 30px;
    padding: 2px;
    width: 100%;
    justify-content: space-between;
>>>>>>> refs/remotes/origin/master
}

<<<<<<< HEAD
/* Firefox에서 number 타입 input의 화살표 제거 */
input[type=number] {
	-moz-appearance: textfield;
=======
.quantity-btn {
    width: 34px;
    height: 34px;
    border: none;
    border-radius: 50%;
    font-size: 18px;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: var(--light-gray);
    color: var(--text-color);
    transition: var(--transition);
}

.quantity-btn:hover {
    background-color: var(--medium-gray);
}

.quantity-input {
    width: 40px;
    height: 34px;
    text-align: center;
    font-size: 15px;
    border: none;
    background-color: transparent;
    font-weight: 600;
    -webkit-appearance: none;
    -moz-appearance: textfield;
}

.quantity-input::-webkit-outer-spin-button,
.quantity-input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

.delete-btn {
    background-color: transparent;
    color: var(--dark-gray);
    border: none;
    border-radius: 4px;
    padding: 6px 12px;
    cursor: pointer;
    font-size: 13px;
    transition: var(--transition);
    margin-top: 10px;
}

.delete-btn:hover {
    color: var(--error-color);
}

.payment-summary {
    background-color: var(--white);
    padding: 20px 25px;
    border-top: 1px solid var(--medium-gray);
}

.payment-summary-title {
    font-size: 16px;
    font-weight: 700;
    margin-bottom: 15px;
    color: var(--text-color);
}

.payment-summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 12px;
    font-size: 14px;
}

.payment-summary-price {
    font-weight: 500;
}

.payment-summary-total {
    display: flex;
    justify-content: space-between;
    margin-top: 15px;
    padding-top: 15px;
    border-top: 1px solid var(--medium-gray);
    font-size: 18px;
    font-weight: 700;
}

.total-price {
    color: var(--accent-color);
}

.order-footer {
    background-color: var(--white);
    padding: 20px 25px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top: 1px solid var(--medium-gray);
}

.order-footer-right {
    display: flex;
    gap: 10px;
}

.btn {
    display: inline-block;
    padding: 13px 26px;
    font-size: 15px;
    font-weight: 600;
    text-align: center;
    text-decoration: none;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: var(--transition);
}

.btn-primary {
    background-color: var(--primary-color);
    color: var(--text-color);
    font-weight: 700;
}

.btn-primary:hover {
    background-color: var(--primary-dark);
}

.btn-outline {
    background-color: var(--white);
    color: var(--text-color);
    border: 1px solid var(--medium-gray);
}

.btn-outline:hover {
    background-color: var(--light-gray);
}

.btn-submit {
    background-color: var(--primary-color);
    color: var(--text-color);
    min-width: 120px;
    font-weight: 700;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.btn-submit:hover {
    background-color: var(--primary-dark);
    transform: translateY(-1px);
    box-shadow: 0 3px 7px rgba(0, 0, 0, 0.15);
}

@media (max-width: 768px) {
    .cart-container {
        margin: 0;
        border-radius: 0;
        height: 100vh;
        max-height: 100vh;
    }
    
    .cart-header, .select-all-container, .cart-item, .payment-summary, .order-footer {
        padding-left: 16px;
        padding-right: 16px;
    }
    
    .cart-items-container {
        max-height: calc(100vh - 300px);
    }
    
    .cart-item {
        display: grid;
        grid-template-columns: auto 1fr;
        grid-template-rows: auto auto;
        grid-template-areas: 
            "check image details"
            "check image actions";
        column-gap: 15px;
        align-items: center;
    }
    
    .cart-checkbox {
        grid-area: check;
        align-self: center;
        justify-self: center;
    }
    
    .menu-image {
        grid-area: image;
        width: 60px;
        height: 60px;
    }
    
    .cart-item-details {
        grid-area: details;
        padding-right: 0;
    }
    
    .cart-item-name {
        font-size: 15px;
        margin-bottom: 5px;
    }
    
    .cart-item-options {
        font-size: 13px;
        margin-bottom: 5px;
    }
    
    .cart-item-actions {
        grid-area: actions;
        width: 100%;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        margin-left: 0;
        margin-top: 5px;
    }
    
    .quantity-container {
        width: auto;
        margin: 0;
    }
    
    .cart-item-price {
        margin-top: 0;
    }
    
    .delete-btn {
        padding: 4px 8px;
        margin-top: 0;
    }
    
    .order-footer {
        flex-direction: column;
        gap: 15px;
    }
    
    .order-footer-right {
        width: 100%;
    }
    
    .btn {
        flex: 1;
    }
}

@media (max-width: 480px) {
    .cart-item {
        grid-template-columns: auto 1fr;
        grid-template-rows: auto auto auto;
        grid-template-areas: 
            "check image details"
            "check image details"
            ". actions actions";
        row-gap: 10px;
    }
    
    .cart-item-actions {
        width: 100%;
        margin-top: 10px;
    }
>>>>>>> refs/remotes/origin/master
}
</style>
</head>
<body>
<<<<<<< HEAD
	<div class="container">
		<c:choose>
			<c:when test="${isEmptyCart == 'empty'}">
				<div class="card">
					<div class="card-header">
						<h1>
							<i class="fas fa-shopping-cart"></i> 장바구니
						</h1>
=======
	<!-- 장바구니가 비어있는지 여부에 따라 다른 내용 표시 -->
	<c:choose>
		<c:when test="${isEmptyCart == 'empty'}">
			<div class="cart-container">
				<div class="cart-header">
					<h1>
                        <svg class="cart-logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#FFD700" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="9" cy="21" r="1"></circle>
                            <circle cx="20" cy="21" r="1"></circle>
                            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                        </svg>
                        장바구니
                    </h1>
				</div>
				<div class="cart-empty">
					<svg width="80" height="80" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="margin: 0 auto 20px; display: block; opacity: 0.5;">
                        <circle cx="9" cy="21" r="1" stroke="#757575" stroke-width="2"/>
                        <circle cx="20" cy="21" r="1" stroke="#757575" stroke-width="2"/>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6" stroke="#757575" stroke-width="2"/>
                    </svg>
					<h2>장바구니가 비어있어요</h2>
					<p>맛있는 음식을 장바구니에 담아보세요!</p>
					<a href="/user/categoryStores" class="btn btn-primary">메뉴 보러가기</a>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="cart-container">
				<div class="cart-header">
					<h1>
                        <svg class="cart-logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#FFD700" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="9" cy="21" r="1"></circle>
                            <circle cx="20" cy="21" r="1"></circle>
                            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                        </svg>
                        장바구니
                    </h1>
				</div>

				<div class="select-all-container">
					<input type="checkbox" id="selectAll" class="select-all-checkbox"
						onclick="selectAll(this)" checked> <label for="selectAll"
						class="select-all-label">전체 선택</label>
				</div>

                <div class="cart-items-container">
				<%-- 메뉴 아이템 출력 --%>
				<c:forEach items="${cartDetails}" var="item" varStatus="status">
					<c:if
						test="${status.index == 0 || cartDetails[status.index-1].MENU_ITEM_ID != item.MENU_ITEM_ID || cartDetails[status.index-1].ORDER_OPTION_ID != item.ORDER_OPTION_ID}">
						<div class="cart-item" data-menu-id="${item.MENU_ITEM_ID}" 
							data-price="${item.MENU_PRICE}" 
							data-option-price="${item.TOTAL_OPTION_PRICE}" 
							data-quantity="${item.QUANTITY}" 
							data-order-option-id="${item.ORDER_OPTION_ID}">
							
							<img src="${pageContext.request.contextPath}/upload/menuItemProfile/${item.IMAGE_NAME}"
								alt="${item.MENU_NAME}" class="menu-image">

							<div class="cart-item-details">
								<div class="cart-item-name">${item.MENU_NAME}</div>
								<div class="cart-item-options">
									<c:forEach items="${cartDetails}" var="option">
										<c:if
											test="${option.MENU_ITEM_ID == item.MENU_ITEM_ID && option.ORDER_OPTION_ID == item.ORDER_OPTION_ID}">
											<c:set var="optionNames"
												value="${fn:split(option.OPTION_NAMES, ', ')}" />
											<c:set var="optionPrices"
												value="${fn:split(option.OPTION_PRICES, ', ')}" />

											<c:forEach items="${optionNames}" var="name"
												varStatus="optStatus">
												<div class="option-item">
													${name}
													<c:if
														test="${not empty optionPrices[optStatus.index] && optionPrices[optStatus.index] != '0'}">
                                                        (+${optionPrices[optStatus.index]}원)
                                                    </c:if>
													<c:if
														test="${empty optionPrices[optStatus.index] || optionPrices[optStatus.index] == '0'}">
                                                        (+0원)
                                                    </c:if>
												</div>
											</c:forEach>
										</c:if>
									</c:forEach>
								</div>
							</div>

							<div class="cart-item-actions">
								<div class="quantity-container">
									<button type="button" class="quantity-btn"
										data-menu-id="${item.MENU_ITEM_ID}"
										data-option-id="${item.ORDER_OPTION_ID}"
										data-order-id="${item.ORDER_ID}"
										onclick="decreaseQuantity(this)">-</button>
									<input type="number" name="quantity" class="quantity-input"
										value="${empty item.QUANTITY ? 1 : item.QUANTITY}" min="1"
										max="10" data-menu-id="${item.MENU_ITEM_ID}"
										data-option-id="${item.ORDER_OPTION_ID}"
										data-order-id="${item.ORDER_ID}">
									<button type="button" class="quantity-btn"
										data-menu-id="${item.MENU_ITEM_ID}"
										data-option-id="${item.ORDER_OPTION_ID}"
										data-order-id="${item.ORDER_ID}"
										onclick="increaseQuantity(this)">+</button>
								</div>

								<div class="cart-item-price">
									<fmt:formatNumber
										value="${(item.MENU_PRICE + item.TOTAL_OPTION_PRICE) * (empty item.QUANTITY ? 1 : item.QUANTITY)}"
										type="number" />
									원
								</div>

								<form action="/userstore/deleteItemInCart" method="post"
									onsubmit="return deleteCheck()">
									<input type="hidden" name="menu_item_id"
										value="${item.MENU_ITEM_ID}" /> <input type="hidden"
										name="order_id" value="${item.ORDER_ID}" /> <input
										type="hidden" name="order_option_id"
										value="${item.ORDER_OPTION_ID}" /> <input type="submit"
										value="삭제" class="delete-btn" />
								</form>
							</div>
						</div>
					</c:if>
				</c:forEach>
                </div>

				<!-- 결제 금액 요약 박스 추가 -->
				<div class="payment-summary">
					<div class="payment-summary-title">결제금액</div>
					<div class="payment-summary-row">
						<div>메뉴금액</div>
						<div class="payment-summary-price">
							<span id="menuPriceDisplay"> <c:set var="totalPrice"
									value="0" /> <c:set var="processedItems" value="" /> <c:forEach
									items="${cartDetails}" var="item">
									<c:set var="itemKey"
										value="${item.MENU_ITEM_ID}-${item.ORDER_OPTION_ID}" />
									<c:if test="${!fn:contains(processedItems, itemKey)}">
										<c:set var="itemQuantity"
											value="${empty item.QUANTITY ? 1 : item.QUANTITY}" />
										<c:set var="totalPrice"
											value="${totalPrice + ((item.MENU_PRICE + item.TOTAL_OPTION_PRICE) * itemQuantity)}" />
										<c:set var="processedItems"
											value="${processedItems},${itemKey}" />
									</c:if>
								</c:forEach> <fmt:formatNumber value="${totalPrice}" type="number" />원
							</span>
						</div>
>>>>>>> refs/remotes/origin/master
					</div>
					<div class="card-body">
						<div class="empty-cart">
							<i class="fas fa-shopping-basket"></i>
							<h2>장바구니가 비어있어요</h2>
							<p>맛있는 음식을 장바구니에 담아보세요!</p>
							<a href="/user/categoryStores" class="btn btn-primary"
								onclick="return checkLogin()"> <i class="fas fa-utensils"></i>
								메뉴 보러가기
							</a>
						</div>
					</div>
				</div>
<<<<<<< HEAD
			</c:when>
			<c:otherwise>
				<div class="card">
					<div class="card-header">
						<h1>
							<i class="fas fa-shopping-cart"></i> 장바구니
						</h1>
					</div>
					<div class="card-body">
						<div class="cart-items">
=======

				<!-- 하단 주문 정보 및 버튼  컨테이너 -->
				<div class="order-footer">
					<div class="order-footer-right">
						
							<a href="/userstore/returnToStore?store_id=${cartDetails[0].STORE_ID}" class="btn btn-outline">메뉴 추가</a>
						<form action="/userStore/startOrder" method="get"
							onsubmit="return validateForm()">
							<input type="hidden" id="orderTotalPrice" name="totalPrice"
								value="${totalPrice}"> <input type="hidden"
								id="orderDeliveryFee" name="deliveryFee" value="${deliveryFee}">
							<input type="hidden" id="orderFinalTotalPrice"
								name="finalTotalPrice" value="${totalPrice + deliveryFee}">
							<input type="hidden" id="order_Id" name="order_Id"
								value="${cartDetails[0].ORDER_ID}">
>>>>>>> refs/remotes/origin/master
							<c:forEach items="${cartDetails}" var="item" varStatus="status">
								<c:if
									test="${status.index == 0 || cartDetails[status.index-1].MENU_ITEM_ID != item.MENU_ITEM_ID || cartDetails[status.index-1].ORDER_OPTION_ID != item.ORDER_OPTION_ID}">
									<div class="cart-item" data-menu-id="${item.MENU_ITEM_ID}"
										data-price="${item.MENU_PRICE}"
										data-option-price="${item.TOTAL_OPTION_PRICE}"
										data-quantity="${item.QUANTITY}"
										data-order-option-id="${item.ORDER_OPTION_ID}">

										<img
											src="${pageContext.request.contextPath}/upload/menuItemProfile/${item.IMAGE_NAME}"
											alt="${item.MENU_NAME}" class="item-image">

										<div class="item-details">
											<div class="item-name">${item.MENU_NAME}</div>
											<div class="item-options">
												<c:forEach items="${cartDetails}" var="option">
													<c:if
														test="${option.MENU_ITEM_ID == item.MENU_ITEM_ID && option.ORDER_OPTION_ID == item.ORDER_OPTION_ID}">
														<c:set var="optionNames"
															value="${fn:split(option.OPTION_NAMES, ', ')}" />
														<c:set var="optionPrices"
															value="${fn:split(option.OPTION_PRICES, ', ')}" />

														<c:forEach items="${optionNames}" var="name"
															varStatus="optStatus">
															<div class="option-item">
																${name}
																<c:if
																	test="${not empty optionPrices[optStatus.index] && optionPrices[optStatus.index] != '0'}">
																	<span>(+${optionPrices[optStatus.index]}원)</span>
																</c:if>
																<c:if
																	test="${empty optionPrices[optStatus.index] || optionPrices[optStatus.index] == '0'}">
																	<span>(+0원)</span>
																</c:if>
															</div>
														</c:forEach>
													</c:if>
												</c:forEach>
											</div>
										</div>

										<div class="item-actions">
											<div class="quantity-control">
												<button type="button" class="quantity-btn"
													data-menu-id="${item.MENU_ITEM_ID}"
													data-option-id="${item.ORDER_OPTION_ID}"
													data-order-id="${item.ORDER_ID}"
													onclick="decreaseQuantity(this)">
													<i class="fas fa-minus"></i>
												</button>
												<input type="number" name="quantity" class="quantity-input"
													value="${empty item.QUANTITY ? 1 : item.QUANTITY}" min="1"
													max="10" data-menu-id="${item.MENU_ITEM_ID}"
													data-option-id="${item.ORDER_OPTION_ID}"
													data-order-id="${item.ORDER_ID}">
												<button type="button" class="quantity-btn"
													data-menu-id="${item.MENU_ITEM_ID}"
													data-option-id="${item.ORDER_OPTION_ID}"
													data-order-id="${item.ORDER_ID}"
													onclick="increaseQuantity(this)">
													<i class="fas fa-plus"></i>
												</button>
											</div>

											<div class="item-price">
												<fmt:formatNumber
													value="${(item.MENU_PRICE + item.TOTAL_OPTION_PRICE) * (empty item.QUANTITY ? 1 : item.QUANTITY)}"
													type="number" />
												원
											</div>

											<form action="/userstore/deleteItemInCart" method="post"
												onsubmit="return deleteCheck()">
												<input type="hidden" name="menu_item_id"
													value="${item.MENU_ITEM_ID}" /> <input type="hidden"
													name="order_id" value="${item.ORDER_ID}" /> <input
													type="hidden" name="order_option_id"
													value="${item.ORDER_OPTION_ID}" />
												<button type="submit" class="delete-btn">
													<i class="fas fa-trash-alt"></i>
												</button>
											</form>
										</div>
									</div>
								</c:if>
							</c:forEach>
<<<<<<< HEAD
						</div>
=======
							<button type="submit" class="btn btn-submit">주문하기</button>
						</form>
>>>>>>> refs/remotes/origin/master
					</div>
				</div>

				<!-- 결제 요약 카드 -->
				<div class="summary-card">
					<div class="summary-header">
						<h2>
							<i class="fas fa-clipboard-list"></i> 주문 요약
						</h2>
					</div>
					<div class="summary-body">
						<div class="summary-row">
							<div class="summary-label">메뉴 금액</div>
							<div class="summary-value">
								<span id="menuPriceDisplay"> <c:set var="totalPrice"
										value="0" /> <c:set var="processedItems" value="" /> <c:forEach
										items="${cartDetails}" var="item">
										<c:set var="itemKey"
											value="${item.MENU_ITEM_ID}-${item.ORDER_OPTION_ID}" />
										<c:if test="${!fn:contains(processedItems, itemKey)}">
											<c:set var="itemQuantity"
												value="${empty item.QUANTITY ? 1 : item.QUANTITY}" />
											<c:set var="totalPrice"
												value="${totalPrice + ((item.MENU_PRICE + item.TOTAL_OPTION_PRICE) * itemQuantity)}" />
											<c:set var="processedItems"
												value="${processedItems},${itemKey}" />
										</c:if>
									</c:forEach> <fmt:formatNumber value="${totalPrice}" type="number" />원
								</span>
							</div>
						</div>
						<div class="summary-row">
							<div class="summary-label">배달팁</div>
							<div class="summary-value">
								<span id="deliveryFeeDisplay"> <fmt:formatNumber
										value="${deliveryFee}" type="number" />원
								</span>
							</div>
						</div>
						<div class="summary-total">
							<div class="summary-total-label">결제 예정 금액</div>
							<div class="summary-total-value">
								<span id="finalTotalPriceDisplay"> <fmt:formatNumber
										value="${totalPrice + deliveryFee}" type="number" />원
								</span> <input type="hidden" id="hiddenFinalTotalPrice"
									name="finalTotalPrice" value="${totalPrice + deliveryFee}">
							</div>
						</div>
					</div>
				</div>

				<!-- 하단 버튼 영역 -->
				<div class="action-buttons">
					<form action="/userstore/returnToStore" method="get"
						onsubmit="return checkLogin()"
						style="flex: 1; margin-right: 10px;">
						<input type="hidden" name="store_id"
							value="${cartDetails[0].STORE_ID}">
						<button type="submit" class="btn btn-outline btn-continue">
							<i class="fas fa-arrow-left"></i> 메뉴 추가하기
						</button>
					</form>

					<form action="/userStore/startOrder" method="get"
						onsubmit="return checkLogin()" style="flex: 2;">
						<input type="hidden" id="orderTotalPrice" name="totalPrice"
							value="${totalPrice}"> <input type="hidden"
							id="orderDeliveryFee" name="deliveryFee" value="${deliveryFee}">
						<input type="hidden" id="orderFinalTotalPrice"
							name="finalTotalPrice" value="${totalPrice + deliveryFee}">
						<input type="hidden" id="order_Id" name="order_Id"
							value="${cartDetails[0].ORDER_ID}">
						<c:forEach items="${cartDetails}" var="item" varStatus="status">
							<c:if
								test="${status.index == 0 || cartDetails[status.index-1].MENU_ITEM_ID != item.MENU_ITEM_ID || cartDetails[status.index-1].ORDER_OPTION_ID != item.ORDER_OPTION_ID}">
								<input type="hidden" name="selectedItems"
									value="${item.MENU_ITEM_ID}">
								<input type="hidden" name="itemQuantities"
									value="${empty item.QUANTITY ? 1 : item.QUANTITY}">
								<input type="hidden" name="orderOptionIds"
									value="${item.ORDER_OPTION_ID}">
							</c:if>
						</c:forEach>
						<button type="submit" class="btn btn-primary btn-checkout">
							<i class="fas fa-check-circle"></i> 주문하기
						</button>
					</form>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

	<script>
        // 로그인 상태를 확인하고 로그인 페이지로 리다이렉트하는 함수
        function checkLogin() {
            if (${loginUser == null}) {
                // 로그인되지 않은 경우
                alert('로그인이 필요한 서비스입니다.');
                window.location.href = '/user/loginForm';
                return false;
            }
            return true;
        }
        
        // 숫자에 천 단위 쉼표 추가하는 함수
        function formatNumberWithCommas(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        
        // 삭제 확인 함수
        function deleteCheck() {
            return confirm('선택한 메뉴를 장바구니에서 삭제하시겠습니까?');
        }
        
        // 개별 아이템 가격 업데이트 함수
        function updateItemPrice(quantityInput) {
            const cartItem = quantityInput.closest('.cart-item');
            
            // 숫자 형식으로 변환 보장
            const originalPrice = Number(cartItem.getAttribute('data-price'));
            const optionPrice = Number(cartItem.getAttribute('data-option-price') || 0);
            const quantity = Number(quantityInput.value);

            const calculatedPrice = (originalPrice + optionPrice) * quantity;

            const priceElement = cartItem.querySelector('.item-price');
            priceElement.textContent = formatNumberWithCommas(calculatedPrice) + '원';

            // 수량 데이터 속성 업데이트
            cartItem.setAttribute('data-quantity', quantity);
            
            // 모든 항목의 합계 업데이트
            updateTotalPrice();
        }
        
        // 서버에 장바구니 수량 업데이트 요청 보내는 함수
        function updateCartQuantity(menuItemId, quantity, orderId, orderOptionId) {
            // 로그인 상태 체크
            if (!checkLogin()) {
                return false;
            }
            
            // AJAX 요청
            fetch('/userstore/updateCartQuantity', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                    'menu_item_id': menuItemId,
                    'quantity': quantity,
                    'order_id': orderId,
                    'order_option_id': orderOptionId
                })
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('서버 응답 오류: ' + response.status);
                }
            })
            .then(data => {
                if (data.success) {
                    console.log("수량 업데이트 성공!");
                }
            })
            .catch(error => {
                console.error("AJAX 오류:", error);
            });
        }

        // 수량 증가 함수
        function increaseQuantity(button) {
            // 로그인 상태 체크
            if (!checkLogin()) {
                return false;
            }
            
            // 버튼에서 직접 데이터 가져오기
            const menuItemId = button.getAttribute('data-menu-id');
            const orderOptionId = button.getAttribute('data-option-id');
            const orderId = button.getAttribute('data-order-id');
            
            if (!menuItemId || !orderOptionId || !orderId) {
                console.error("필수 데이터가 없습니다:", { menuItemId, orderOptionId, orderId });
                return false;
            }
            
            const quantityInput = button.parentElement.querySelector('.quantity-input');
            const currentValue = parseInt(quantityInput.value);
            
            if (currentValue < 10) {
                // 수량 증가
                quantityInput.value = currentValue + 1;
                const newQuantity = currentValue + 1;
                
                // UI 업데이트
                updateItemPrice(quantityInput);
                
                // AJAX 요청 전송
                updateCartQuantity(menuItemId, newQuantity, orderId, orderOptionId);
            }
            
            return false; // 기본 이벤트 방지
        }

        // 수량 감소 함수
        function decreaseQuantity(button) {
            // 로그인 상태 체크
            if (!checkLogin()) {
                return false;
            }
            
            // 버튼에서 직접 데이터 가져오기
            const menuItemId = button.getAttribute('data-menu-id');
            const orderOptionId = button.getAttribute('data-option-id');
            const orderId = button.getAttribute('data-order-id');
            
            if (!menuItemId || !orderOptionId || !orderId) {
                console.error("필수 데이터가 없습니다:", { menuItemId, orderOptionId, orderId });
                return false;
            }
            
            const quantityInput = button.parentElement.querySelector('.quantity-input');
            const currentValue = parseInt(quantityInput.value);
            
            if (currentValue > 1) {
                // 수량 감소
                quantityInput.value = currentValue - 1;
                const newQuantity = currentValue - 1;
                
                // UI 업데이트
                updateItemPrice(quantityInput);
                
                // AJAX 요청 전송
                updateCartQuantity(menuItemId, newQuantity, orderId, orderOptionId);
            }
            
            return false; // 기본 이벤트 방지
        }
        
        // 수량 입력 필드 직접 변경 시 호출되는 함수
        function handleQuantityChange(input) {
            // 로그인 상태 체크
            if (!checkLogin()) {
                return false;
            }
            
            // 입력값 범위 검증 (1~10)
            let value = parseInt(input.value);
            if (isNaN(value) || value < 1) {
                value = 1;
                input.value = 1;
            } else if (value > 10) {
                value = 10;
                input.value = 10;
            }
            
            // 데이터 가져오기
            const menuItemId = input.getAttribute('data-menu-id');
            const orderOptionId = input.getAttribute('data-option-id');
            const orderId = input.getAttribute('data-order-id');
            
            if (!menuItemId || !orderOptionId || !orderId) {
                console.error("필수 데이터가 없습니다:", { menuItemId, orderOptionId, orderId });
                return;
            }
            
            // UI 업데이트
            updateItemPrice(input);
            
            // AJAX 요청 전송
            updateCartQuantity(menuItemId, value, orderId, orderOptionId);
        }
        
        // 총 가격 업데이트 함수
        function updateTotalPrice() {
            const cartItems = document.querySelectorAll('.cart-item');
            let totalPrice = 0;
            
            cartItems.forEach(item => {
                const itemPrice = Number(item.getAttribute('data-price'));
                const optionPrice = Number(item.getAttribute('data-option-price') || 0);
                const quantity = Number(item.querySelector('.quantity-input').value);
                
                totalPrice += (itemPrice + optionPrice) * quantity;
            });
            
            // 배달팁 (고정값 또는 서버에서 받아온 값)
            const deliveryFee = Number(document.getElementById('orderDeliveryFee').value || 0);
            const finalTotalPrice = totalPrice + deliveryFee;
            
            // 화면의 가격 정보 업데이트
            document.getElementById('menuPriceDisplay').innerText = formatNumberWithCommas(totalPrice) + '원';
            document.getElementById('finalTotalPriceDisplay').innerText = formatNumberWithCommas(finalTotalPrice) + '원';
            
            // 숨겨진 입력 필드 업데이트
            document.getElementById('hiddenFinalTotalPrice').value = finalTotalPrice;
            document.getElementById('orderTotalPrice').value = totalPrice;
            document.getElementById('orderFinalTotalPrice').value = finalTotalPrice;
            
            // 수량 입력 필드 값 업데이트
            cartItems.forEach(item => {
                const menuId = item.getAttribute('data-menu-id');
                const optionId = item.getAttribute('data-order-option-id');
                const quantity = item.querySelector('.quantity-input').value;
                
                // 해당 메뉴 아이템의 수량 입력 필드 찾기
                const quantityInputs = document.querySelectorAll(`input[name="itemQuantities"]`);
                const menuInputs = document.querySelectorAll(`input[name="selectedItems"]`);
                const optionInputs = document.querySelectorAll(`input[name="orderOptionIds"]`);
                
                for (let i = 0; i < menuInputs.length; i++) {
                    if (menuInputs[i].value === menuId && optionInputs[i].value === optionId) {
                        quantityInputs[i].value = quantity;
                        break;
                    }
                }
            });
        }
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            // 수량 입력 필드에 change 이벤트 리스너 추가
            const quantityInputs = document.querySelectorAll('.quantity-input');
            quantityInputs.forEach(input => {
                input.addEventListener('change', function() {
                    handleQuantityChange(this);
                });
            });
            
            // 초기 총 가격 계산
            updateTotalPrice();
        });
    </script>
</body>
</html>