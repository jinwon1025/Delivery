<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="auth-container">
    <div class="auth-header">
        <h2 class="auth-title">회원가입</h2>
        <p class="auth-subtitle">금베달리스트 회원이 되어 다양한 혜택을 누려보세요</p>
    </div>

    <div class="auth-form">
        <form:form action="/user/insertRegister" method="post" modelAttribute="user" name="frm" 
                   onsubmit="return totalcheck()" enctype="multipart/form-data" class="mx-auto">
            <form:hidden path="idchecked" />

            <div class="form-group">
                <label for="user_id" class="form-label">아이디</label>
                <div class="d-flex">
                    <form:input path="user_id" id="user_id" class="form-control" placeholder="아이디 입력 (5~15자)" />
                    <button type="button" class="btn btn-outline-gold ml-2" onclick="idcheck()">중복확인</button>
                </div>
                <small class="text-muted">5자 이상, 15자 이내로 입력하세요</small>
                <div class="text-error mt-1"><form:errors path="user_id" /></div>
            </div>

            <div class="form-group">
                <label for="password" class="form-label">비밀번호</label>
                <form:password path="password" id="password" class="form-control" 
                             placeholder="비밀번호 입력 (8자 이상 영문+숫자)" />
                <small class="text-muted">8자 이상의 영문, 숫자 조합으로 입력하세요</small>
                <div class="text-error mt-1"><form:errors path="password" /></div>
            </div>

            <div class="form-group">
                <label for="passwordcheck" class="form-label">비밀번호 확인</label>
                <form:password path="passwordcheck" id="passwordcheck" class="form-control" 
                             placeholder="비밀번호를 다시 입력해주세요" />
                <div id="password-error-message" class="text-error mt-1"></div>
                <div class="text-error mt-1"><form:errors path="passwordcheck" /></div>
            </div>

            <div class="form-group">
                <label for="user_name" class="form-label">이름</label>
                <form:input path="user_name" id="user_name" class="form-control" 
                          placeholder="이름을 입력해주세요" />
                <div class="text-error mt-1"><form:errors path="user_name" /></div>
            </div>

            <div class="form-group">
                <label class="form-label">전화번호</label>
                <div class="d-flex align-items-center">
                    <form:select path="phone1" class="form-select mr-2" style="width: 80px;">
                        <option value="010">010</option>
                        <option value="02">02</option>
                        <option value="031">031</option>
                        <option value="032">032</option>
                        <option value="033">033</option>
                    </form:select>
                    -
                    <form:input path="phone2" id="phone2" maxlength="4" class="form-control mx-2" style="width: 80px;" />
                    -
                    <form:input path="phone3" id="phone3" maxlength="4" class="form-control ml-2" style="width: 80px;" />
                </div>
                <div class="text-error mt-1">
                    <form:errors path="phone2" />
                    <form:errors path="phone3" />
                </div>
            </div>

            <div class="form-group">
                <label for="email" class="form-label">이메일</label>
                <form:input path="email" id="email" class="form-control" type="email" 
                          placeholder="이메일을 입력해주세요" />
                <div class="text-error mt-1"><form:errors path="email" /></div>
            </div>

            <div class="form-group">
                <label for="birth" class="form-label">생년월일</label>
                <form:input path="birth" id="birth" type="date" class="form-control" 
                          placeholder="생일을 선택하세요" />
                <div class="text-error mt-1"><form:errors path="birth" /></div>
            </div>

            <div class="form-group">
                <label for="user_address" class="form-label">주소</label>
                <form:input path="user_address" id="user_address" class="form-control" 
                          placeholder="주소를 입력해주세요" />
                <div class="text-error mt-1"><form:errors path="user_address" /></div>
            </div>

            <div class="form-group">
                <label class="form-label">프로필 이미지</label>
                <div class="custom-file-upload">
                    <input type="file" name="image" id="profile-image" class="form-control" />
                    <small class="text-muted">프로필 이미지는 선택사항입니다</small>
                </div>
            </div>

            <div class="form-group mt-4">
                <button type="submit" class="btn-auth">가입하기</button>
            </div>
        </form:form>
    </div>

    <div class="auth-footer">
        <p>이미 계정이 있으신가요? <a href="<c:url value='/user/index'/>" class="auth-link">로그인</a></p>
    </div>
</div>

<script>
function idcheck() {
    if (document.frm.user_id.value == '') {
        alert("아이디를 입력해야 합니다.");
        document.frm.user_id.focus();
        return false;
    } else {
        if (document.frm.user_id.value.length < 5 || document.frm.user_id.value.length > 15) {
            alert("계정은 5자 이상, 15자 이내로 입력하세요.");
            document.frm.user_id.focus();
            return false;
        }
    }
    var url = "/user/idcheck?user_id=" + document.frm.user_id.value;
    window.open(url, "_blank_", "width=450, height=200");
}

function totalcheck() {
    if (document.frm.user_id.value == '') {
        alert("아이디를 입력해야 합니다.");
        document.frm.user_id.focus();
        return false;
    }

    if (document.frm.idchecked.value == '') {
        alert("아이디 중복검사를 해야합니다.");
        return false;
    }

    if (document.frm.password.value == '') {
        alert("비밀번호를 입력해야합니다.");
        document.frm.password.focus();
        return false;
    }
    
    if (document.frm.password.value !== document.frm.passwordcheck.value) {
        alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        document.frm.passwordcheck.focus();
        return false;
    }
    
    return true;
}

// 비밀번호 확인 실시간 검사
$(document).ready(function() {
    const passwordField = $('#password');
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