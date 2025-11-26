window.addEventListener("DOMContentLoaded", () => {
	document.getElementById("btnAddIng").addEventListener('click', onAddIngredient);
	document.getElementById("btnAddCook").addEventListener('click', onAddStep);
	document.getElementById("btnSubmit").addEventListener('click', onSubmit)
	document.getElementById("btnCancel").addEventListener('click', onCancel);
	
	// 재료 추가 -> 삭제 버튼 이벤트
	
	document.querySelector('.ingredientInputs').addEventListener('click', (e) => {
	    if (e.target.matches('.btnDeleteIng')) {
	        e.target.closest('.ingCard')?.remove();
	        updateIngredientNumbers();
	    }
	});

	// 조리 단계 삭제 (이벤트 위임)
	document.querySelector('.stepInputs').addEventListener('click', (e) => {
	    if (e.target.matches('.btnDeleteStep')) {
	        e.target.closest('.stepCard')?.remove();
	        updateStepNumbers();
	    }
	});
});


// 재료 추가 버튼
function onAddIngredient() {
	const ingInputs = document.querySelector('.ingredientInputs');
	const lastInput = ingInputs.querySelector('.ingCard:last-of-type .ingInput');
	
	if(!lastInput) {
		createIngredientCard(1);
		return;
	}
	
	if(lastInput.value.trim() == '') {
		alert('재료를 입력해주세요');
		return;
	}
	
	const ingCount = ingInputs.querySelectorAll('.ingCard').length + 1;
	createIngredientCard(ingCount);
};

// 조리 순서 추가 버튼
function onAddStep() {
	const stepInputs = document.querySelector('.stepInputs');
	const lastStep = stepInputs.querySelector('.stepCard:last-of-type .stepInput');
	
	if(!lastStep) {
		createStepCard(1);
		return;
	}
	
	if(lastStep.value.trim() == '') {
		alert('조리방법을 입력해주세요');
		return;	
	}
	
	const stepCount = stepInputs.querySelectorAll('.stepCard').length + 1;
	createStepCard(stepCount);
};

// 제출 버튼
function onSubmit() {
	const title = document.getElementById('recipeTitle').value.trim();
	const category = document.getElementById('recipeCategory').value;
	const imageInput = document.getElementById('recipeImage');
	
	if(title === '') {
		alert('레시피 이름을 입력하세요');
		return;
	}

	let imageName = '';
	
	if(imageInput.files.length > 0) {
		imageName = imageInput.files[0].name;
	}
	
	// 재료
	const ingInputs = document.querySelectorAll('.ingredientInputs .ingInput');
	const ingredients = Array.from(ingInputs)
							.map(input => input.value.trim())
							.filter(val => val !== '');
	if(ingredients.length === 0) {
		alert('재료를 1개 이상 추가하세요');
		return;
	}						
	
							
	// 조리단계
	const stepInputs = document.querySelectorAll('.stepInputs .stepInput');
	const cook = Array.from(stepInputs)
					  .map(input => input.value.trim())
					  .filter(val => val !== '');
	if(cook.length === 0) {
		alert('조리 순서를 1개 이상 추가하세요');
		return;
	}
					  
	
	const recipeObj = {
		name : title,
		category : category,
		ingredient : ingredients,
		cook : cook,
		image : imageName
	};
	
	document.getElementById('recipeJson').value = JSON.stringify(recipeObj);
	// console.log("보낼 JSON:", JSON.stringify(recipeObj));
	
	document.getElementById('updateForm').submit();
}

// 취소 버튼
function onCancel() {
	if(confirm("취소하시겠습니까?")) {
		history.back();
	}
}

// 재료 번호 재정렬
function updateIngredientNumbers() {
	document.querySelectorAll('.ingCard').forEach((card, i) => {
		card.querySelector('.ingNumber').textContent = i + 1;
	});
}

// 조리 순서 번호 재정렬
function updateStepNumbers() {
	document.querySelectorAll('.stepCard').forEach((card, i) => {
		card.querySelector('.stepNumber').textContent = i + 1;
	});
}

// 재료 Input 추가
function createIngredientCard(num) {
	const ingInputs = document.querySelector('.ingredientInputs');
	const div = document.createElement('div');
	div.classList.add('ingCard');
	
	div.innerHTML = `
						<span class="ingNumber">${num}</span>
						<input type="text" class="ingInput" placeholder="재료 입력">
						<button type="button" class="btnDeleteIng">삭제</button>
					`;
	
	const btnAddIng = document.getElementById('btnAddIng');
	ingInputs.insertBefore(div, btnAddIng);   // ⬅ insertBefore 위치 이동

	updateIngredientNumbers();
}

// 조리 순서 Input 추가
function createStepCard(num) {
	const stepInputs = document.querySelector('.stepInputs');
	const div = document.createElement('div');
	div.classList.add('stepCard');
	
	div.innerHTML = `
						<span class = "stepNumber">${num}</span>
						<input type = "text" class = "stepInput" placeholder ="조리 단계 입력">
						<button type = "button" class = "btnDeleteStep">삭제</button>
					`;
	
	const btnAddCook = document.getElementById('btnAddCook');
	stepInputs.insertBefore(div, btnAddCook);  // ⬅ insertBefore 위치 이동
	
	updateStepNumbers();
}















