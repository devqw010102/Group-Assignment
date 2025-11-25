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
            	<div class = "filter-bar">
            		<select id = "filterCategory">
            			<option value = "ALL">전체</option>
						<option value="한식">한식</option>
						<option value="양식">양식</option>
						<option value="중식">중식</option>
						<option value="일식">일식</option>
						<option value="디저트">디저트</option>
						<option value="기타">기타</option>
            		</select>
            	</div>
                <div id = "boxs"></div>
            </div>
        </div>
        
        <%@include file = "footer.jsp" %>
    </div>

    <script type="module" src = "resources/js/index.js"></script>
</body>
</html>