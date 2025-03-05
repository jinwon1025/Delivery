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
<title>옵션 수정 - 금베달리스트 사업자</title>

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
			<div class="card">
				<div class="card-header d-flex align-items-center">
					<div class="d-flex align-items-center">
						<c:choose>
							<c:when test="${not empty menuInfo.image_name}">
								<div class="mr-3"
									style="width: 60px; height: 60px; overflow: hidden; border-radius: var(--border-radius);">
									<img
										src="${pageContext.request.contextPath}/upload/menuItemProfile/${menuInfo.image_name}"
										alt="${menuInfo.menu_name}"
										style="width: 100%; height: 100%; object-fit: cover;"
										onerror="this.src='${pageContext.request.contextPath}/image/noImage.png'">
								</div>
							</c:when>
							<c:otherwise>
								<div
									class="mr-3 d-flex align-items-center justify-content-center bg-gray-200"
									style="width: 60px; height: 60px; border-radius: var(--border-radius);">
									<i class="fas fa-utensils text-gray-500"></i>
								</div>
							</c:otherwise>
						</c:choose>
						<div>
							<h3 class="mb-1 font-medium">${menuInfo.menu_name}</h3>
							<p class="text-primary">${menuInfo.price}원</p>
						</div>
					</div>
				</div>

				<div class="card-body">
					<p class="text-gray-600 mb-4">${menuInfo.content}</p>

					<c:forEach var="category" items="${optionList}">
						<div class="card mb-4">
							<div class="card-header">
								<h4 class="card-title">${category.option_group_name}</h4>
							</div>
							<div class="card-body">
								<c:forEach var="optionSet" items="${subOptionList}">
									<c:if
										test="${category.option_group_id eq optionSet.option_group_id}">
										<div class="border-bottom py-3">
											<c:choose>
												<c:when
													test="${target != null && optionSet.option_id eq target.option_id}">
													<form action="/store/updateSubOption" method="post"
														class="d-flex align-items-center justify-content-between"
														onsubmit="return updateCheck()">
														<div class="d-flex">
															<div class="form-group mr-2 mb-0">
																<input type="text" name="option_name" id="option_name"
																	value="${optionSet.option_name}" class="form-control"
																	placeholder="옵션명" />
															</div>
															<div class="form-group mb-0">
																<input type="text" name="option_price" id="option_price"
																	value="${optionSet.option_price}" class="form-control"
																	placeholder="가격" />
															</div>
														</div>
														<div>
															<input type="hidden" name="option_group_id"
																value="${category.option_group_id}" /> <input
																type="hidden" name="option_id"
																value="${optionSet.option_id}" />
															<button type="submit" class="btn btn-primary">수정하기</button>
															<button type="button" class="btn btn-white"
																onclick="history.back()">취소</button>
														</div>
													</form>
												</c:when>
												<c:otherwise>
													<div
														class="d-flex justify-content-between align-items-center">
														<div>
															<span class="font-medium">${optionSet.option_name}</span>
															<span class="ml-3 text-primary">+${optionSet.option_price}원</span>
														</div>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</c:forEach>

					<!-- 뒤로가기 버튼 -->
					<div class="d-flex justify-content-center mt-4">
						<a href="javascript:history.back()" class="btn btn-outline-gold">
							<i class="fas fa-arrow-left mr-2"></i>옵션 목록으로 돌아가기
						</a>
					</div>
				</div>
			</div>
		</div>
	</main>


	<!-- JavaScript -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
        function updateCheck() {
            const newOptionName = document.getElementById('option_name').value;
            const newOptionPrice = document.getElementById('option_price').value;
            
            if (newOptionName.trim() === '') {
                alert("옵션명을 입력해주세요.");
                return false;
            }
            
            if (newOptionPrice.trim() === '') {
                alert("옵션 가격을 입력해주세요.");
                return false;
            }
            
            // 숫자만 입력되었는지 확인
            if(isNaN(newOptionPrice)) {
                alert("옵션 가격은 숫자만 입력해주세요.");
                return false;
            }
            
            if (confirm("정말로 수정하시겠습니까?")) {
                return true;
            } else {
                return false;
            }
        }
    </script>
</body>
</html>