<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/plain; charset=UTF-8");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UPDATE_FORM</title>
    <link rel ="stylesheet" href ="resources/css/index.css">
</head>
<body>
	<div id = "wrap">
		<%@ include file = "menu.jsp" %>
		
		<div class = "content">
			
		</div>
	</div>
	
	<script type = "module" src = "resources/js/recipeUpdate"></script>
</body>
</html>