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
			
		 		<form id="recipeForm" method="post" action="addRecipe_process.jsp" enctype ="multipart/form-data">

					<input type="hidden" id="recipeJson" name="recipeJson" />

			   		<label for="recipeTitle">레시피 이름</label>
			   		<input type="text" id="recipeTitle" class="recipeInput" placeholder="예) 담백한 두부스테이크"/>

			   		<label for="recipeCategory">카테고리</label>
				    <select id="recipeCategory" class="recipeInput">
						<option>한식</option>
						<option>양식</option>
						<option>중식</option>
						<option>일식</option>
						<option>디저트</option>
						<option>기타</option>
					</select>

					<!-- 재료 -->
					<label>재료</label>
					<div class="ingredientBox">
						<div class="ingredientInputs">
							<input id="ingName" type="text" placeholder="재료명"/>
							<input id="ingAmount" type="text" placeholder="수량"/>
							<select id="ingUnit">
								<option value="g">g</option>
								<option value="ml">ml</option>
								<option value="개">개</option>
								<option value="큰술">큰술</option>
								<option value="작은술">작은술</option>
								<option value="컵">컵</option>
							</select>
			         		<button type="button" id="btnAddIng">+ 재료추가</button>
			      		</div>
			        	<div id="ingList" class="ingredientList"></div>
			    	</div>

					<label>조리 순서</label>
					<div class="stepBox">
						<div class="stepInputs">
							<input id="stepText" type="text" class="recipeInput"
							       placeholder="예) 새송이버섯은 길게 편 썰기한다."/>
							<button type="button" id="btnAddStep">+ 순서추가</button>
						</div>
						<div id="stepList" class="stepList"></div>
					</div>
			
					<label for="recipeImage">대표 사진</label>
					<input type="file" name = "recipeImage" id="recipeImage" class="recipeInput" accept="image/*" />
					<span class="helpText">(JPG/PNG 권장 · 1장)</span>

					<div id="formButtons">
						<button type="button" id="btnSubmit">업로드</button>
						<button type="button" id="btnCancel">취소</button>
					</div>

				</form>

			</div>
		</div>

		<script src="resources/js/addRecipe.js"></script>
	</div>
</body>
</html>