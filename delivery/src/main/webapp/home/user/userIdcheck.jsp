<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 중복 확인</title>
    
    <!-- 기본 스타일 -->
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 160px;
        }
        
        h2 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .form-container {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 350px;
            margin-bottom: 20px;
        }
        
        .form-group {
            display: flex;
            margin-bottom: 15px;
        }
        
        input[type="text"] {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        button {
            background: linear-gradient(135deg, #D4AF37, #E6C65C);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            margin-left: 10px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        button:hover {
            background: linear-gradient(135deg, #B8860B, #D4AF37);
            transform: translateY(-2px);
        }
        
        .result-container {
            text-align: center;
            padding: 15px;
            border-radius: 8px;
            width: 100%;
            max-width: 350px;
        }
        
        .available {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .not-available {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .btn-use {
            background-color: #28a745;
            margin-top: 15px;
        }
        
        .btn-use:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <h2>아이디 중복 확인</h2>
    
    <div class="form-container">
        <form action="/user/idcheck" method="get">
            <div class="form-group">
                <input type="text" name="user_id" value="${user_id}" placeholder="아이디 입력 (5~15자)" />
                <button type="submit">중복검사</button>
            </div>
        </form>
    </div>
    
    <c:if test="${not empty user_id}">
        <div class="result-container ${DUP == 'NO' ? 'available' : 'not-available'}">
            <c:choose>
                <c:when test="${DUP == 'NO'}">
                    <div>
                        <i class="fas fa-check-circle" style="font-size: 1.5rem; margin-bottom: 10px;"></i>
                        <p><strong>${user_id}</strong>는 사용 가능한 아이디입니다.</p>
                        <button type="button" class="btn-use" onclick="idOk('${user_id}')">이 아이디 사용하기</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div>
                        <i class="fas fa-times-circle" style="font-size: 1.5rem; margin-bottom: 10px;"></i>
                        <p><strong>${user_id}</strong>는 이미 사용중인 아이디입니다.</p>
                    </div>
                    <script>
                        opener.document.frm.user_id.value = "";
                    </script>
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>
    
    <script>
        function idOk(id) {
            opener.document.frm.user_id.value = id;
            opener.document.frm.user_id.readOnly = true;
            opener.document.frm.idchecked.value = "yes";
            self.close();
        }
    </script>
</body>
</html>