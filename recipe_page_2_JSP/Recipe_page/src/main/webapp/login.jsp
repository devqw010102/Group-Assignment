<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="resources/css/login.css">
</head>
<body>
	<div id = "wrap">
	
		<%@include file = "menu.jsp" %>
	
        <div class = "content">
            <div class = "container">
                <div id="login-form">
                    <h2 class = "headline">로그인</h2>
                    <label for="username"></label>
                    <input type="text" id="username" placeholder="아이디 입력"><br><br>
    
                    <label for="password"></label>
                    <input type="password" id="password" placeholder="비밀번호 입력"><br><br>
    
                    <button id="login-btn">로그인</button>
                </div>
                <div id="message"></div>
            </div>
        </div>
	</div>
	
	<script src="resources/js/login.js"></script>
</body>
</html>