<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>레시피 수정</title>
    <link rel ="stylesheet" href ="resources/css/recipeUpdate.css">
</head>
<body>
	<div id = "wrap">
		<%@ include file = "menu.jsp" %>

		<div class = "content">
			<div class = "container">
				<div class = "update-form">
					<h2 class = "headline">레시피 수정</h2>
				
					<%
						Connection conn = null;
						PreparedStatement pstmt = null;
						ResultSet rs = null;
						
						try {
							Class.forName("oracle.jdbc.driver.OracleDriver");
							conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");
						}
						catch(Exception e) {
							out.println("recipeUpdate.jsp_Error");
							out.println(e.getMessage());
						}
					
						String recipe_id = request.getParameter("id");
						String sql = "SELECT json FROM recipe WHERE ID = ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, recipe_id);
						rs = pstmt.executeQuery();
						
						if(rs.next()) {
							String jsonData = rs.getString("json");
							JSONObject obj = new JSONObject(jsonData);
					%>
				
					<form id = "updateForm" method = "post" action = "processRecipeUpdate.jsp" enctype = "multipart/form-data">
						<input type = "hidden" id = "recipeJson" name = "recipeJson" />
						<input type="hidden" name="recipe_id" value="<%= recipe_id %>">
						
						
						<label for="recipeTitle">레시피 이름</label>
				   		<input type="text" id="recipeTitle" class="recipeInput" value = '<%= obj.getString("name") %>'/>
						
						<%
							// JSON 카테고리 가져오기
							String category = obj.getString("category");
							request.setAttribute("category", category);
						%>
				   		<label for="recipeCategory">카테고리</label>	   		
						<select id="recipeCategory" class="recipeInput" name="category">
						    <option value="한식" <%= category.equals("한식") ? "selected" : "" %>>한식</option>
						    <option value="양식" <%= category.equals("양식") ? "selected" : "" %>>양식</option>
						    <option value="중식" <%= category.equals("중식") ? "selected" : "" %>>중식</option>
						    <option value="일식" <%= category.equals("일식") ? "selected" : "" %>>일식</option>
						    <option value="디저트" <%= category.equals("디저트") ? "selected" : "" %>>디저트</option>
						    <option value="기타" <%= category.equals("기타") ? "selected" : "" %>>기타</option>
						</select>
						
						<%
							// JSON 재료 배열 가져오기
							JSONArray arr = obj.getJSONArray("ingredient");
							String[] ingredient = new String[arr.length()];
							for(int i = 0; i < arr.length(); i++) {
								ingredient[i] = arr.getString(i);
							}
							request.setAttribute("ingredient", ingredient);
						%>
						
						<label>재료</label>
						<div class = "ingredientBox">
							<div class = "ingredientInputs">
							    <c:forEach var="ing" items="${ingredient}" varStatus = "st">
							    	<div class = "ingCard">
							    		<span class = "ingNumber">${st.index + 1 }</span>
										<input type="text" class = "ingInput" value="${ing}" placeholder = "재료 입력">
										<button type = "button" class = "btnDeleteIng">삭제</button>							    		
							    	</div>
							    </c:forEach>
							    <button type = "button" id = "btnAddIng">+ 재료추가</button>
							</div>
							<div id="ingList" class="ingredientList"></div>
						</div>
						 
						 <%
						 	// JSON 조리순서 배열 가져오기
						 	arr = obj.getJSONArray("cook");
						 	String[] cooks = new String[arr.length()];
						 	for(int i = 0; i < arr.length(); i++) {
						 		cooks[i] = arr.getString(i);
						 	}
						 	request.setAttribute("cooks", cooks);
						 %>
						 
						 <label>조리 순서</label>
						 <div class = "stepBox">
						 	<div class = "stepInputs">					 			
						 		<c:forEach var = "cook" items = "${cooks }" varStatus = "st">
						 			<div class = "stepCard">
	 				                	<span class="stepNumber">${st.index + 1}</span>
						                <input type="text" class="stepInput" value="${cook}" placeholder="조리 단계 입력">
						                <button type="button" class="btnDeleteStep">삭제</button>
						 			</div>
						 		</c:forEach>
						 		<button type = "button" id = "btnAddCook">+ 조리방법 추가</button>
						 	</div>
						 	<div id="stepList" class="stepList"></div>
						 </div>
						 
						 <%
						 	// JSON 이미지 가져오기
						 	String imageFile = obj.getString("image");
						 %>
						 <label>대표 사진</label>
						 
						 <c:if test = "${not empty imageFile }">
						 	<p> 현재 이미지</p>
						 	<img src = "${imageFile }" width = "200px">
						 </c:if>
						 
						 <input type = "hidden" name = "oldFile" value = "<%= imageFile %>">
						 
						 <input type = "file" name = "imageFile" id = "recipeImage" class = "recipeInput" accept = "image/*">
						 <span class="helpText">(JPG/PNG 권장 · 1장)</span>
						 
						 <div id = "formButtons">
						 	<button type = "button" id = "btnSubmit">수정하기</button>
						 	<button type = "button" id = "btnCancel">취소</button>
						 </div>
					</form>
					<%
						}
						if (rs != null)
							rs.close();
						if (pstmt != null)
							pstmt.close();
						if (conn != null)
							conn.close();
					%>
				</div>
			</div>
		</div>
		<%@include file = "footer.jsp" %>
	</div>	 
	<script src = "resources/js/recipeUpdate.js"></script>
</body>
</html>