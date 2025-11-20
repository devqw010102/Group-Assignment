<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="resources/css/login.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
</head>
<body>
	<div id = "wrap">
	
		<%@include file = "menu.jsp" %>
	
        <div class = "content">
            <div class = "container">
                <div id="login-form">
                    <h2 class = "headline">로그인</h2>
                    <%
                    	String error = request.getParameter("error");
                    
                    	if(error != null) {
        					out.println("<div class='alert alert-danger'>");
        					out.println("아이디와 비밀번호를 확인해 주세요");
        					out.println("</div>");
                    	}
                    %>
                    <form action = "processLogin.jsp" method = "post">
                    	<label for="username"></label>
                    	<input type="text" id="username" name = "id" placeholder="아이디 입력"><br><br>
                    	
                    	<label for="password"></label>
                    	<input type="password" id="password" name = "password" placeholder="비밀번호 입력"><br><br>
                    	
                    	<p><input type = "submit" value = "로그인">		
                    </form>
                </div>
                <div id="message"></div>
            </div>
        </div>
	</div>
	
	<script src="resources/js/login.js"></script>
</body>
</html>