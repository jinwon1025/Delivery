<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메뉴 옵션 관리 - 금베달리스트 사업자</title>

<!-- 공통 CSS 파일 -->
<link rel="stylesheet" href="<c:url value='/css/common/reset.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/common/typography.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/layout.css'/>">
<link rel="stylesheet" href="<c:url value='/css/common/utilities.css'/>">

<!-- 사업자 CSS 파일 -->
<link rel="stylesheet"
	href="<c:url value='/css/store/store-layout.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/store/store-components.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/store/store-pages.css'/>">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- Google Fonts - Noto Sans KR -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap">
</head>
<body>


	<!-- 메인 컨텐츠 -->
	<main class="main-content">
		<div class="store-container">
			<div class="section-title mb-4">
				<h2>메뉴 옵션 관리</h2>
			</div>

			<div class="card mb-4">
				<!-- 메뉴 정보 헤더 -->
				<div class="card-header d-flex align-items-center">
					<div class="d-flex align-items-center">
						<c:choose>
							<c:when test="${not empty menuInfo.image_name}">
								<div class="mr-3"
									style="width: 60px; height: 60px; overflow: hidden; border-radius: var(--border-radius);">
									<img
										src="${pageContext.request.contextPath}/upload/menuItemProfile/${menuInfo.image_name}"
										alt="${menuInfo.menu_name}"
										style="width: 100%; height: 100%; object-fit: cover;">
								</div>
							</c:when>
							<c:otherwise>
								<div
									class="mr-3 d-flex align-items-center justify-content-center bg-gray-200"
									style="width: 60px; height: 60px; border-radius: var(--border-radius);">
									<i class="fas fa-image text-gray-500 fa-2x"></i>
								</div>
							</c:otherwise>
						</c:choose>
						<div>
							<h3 class="mb-1 font-medium">${menuInfo.menu_name}</h3>
							<p class="text-primary font-medium">${menuInfo.price}원</p>
						</div>
					</div>
				</div>

				<div class="card-body">
					<p class="text-gray-600 mb-3">${menuInfo.content}</p>

					<!-- 옵션 카테고리 추가 -->
					<div class="card mb-4">
						<div class="card-header">
							<h4 class="card-title">옵션 카테고리 추가</h4>
						</div>
						<div class="card-body">
							<form id="addOptionCategoryForm" action="/store/addOption"
								method="post" class="d-flex align-items-center flex-wrap"
								onsubmit="return categoryCheck(this)">
								<input type="hidden" name="menu_category_id"
									value="${menuInfo.menu_category_id}" />
								<div class="form-group mr-3 mb-0" style="flex: 1;">
									<input type="text" name="category_name"
										placeholder="카테고리 이름 (예: 소스 선택)" class="form-control">
								</div>
								<div class="d-flex align-items-center mr-3">
									<div class="form-check mr-3">
										<input type="radio" name="selection_type" value="single"
											id="single-selection" class="form-check-input"> <label
											for="single-selection" class="form-check-label">단일 선택</label>
									</div>
									<div class="form-check">
										<input type="radio" name="selection_type" value="duplicate"
											id="multiple-selection" class="form-check-input"> <label
											for="multiple-selection" class="form-check-label">중복
											선택</label>
									</div>
								</div>
								<button type="submit" class="btn btn-primary">카테고리 추가</button>
							</form>
						</div>
					</div>

					<!-- 카테고리 목록 -->
					<c:if test="${not empty optionList}">
						<c:forEach var="category" items="${optionList}">
							<div class="card mb-3">
								<div
									class="card-header d-flex justify-content-between align-items-center">
									<div>
										<h4 class="card-title d-inline-block">${category.option_group_name}</h4>
										<span
											class="badge ml-2 p-1 px-2 rounded-pill bg-gray-200 text-gray-700 text-xs">
											${category.selection_type eq 'single' ? '단일 선택' : '중복 선택'} </span>
									</div>
									<div>
										<form action="/store/goUpdateOptionCategory" method="get"
											class="d-inline-block mr-2">
											<input type="hidden" name="option_group_id"
												value="${category.option_group_id}" />
											<button type="submit" class="btn btn-sm btn-primary">수정</button>
										</form>
										<form action="/store/deleteOptionCategory" method="post"
											class="d-inline-block"
											onsubmit="return deleteOptionCategory()">
											<input type="hidden" name="option_group_id"
												value="${category.option_group_id}" />
											<button type="submit" class="btn btn-sm btn-outline-gold">삭제</button>
										</form>
									</div>
								</div>

								<div class="card-body">
									<!-- 하위 옵션 목록 -->
									<c:forEach var="optionSet" items="${subOptionList}">
										<c:if
											test="${category.option_group_id == optionSet.option_group_id}">
											<div
												class="d-flex align-items-center justify-content-between p-2 border-bottom">
												<div>
													<span class="font-medium">${optionSet.option_name}</span> <span
														class="text-primary ml-3">+${optionSet.option_price}원</span>
												</div>
												<div>
													<form action="/store/goUpdateSubOption" method="get"
														class="d-inline-block mr-2">
														<input type="hidden" name="option_group_id"
															value="${category.option_group_id}" /> <input
															type="hidden" name="option_id"
															value="${optionSet.option_id}" />
														<button type="submit" class="btn btn-sm btn-primary">수정</button>
													</form>
													<form action="/store/deleteSubOption" method="post"
														class="d-inline-block" onsubmit="return deleteCheck()">
														<input type="hidden" name="option_group_id"
															value="${category.option_group_id}" /> <input
															type="hidden" name="option_id"
															value="${optionSet.option_id}" />
														<button type="submit" class="btn btn-sm btn-outline-gold">삭제</button>
													</form>
												</div>
											</div>
										</c:if>
									</c:forEach>

									<!-- 하위 옵션 추가 폼 -->
									<div class="mt-3 pt-3 border-top">
										<form id="addSubOptionForm_${category.option_group_id}"
											action="/store/addSubOption" method="post"
											class="d-flex align-items-center"
											onsubmit="return valueCheck(this)">
											<input type="hidden" name="option_group_id"
												value="${category.option_group_id}" />
											<div class="form-group mr-2 mb-0" style="flex: 2;">
												<input type="text" name="option_name" placeholder="하위 옵션 이름"
													class="form-control">
											</div>
											<div class="form-group mr-2 mb-0" style="flex: 1;">
												<input type="text" name="option_price" placeholder="추가 가격"
													class="form-control">
											</div>
											<button type="submit" class="btn btn-primary">하위 옵션
												추가</button>
										</form>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:if>

					<!-- 옵션이 없을 경우 메시지 -->
					<c:if test="${empty optionList}">
						<div class="text-center py-5">
							<i class="fas fa-info-circle fa-3x text-gray-400 mb-3"></i>
							<p class="text-gray-600">옵션 카테고리가 없습니다. 새 옵션 카테고리를 추가해보세요.</p>
						</div>
					</c:if>
				</div>
			</div>

			<!-- 뒤로가기 버튼 -->
			<div class="d-flex justify-content-center mt-3">
				<a href="javascript:history.back()" class="btn btn-outline-gold">
					<i class="fas fa-arrow-left mr-2"></i>메뉴 목록으로 돌아가기
				</a>
			</div>
		</div>
	</main>


	<!-- JavaScript -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		function deleteCheck() {
			return confirm("정말로 이 옵션을 삭제하시겠습니까?");
		}

		function deleteOptionCategory() {
			return confirm("이 옵션 카테고리와 관련된 모든 하위 옵션이 삭제됩니다.\n정말로 삭제하시겠습니까?");
		}

		function categoryCheck(form) {
			const categoryNameInput = form
					.querySelector('[name="category_name"]');
			const singleRadio = document.getElementById('single-selection');
			const multipleRadio = document.getElementById('multiple-selection');

			if (!categoryNameInput || categoryNameInput.value.trim() === '') {
				alert("카테고리명을 입력해주세요.");
				if (categoryNameInput)
					categoryNameInput.focus();
				return false;
			}

			if (!singleRadio.checked && !multipleRadio.checked) {
				alert("단일선택 또는 중복선택 중 하나를 선택해주세요.");
				return false;
			}

			// 기존 카테고리 이름들과 비교
			const existingCategories = [];

			// 여기에 JSTL로 기존 카테고리를 JavaScript 배열에 추가
			<c:forEach var="category" items="${optionList}">
			existingCategories.push("${category.option_group_name}");
			</c:forEach>

			// 중복 체크
			if (existingCategories.includes(categoryNameInput.value.trim())) {
				alert("이미 존재하는 카테고리 이름입니다. 다른 이름을 입력해주세요.");
				categoryNameInput.focus();
				return false;
			}

			return true;
		}
		function categoryCheck(form) {
			const categoryNameInput = form
					.querySelector('[name="category_name"]');
			const singleRadio = document.getElementById('single-selection');
			const multipleRadio = document.getElementById('multiple-selection');

			if (!categoryNameInput || categoryNameInput.value.trim() === '') {
				alert("카테고리명을 입력해주세요.");
				if (categoryNameInput)
					categoryNameInput.focus();
				return false;
			}

			if (!singleRadio.checked && !multipleRadio.checked) {
				alert("단일선택 또는 중복선택 중 하나를 선택해주세요.");
				return false;
			}

			// 기존 카테고리 이름들과 비교
			const existingCategories = [];

			// 여기에 JSTL로 기존 카테고리를 JavaScript 배열에 추가
			<c:forEach var="category" items="${optionList}">
			existingCategories.push("${category.option_group_name}");
			</c:forEach>

			// 중복 체크
			if (existingCategories.includes(categoryNameInput.value.trim())) {
				alert("이미 존재하는 카테고리 이름입니다. 다른 이름을 입력해주세요.");
				categoryNameInput.focus();
				return false;
			}

			return true;
		}

		function valueCheck(form) {
			const optionNameInput = form.querySelector('[name="option_name"]');
			const optionPriceInput = form
					.querySelector('[name="option_price"]');

			if (!optionNameInput || optionNameInput.value.trim() === '') {
				alert("옵션명을 입력해주세요.");
				if (optionNameInput)
					optionNameInput.focus();
				return false;
			}

			if (!optionPriceInput || optionPriceInput.value.trim() === '') {
				alert("옵션 가격을 입력해주세요.");
				if (optionPriceInput)
					optionPriceInput.focus();
				return false;
			}

			// 숫자만 입력되었는지 확인
			if (isNaN(optionPriceInput.value)) {
				alert("옵션 가격은 숫자만 입력해주세요.");
				optionPriceInput.focus();
				return false;
			}

			return true;
		}
	</script>
</body>
</html>