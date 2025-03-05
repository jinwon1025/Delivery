<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="auth-container">
	<div class="auth-header">
		<h2 class="auth-title">사업자 회원가입</h2>
		<p class="auth-subtitle">금베달리스트에 매장을 등록하고 사업을 확장하세요</p>
	</div>

	<div class="auth-form">
		<form:form action="/owner/insertRegister" method="post"
			modelAttribute="owner" name="frm" onsubmit="return totalcheck()"
			enctype="multipart/form-data">
			<form:hidden path="idchecked" />

			<div class="form-group">
				<label for="owner_id" class="form-label">사업자 아이디</label>
				<div class="d-flex">
					<form:input path="owner_id" id="owner_id" class="form-control"
						placeholder="아이디 입력 (5~15자)" />
					<button type="button" class="btn btn-outline-gold ml-2"
						onclick="idcheck()">중복확인</button>
				</div>
				<small class="text-muted">5자 이상, 15자 이내로 입력하세요</small>
				<div class="text-error mt-1">
					<form:errors path="owner_id" />
				</div>
			</div>

			<div class="form-group">
				<label for="owner_password" class="form-label">비밀번호</label>
				<form:password path="owner_password" id="owner_password"
					class="form-control" placeholder="비밀번호 입력 (8자 이상 영문+숫자)" />
				<small class="text-muted">8자 이상의 영문, 숫자 조합으로 입력하세요</small>
				<div class="text-error mt-1">
					<form:errors path="owner_password" />
				</div>
			</div>

			<div class="form-group">
				<label for="passwordcheck" class="form-label">비밀번호 확인</label> <input
					type="password" id="passwordcheck" name="passwordcheck"
					class="form-control" placeholder="비밀번호를 다시 입력해주세요" />
				<div id="password-error-message" class="text-error mt-1"></div>
			</div>

			<div class="form-group">
				<label for="owner_name" class="form-label">사업자명</label>
				<form:input path="owner_name" id="owner_name" class="form-control"
					placeholder="사업자명을 입력해주세요" />
				<div class="text-error mt-1">
					<form:errors path="owner_name" />
				</div>
			</div>

			<div class="form-group">
				<label for="owner_email" class="form-label">이메일</label>
				<form:input path="owner_email" id="owner_email" class="form-control"
					type="email" placeholder="이메일을 입력해주세요" />
				<div class="text-error mt-1">
					<form:errors path="owner_email" />
				</div>
			</div>

			<div class="form-group">
				<label for="owner_phone" class="form-label">전화번호</label>
				<form:input path="owner_phone" id="owner_phone" class="form-control"
					placeholder="'-' 없이 숫자만 입력해주세요" />
				<div class="text-error mt-1">
					<form:errors path="owner_phone" />
				</div>
			</div>

			<div class="form-group">
				<label class="form-label">프로필 이미지</label>
				<div class="custom-file-upload">
					<input type="file" name="image" id="profile-image"
						class="form-control" /> <small class="text-muted">프로필
						이미지는 선택사항입니다</small>
				</div>
			</div>

			<div class="form-group mt-4">
				<button type="submit" class="btn-auth">가입하기</button>
			</div>
		</form:form>
	</div>

	<div class="auth-footer">
		<p>
			이미 계정이 있으신가요? <a href="<c:url value='/owner/goLogin'/>"
				class="auth-link">로그인</a>
		</p>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function idcheck() {
    if(document.frm.owner_id.value=='') {
        alert("아이디를 입력해야 합니다.");
        document.frm.owner_id.focus();
        return false;
    } else {
        if(document.frm.owner_id.value.length < 5 || document.frm.owner_id.value.length > 15) {
            alert("계정은 5자 이상, 15자 이내로 입력하세요.");
            document.frm.owner_id.focus();
            return false;
        }
    }
    var url = "/owner/idcheck?owner_id="+document.frm.owner_id.value;
    window.open(url, "_blank_", "width=450, height=200");
}

function totalcheck() {
    if(document.frm.owner_id.value=='') {
        alert("아이디를 입력해야 합니다.");
        document.frm.owner_id.focus();
        return false;
    }
    
    if(document.frm.idchecked.value=='') {
        alert("아이디 중복검사를 해야합니다.");
        return false;
    }
    
    if(document.frm.owner_password.value=='') {
        alert("비밀번호를 입력해야합니다.");
        document.frm.owner_password.focus();
        return false;
    }
    
    if(document.frm.owner_password.value !== document.frm.passwordcheck.value) {
        alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        document.frm.passwordcheck.focus();
        return false;
    }
    
    return true;
}

// 비밀번호 확인 실시간 검사
$(document).ready(function() {
    const passwordField = $('#owner_password');
    const passwordCheckField = $('#passwordcheck');
    const errorMessage = $('#password-error-message');
    const submitButton = $('button[type="submit"]');

    passwordCheckField.on('input', function() {
        if (passwordField.val() !== passwordCheckField.val()) {
            errorMessage.text('비밀번호가 일치하지 않습니다.').show();
            submitButton.prop('disabled', true);
        } else {
            errorMessage.hide();
            submitButton.prop('disabled', false);
        }
    });
});
</script>