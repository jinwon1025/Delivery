<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>매장 등록 - 금베달리스트 사업자</title>

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
			<div class="store-registration">
				<h2 class="step-title">매장 등록</h2>
				<p class="step-subtitle">아래 양식에 맞게 매장 정보를 입력해주세요.</p>

				<form:form action="/store/register" method="post"
					modelAttribute="store" enctype="multipart/form-data" name="frm"
					onsubmit="return totalcheck()">
					<form:hidden path="idchecked" />

					<div class="form-section">
						<h3 class="form-section-title">기본 정보</h3>

						<div class="form-row">
							<div class="form-col">
								<div class="form-group">
									<label class="form-label" for="store_id">매장 아이디 (5자 이상
										15자 이하)</label>
									<div class="d-flex">
										<form:input path="store_id" cssClass="form-control" />
										<button type="button" class="btn btn-primary ml-2"
											onclick="idcheck()">중복검사</button>
									</div>
									<form:errors path="store_id" cssClass="text-error" />
									<form:errors path="idchecked" cssClass="text-error" />
								</div>

								<div class="form-group">
									<label class="form-label" for="store_name">매장명</label>
									<form:input path="store_name" cssClass="form-control" />
									<form:errors path="store_name" cssClass="text-error" />
								</div>

								<div class="form-group">
									<label class="form-label" for="store_address">주소</label>
									<form:input path="store_address" cssClass="form-control" />
									<form:errors path="store_address" cssClass="text-error" />
								</div>
							</div>

							<div class="form-col">
								<div class="form-group">
									<label class="form-label" for="store_phone">매장 전화번호</label>
									<form:input path="store_phone" cssClass="form-control" />
									<form:errors path="store_phone" cssClass="text-error" />
								</div>

								<div class="form-group">
									<label class="form-label" for="store_openHour">영업 시간</label>
									<form:input path="store_openHour" cssClass="form-control"
										placeholder="예: 09:00 - 22:00" />
									<form:errors path="store_openHour" cssClass="text-error" />
								</div>

								<div class="form-group">
									<label class="form-label" for="main_category_Id">메인
										카테고리</label>
									<form:select path="main_category_Id" cssClass="form-select">
										<c:forEach var="category" items="${maincategoryList}">
											<form:option value="${category.main_category_id}">${category.main_category_name}</form:option>
										</c:forEach>
									</form:select>
								</div>
							</div>
						</div>
					</div>

					<div class="form-section">
						<h3 class="form-section-title">배달 및 주문 정보</h3>

						<div class="form-row">
							<div class="form-col">
								<div class="form-group">
									<label class="form-label" for="last_price">최소 주문 금액</label>
									<form:input path="last_price" cssClass="form-control"
										type="number" placeholder="원 단위로 입력" />
									<form:errors path="last_price" cssClass="text-error" />
								</div>

								<div class="form-group">
									<label class="form-label" for="delivery_fee">배달 요금</label>
									<form:input path="delivery_fee" cssClass="form-control"
										type="number" placeholder="원 단위로 입력" />
									<form:errors path="delivery_fee" cssClass="text-error" />
								</div>
							</div>

							<div class="form-col">
								<div class="form-group">
									<label class="form-label" for="made_in">원산지 정보</label>
									<form:textarea path="made_in" cssClass="form-control" rows="4"
										placeholder="식재료 원산지 정보를 입력하세요" />
									<form:errors path="made_in" cssClass="text-error" />
								</div>
							</div>
						</div>
					</div>

					<div class="form-section">
						<h3 class="form-section-title">매장 이미지</h3>

						<div class="form-group">
							<label class="form-label" for="image">매장 프로필 이미지</label> <input
								type="file" name="image" id="image" class="form-control"
								accept="image/*" onchange="previewImage(this)">
						</div>

						<div class="preview-container mt-3" id="image-preview-container"
							style="display: none;">
							<img id="preview-image" src="#" alt="매장 이미지 미리보기"
								class="rounded shadow-sm"
								style="max-width: 300px; max-height: 200px;">
						</div>
					</div>

					<div class="form-actions">
						<button type="button" class="btn btn-white"
							onclick="history.back()">취소</button>
						<button type="submit" class="btn btn-primary">매장 등록</button>
					</div>
				</form:form>
			</div>
		</div>
	</main>


	<!-- JavaScript -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
        // 이미지 미리보기
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    document.getElementById('preview-image').src = e.target.result;
                    document.getElementById('image-preview-container').style.display = 'block';
                }
                
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        // ID 중복 검사
        function idcheck() {
            if (document.frm.store_id.value == '') {
                alert("아이디를 입력하세요.");
                document.frm.store_id.focus();
                return false;
            } else {
                if (document.frm.store_id.value.length < 5 || document.frm.store_id.value.length > 15) {
                    alert("아이디는 5자 이상, 15자 이하로 입력하세요.");
                    document.frm.store_id.focus();
                    return false;
                }
            }
            var url = "/store/idcheck?store_id=" + document.frm.store_id.value;
            window.open(url, "_blank_", "width=450, height=200");
        }

        // 폼 제출 전 확인
        function totalcheck() {
            // 아이디가 비어있거나 공백만 있는 경우는 검사하지 않고 @NotBlank 메시지가 표시되도록 함
            if (document.frm.store_id.value.trim() === '') {
                return true; // 폼 제출을 허용하여 서버 측 @NotBlank 검증이 동작하도록 함
            }

            // 아이디가 입력되어 있는데 중복검사를 하지 않은 경우
            if (document.frm.idchecked.value == '') {
                alert("아이디 중복검사를 해야합니다.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>