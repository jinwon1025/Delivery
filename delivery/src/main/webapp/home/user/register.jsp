<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>    
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
        }

        /* 비밀번호 불일치 시 빨간색 메시지 스타일 */
        .error-message {
            color: red;
            display: none;
        }
    </style>

    <script>
        $(document).ready(function () {
            // 비밀번호 입력 필드와 확인 필드
            const passwordField = $('#password');
            const passwordCheckField = $('#passwordcheck');
            const errorMessage = $('#password-error-message');
            const submitButton = $('input[type="submit"]');

            // 비밀번호 확인 필드의 입력이 변경될 때마다 실행
            passwordCheckField.on('input', function () {
                // 비밀번호와 비밀번호 확인이 일치하지 않으면 에러 메시지 표시
                if (passwordField.val() !== passwordCheckField.val()) {
                    errorMessage.text('비밀번호가 일치하지 않습니다.').show();
                    submitButton.prop('disabled', true);  // 제출 버튼 비활성화
                } else {
                    errorMessage.hide();
                    submitButton.prop('disabled', false);  // 제출 버튼 활성화
                }
            });
        });
    </script>
</head>
<body>
    <h2>회원가입</h2>
    <form:form action="/user/insertRegister" method="post" modelAttribute="user">
        <table>
            <tr>
                <th>아이디</th>
                <td>
                    <form:input path="user_id" id="user_id" placeholder="아이디 입력(15자 이하)"/>
                    <font color="red"><form:errors path="user_id"/></font>
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>
                    <form:password path="password" id="password" placeholder="비밀번호 입력(8자 이상 영문+숫자)"/>
                    <font color="red"><form:errors path="password"/></font>
                </td>
            </tr>
            <tr>
                <th>비밀번호 확인</th>
                <td>
                    <form:password path="passwordcheck" id="passwordcheck" placeholder="비밀번호를 다시 입력해주세요"/>
                    <font color="red"><form:errors path="passwordcheck"/></font>
                    <div id="password-error-message" class="error-message"></div>
                </td>
            </tr>
            <tr>
                <th>이름</th>
                <td>
                    <form:input path="user_name" id="user_name" placeholder="이름을 입력해주세요"/>
                    <font color="red"><form:errors path="user_name"/></font>
                </td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>
                    <form:input path="user_phone" id="user_phone" placeholder="전화번호를 입력해주세요"/>
                    <font color="red"><form:errors path="user_phone"/></font>
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>
                    <form:input path="email" id="email" placeholder="이메일을 입력해주세요"/>
                    <font color="red"><form:errors path="email"/></font>
                </td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td>
                    <form:input path="birth" id="birth" placeholder="생일을 선택하세요"/>
                    <font color="red"><form:errors path="birth"/></font>
                </td>
            </tr>
        </table>
        <input type="submit" value="가입하기" />
    </form:form>
</body>
</html>
