<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	/* 결제 비밀번호 폼 스타일 */
	.pay-password-form {
	    max-width: 500px;
	    margin: 0 auto;
	}
	
	.password-input-container {
	    display: flex;
	    gap: 10px;
	    margin-top: 8px;
	}
	
	.password-input-container input {
	    width: 50px;
	    height: 50px;
	    text-align: center;
	    font-size: 18px;
	    border-radius: 8px;
	    background-color: #f8f9fa;
	    border: 1px solid #dee2e6;
	    transition: all 0.2s ease;
	}
	
	.password-input-container input:focus {
	    border-color: #3f51b5;
	    box-shadow: 0 0 0 3px rgba(63, 81, 181, 0.1);
	    background-color: #fff;
	}
	
	/* 비밀번호 필드에 에러가 있을 때 */
	.password-input-container.is-invalid input {
	    border-color: #dc3545;
	}
	
	/* 애니메이션 효과 */
	@keyframes shake {
	    0%, 100% { transform: translateX(0); }
	    10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
	    20%, 40%, 60%, 80% { transform: translateX(5px); }
	}
	
	.password-input-container.shake {
	    animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both;
	}
	
	.alert {
	    border-radius: 10px;
	    padding: 15px;
	}
	
	.alert-info {
	    background-color: #e3f2fd;
	    border-color: #bbdefb;
	    color: #0d47a1;
	}
	
	.alert-success {
	    background-color: #e8f5e9;
	    border-color: #c8e6c9;
	    color: #2e7d32;
	}
	
	.btn-outline-primary {
	    color: #3f51b5;
	    border-color: #3f51b5;
	}
	
	.btn-outline-primary:hover {
	    background-color: #3f51b5;
	    color: white;
	}
	
	.btn-outline-secondary {
	    color: #6c757d;
	    border-color: #6c757d;
	}
	
	.btn-outline-secondary:hover {
	    background-color: #6c757d;
	    color: white;
	}
</style>
</head>
<body>
<div class="card mt-4">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h3 class="card-title mb-0">결제 비밀번호 관리</h3>
        <div class="card-subtitle text-muted">
            <small>결제 시 추가 인증을 위한 6자리 비밀번호입니다</small>
        </div>
    </div>
    <div class="card-body">
		<c:if test="${not empty errorMsg}">
		    <div class="alert alert-danger mb-4">
		        <i class="fas fa-exclamation-circle me-2"></i>
		        ${errorMsg}
		    </div>
		</c:if>
		<c:if test="${not empty successMsg}">
		    <div class="alert alert-success mb-4">
		        <i class="fas fa-check-circle me-2"></i>
		        ${successMsg}
		    </div>
		</c:if>
        <c:choose>
            <c:when test="${empty payPassword}">
                <!-- 결제 비밀번호가 없는 경우 -->
                <div class="alert alert-info mb-4">
                    <i class="fas fa-info-circle me-2"></i>
                    결제 비밀번호를 등록하면 결제 시 추가 보안을 설정할 수 있습니다.
                </div>
                
                <form action="${pageContext.request.contextPath}/user/registerPayPassword" method="post" 
                      id="payPasswordForm" class="pay-password-form">
                    <div class="form-group mb-4">
                        <label for="newPayPassword">새 결제 비밀번호 (6자리)</label>
                        <div class="password-input-container">
                            <input type="password" maxlength="1" class="form-control pay-password-digit" 
                                   data-index="0" pattern="[0-9]" inputmode="numeric" required>
                            <input type="password" maxlength="1" class="form-control pay-password-digit" 
                                   data-index="1" pattern="[0-9]" inputmode="numeric" required>
                            <input type="password" maxlength="1" class="form-control pay-password-digit" 
                                   data-index="2" pattern="[0-9]" inputmode="numeric" required>
                            <input type="password" maxlength="1" class="form-control pay-password-digit" 
                                   data-index="3" pattern="[0-9]" inputmode="numeric" required>
                            <input type="password" maxlength="1" class="form-control pay-password-digit" 
                                   data-index="4" pattern="[0-9]" inputmode="numeric" required>
                            <input type="password" maxlength="1" class="form-control pay-password-digit" 
                                   data-index="5" pattern="[0-9]" inputmode="numeric" required>
                            <input type="hidden" name="payPassword" id="payPasswordValue">
                        </div>
                    </div>
                    
                    <div class="form-group mb-4">
                        <label for="confirmPayPassword">비밀번호 확인</label>
                        <div class="password-input-container">
                            <input type="password" maxlength="1" class="form-control confirm-password-digit" 
                                   data-index="0" pattern="[0-9]" inputmode="numeric" required>
                            <input type="password" maxlength="1" class="form-control confirm-password-digit" 
                                   data-index="1" pattern="[0-9]" inputmode="numeric" required>
                            <input type="password" maxlength="1" class="form-control confirm-password-digit" 
                                   data-index="2" pattern="[0-9]" inputmode="numeric" required>
                            <input type="password" maxlength="1" class="form-control confirm-password-digit" 
                                   data-index="3" pattern="[0-9]" inputmode="numeric" required>
                            <input type="password" maxlength="1" class="form-control confirm-password-digit" 
                                   data-index="4" pattern="[0-9]" inputmode="numeric" required>
                            <input type="password" maxlength="1" class="form-control confirm-password-digit" 
                                   data-index="5" pattern="[0-9]" inputmode="numeric" required>
                        </div>
                        <div class="invalid-feedback" id="password-mismatch">
                            비밀번호가 일치하지 않습니다
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-center">
                        <button type="submit" class="btn btn-primary">비밀번호 등록</button>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
                <!-- 결제 비밀번호가 이미 있는 경우 -->
                <div class="alert alert-success mb-4">
                    <i class="fas fa-check-circle me-2"></i>
                    결제 비밀번호가 등록되어 있습니다.
                </div>
                
                <div class="d-flex justify-content-center gap-3">
                    <button type="button" class="btn btn-outline-primary" id="showChangePasswordForm">
                        비밀번호 변경
                    </button>
                </div>
                
                <div id="changePasswordFormContainer" class="mt-4" style="display: none;">
                    <hr class="my-4">
                    <h5>결제 비밀번호 변경</h5>
                    
                    <form action="${pageContext.request.contextPath}/user/updatePayPassword" method="post"
                          id="updatePasswordForm" class="pay-password-form">
                        <div class="form-group mb-4">
                            <label for="currentPayPassword">현재 비밀번호</label>
                            <div class="password-input-container">
                                <input type="password" maxlength="1" class="form-control current-password-digit" 
                                       data-index="0" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control current-password-digit" 
                                       data-index="1" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control current-password-digit" 
                                       data-index="2" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control current-password-digit" 
                                       data-index="3" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control current-password-digit" 
                                       data-index="4" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control current-password-digit" 
                                       data-index="5" pattern="[0-9]" inputmode="numeric" required>
                                <input type="hidden" name="currentPayPassword" id="currentPayPasswordValue">
                            </div>
                        </div>
                        
                        <div class="form-group mb-4">
                            <label for="newPayPassword">새 비밀번호</label>
                            <div class="password-input-container">
                                <input type="password" maxlength="1" class="form-control new-password-digit" 
                                       data-index="0" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control new-password-digit" 
                                       data-index="1" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control new-password-digit" 
                                       data-index="2" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control new-password-digit" 
                                       data-index="3" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control new-password-digit" 
                                       data-index="4" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control new-password-digit" 
                                       data-index="5" pattern="[0-9]" inputmode="numeric" required>
                                <input type="hidden" name="newPayPassword" id="newPayPasswordValue">
                            </div>
                        </div>
                        
                        <div class="form-group mb-4">
                            <label for="confirmNewPayPassword">새 비밀번호 확인</label>
                            <div class="password-input-container">
                                <input type="password" maxlength="1" class="form-control confirm-new-password-digit" 
                                       data-index="0" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control confirm-new-password-digit" 
                                       data-index="1" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control confirm-new-password-digit" 
                                       data-index="2" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control confirm-new-password-digit" 
                                       data-index="3" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control confirm-new-password-digit" 
                                       data-index="4" pattern="[0-9]" inputmode="numeric" required>
                                <input type="password" maxlength="1" class="form-control confirm-new-password-digit" 
                                       data-index="5" pattern="[0-9]" inputmode="numeric" required>
                            </div>
                            <div class="invalid-feedback" id="new-password-mismatch">
                                비밀번호가 일치하지 않습니다
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-center gap-2">
                            <button type="button" class="btn btn-outline-secondary" id="cancelChangePassword">취소</button>
                            <button type="submit" class="btn btn-primary">비밀번호 변경</button>
                        </div>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    // 비밀번호 입력 자동 이동 기능 구현
    setupPasswordInputs('.pay-password-digit');
    setupPasswordInputs('.confirm-password-digit');
    setupPasswordInputs('.current-password-digit');
    setupPasswordInputs('.new-password-digit');
    setupPasswordInputs('.confirm-new-password-digit');

    // 비밀번호 등록 폼 제출 처리
    const payPasswordForm = document.getElementById('payPasswordForm');
    if (payPasswordForm) {
        payPasswordForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const password = getPasswordValue('.pay-password-digit');
            const confirmPassword = getPasswordValue('.confirm-password-digit');
            
            if (password !== confirmPassword) {
                showPasswordMismatchError('#password-mismatch');
                return;
            }
            
            document.getElementById('payPasswordValue').value = password;
            this.submit();
        });
    }
    
    // 비밀번호 변경 폼 제출 처리
    const updatePasswordForm = document.getElementById('updatePasswordForm');
    if (updatePasswordForm) {
        updatePasswordForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const newPassword = getPasswordValue('.new-password-digit');
            const confirmNewPassword = getPasswordValue('.confirm-new-password-digit');
            
            if (newPassword !== confirmNewPassword) {
                showPasswordMismatchError('#new-password-mismatch');
                return;
            }
            
            const currentPassword = getPasswordValue('.current-password-digit');
            document.getElementById('currentPayPasswordValue').value = currentPassword;
            document.getElementById('newPayPasswordValue').value = newPassword;
            
            this.submit();
        });
    }
    
    // 비밀번호 변경 폼 토글
    const showChangePasswordBtn = document.getElementById('showChangePasswordForm');
    const cancelChangePasswordBtn = document.getElementById('cancelChangePassword');
    const changePasswordFormContainer = document.getElementById('changePasswordFormContainer');
    
    if (showChangePasswordBtn && changePasswordFormContainer) {
        showChangePasswordBtn.addEventListener('click', function() {
            changePasswordFormContainer.style.display = 'block';
            showChangePasswordBtn.style.display = 'none';
        });
    }
    
    if (cancelChangePasswordBtn && changePasswordFormContainer && showChangePasswordBtn) {
        cancelChangePasswordBtn.addEventListener('click', function() {
            changePasswordFormContainer.style.display = 'none';
            showChangePasswordBtn.style.display = 'inline-block';
            
            // 입력 필드 초기화
            clearPasswordInputs('.current-password-digit');
            clearPasswordInputs('.new-password-digit');
            clearPasswordInputs('.confirm-new-password-digit');
        });
    }
});

// 비밀번호 입력 필드 자동 이동 설정
function setupPasswordInputs(selector) {
    const inputs = document.querySelectorAll(selector);
    
    inputs.forEach((input, index) => {
        // 입력 후 다음 필드로 자동 이동
        input.addEventListener('input', function() {
            if (this.value.length === this.maxLength) {
                const nextIndex = index + 1;
                if (nextIndex < inputs.length) {
                    inputs[nextIndex].focus();
                }
            }
        });
        
        // 백스페이스로 이전 필드로 이동
        input.addEventListener('keydown', function(e) {
            if (e.key === 'Backspace' && this.value.length === 0) {
                const prevIndex = index - 1;
                if (prevIndex >= 0) {
                    inputs[prevIndex].focus();
                }
            }
        });
        
        // 숫자만 입력 가능하도록 설정
        input.addEventListener('keypress', function(e) {
            if (e.key < '0' || e.key > '9') {
                e.preventDefault();
            }
        });
    });
}

// 입력된 비밀번호 값 가져오기
function getPasswordValue(selector) {
    const inputs = document.querySelectorAll(selector);
    let password = '';
    
    inputs.forEach(input => {
        password += input.value;
    });
    
    return password;
}

// 비밀번호 불일치 에러 표시
function showPasswordMismatchError(errorSelector) {
    const errorElement = document.querySelector(errorSelector);
    errorElement.style.display = 'block';
    
    const inputContainers = errorElement.closest('.form-group').querySelectorAll('.password-input-container');
    inputContainers.forEach(container => {
        container.classList.add('is-invalid', 'shake');
        
        // 애니메이션 후 shake 클래스 제거
        setTimeout(() => {
            container.classList.remove('shake');
        }, 500);
    });
}

// 비밀번호 입력 필드 초기화
function clearPasswordInputs(selector) {
    const inputs = document.querySelectorAll(selector);
    inputs.forEach(input => {
        input.value = '';
    });
    
    // 에러 메시지 및 스타일 초기화
    const containers = document.querySelectorAll('.password-input-container');
    containers.forEach(container => {
        container.classList.remove('is-invalid', 'shake');
    });
    
    document.querySelectorAll('.invalid-feedback').forEach(element => {
        element.style.display = 'none';
    });
}
</script>
</html>