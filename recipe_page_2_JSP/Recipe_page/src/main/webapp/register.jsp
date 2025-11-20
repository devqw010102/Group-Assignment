<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>

    <link rel="stylesheet" href="resources/css/register.css">
</head>
<body>
	<div id = "wrap">
		
		<%@include file = "menu.jsp" %>
		
        <div class = "content">
            <div class = "container">
                <div class="signup-form">
                    <h2 class = "headline">회원가입</h2>
	
                    <form action="/signup" method="post">

                    <label for="username">아이디</label>
                    <input type="text" id="username" name="username" required>

                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" required>

                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" required>

                    <label for="confirm">비밀번호 확인</label>
                    <input type="password" id="confirm" name="confirm" required>

                    <button type="submit" class = "btn">가입하기</button>

                    </form>
                </div>
            </div>
        </div>
		
	</div>
	<script src = "resources/js/register.js"></script>
</body>
</html>