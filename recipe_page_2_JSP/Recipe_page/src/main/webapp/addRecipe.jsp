<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<title>레시피 추가</title>
	<link rel="stylesheet" href="resources/css/addRecipe.css">
</head>
<body>
	<div id="wrap">

	    <%@ include file="menu.jsp" %>

		<div class="content">
			<div class="container">
			
		 		<form id="recipeForm"
					  name="recipeForm"
					  method="post"
					  action="addRecipe_process.jsp"
					  enctype="multipart/form-data">

					<!-- 서버로 보낼 JSON / 날짜 -->
					<input type="hidden" id="recipeJson" name="recipeJson" />
					<input type="hidden" id="dateNow" name="dateNow" />

			   		<label for="recipeTitle">레시피 이름</label>
			   		<input type="text" id="recipeTitle" class="recipeInput" placeholder="예) 담백한 두부스테이크"/>

			   		<label for="recipeCategory">카테고리</label>
				    <select id="recipeCategory" class="recipeInput">
						<option value="한식">한식</option>
						<option value="양식">양식</option>
						<option value="중식">중식</option>
						<option value="일식">일식</option>
						<option value="디저트">디저트</option>
						<option value="기타">기타</option>
					</select>

					<!-- 재료 -->
					<label>재료</label>
					<div class="ingredientBox">
					    <div class="ingredientInputs">
					        <input id="ingText" type="text" class="recipeInput"
					               placeholder="예) 간장 1큰술"/>
					        <button type="button" id="btnAddIng">+ 재료추가</button>
					    </div>
					    <div id="ingList" class="stepList"></div>
					</div>

					<!-- 조리 순서 -->
					<label>조리 순서</label>
					<div class="stepBox">
						<div class="stepInputs">
							<input id="stepText" type="text" class="recipeInput"
							       placeholder="예) 새송이버섯은 길게 편 썰기한다."/>
							<button type="button" id="btnAddStep">+ 순서추가</button>
						</div>
						<div id="stepList" class="stepList"></div>
					</div>
			
					<!-- 대표 사진 -->
					<label for="recipeImage">대표 사진</label>
					<input type="file" id="recipeImage" name="recipeImage"
						   class="recipeInput" accept="image/*" />
					<span class="helpText">(JPG/PNG 권장 · 1장)</span>

					<div id="formButtons">
						<button type="button" id="btnSubmit">업로드</button>
						<button type="button" id="btnCancel">취소</button>
					</div>

				</form>

			</div>
		</div>
		<%@include file = "footer.jsp" %>
		<script src="resources/js/addRecipe.js"></script>
	</div>
</body>
</html>
