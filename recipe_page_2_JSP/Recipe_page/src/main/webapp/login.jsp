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
                    <form action = "processLogin.jsp" id = "loginForm" method = "post">
                    	<label for="username"></label>
                    	<input type="text" id="username" name = "id" placeholder="아이디 입력"><br><br>
                    	
                    	<label for="password"></label>
                    	<input type="password" id="password" name = "password" placeholder="비밀번호 입력"><br><br>
                    	
                    	<p><input type = "submit" class = "btn" value = "로그인">		
                    </form>
                </div>
            </div>
        </div>
        <%@include file = "footer.jsp" %>
	</div>
	
	<script src="resources/js/login.js"></script>
</body>
</html>