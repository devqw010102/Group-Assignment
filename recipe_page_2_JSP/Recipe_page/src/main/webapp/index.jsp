<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.stream.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>레시피</title>
    <link rel ="stylesheet" href ="resources/css/index.css">
</head>
<body>
    <div id = "wrap">
    
	    <%@include file = "menu.jsp" %>
    
        <div class = "content">
            <div class = "container">
                <div id = "boxs"></div>
            </div>
        </div>
        
        <%@include file = "footer.jsp" %>
    </div>

    <script type="module" src = "resources/js/index.js"></script>
</body>
</html>