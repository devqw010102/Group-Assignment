let ingredients = [];
let steps = [];

window.addEventListener("DOMContentLoaded", () => {
    document.getElementById("btnAddIng").addEventListener("click", onAddIngredient);
    document.getElementById("btnAddStep").addEventListener("click", onAddStep);
    document.getElementById("btnSubmit").addEventListener("click", onSubmit);
    document.getElementById("btnCancel").addEventListener("click", () => history.back());	
});

/* ======================= 재료 ======================= */

function onAddIngredient() {
    const name   = document.getElementById("ingName").value.trim();
    const amount = document.getElementById("ingAmount").value.trim();
    const unit   = document.getElementById("ingUnit").value;

  if(!name || !amount) return alert("재료명과 수량을 입력해주세요.");

  	const ingStr = `${name} : ${amount}${unit}`;
	ingredients.push(ingStr);
	
    document.getElementById("ingName").value = "";
    document.getElementById("ingAmount").value = "";
    document.getElementById("ingUnit").value = "g";

    renderIngredientList();
}

function renderIngredientList() {
    const list = document.getElementById("ingList");
    list.innerHTML = "";

    ingredients.forEach((ing, i) => {
		
		// 문자열 파싱
		let [name, rest] = ing.split(" : ");
		let amount = rest ? rest.replace(/[^\d]/g, "") : "";
		let unit   = rest ? rest.replace(/[\d\s]/g, "") : "";
		
        const row = document.createElement("div");
        row.className = "ingRow";

        
		row.innerHTML = `
		    <input type="text" class="ingEditName" data-idx="${i}" value="${name}">
		    <input type="text" class="ingEditAmount" data-idx="${i}" value="${amount}">
		    
		    <select class="ingEditUnit" data-idx="${i}">
		        <option value="g" ${unit  === "g" ? "selected" : ""}>g</option>
		        <option value="ml" ${unit === "ml" ? "selected" : ""}>ml</option>
		        <option value="개" ${unit === "개" ? "selected" : ""}>개</option>
		        <option value="큰술" ${unit === "큰술" ? "selected" : ""}>큰술</option>
		        <option value="작은술" ${unit === "작은술" ? "selected" : ""}>작은술</option>
		        <option value="컵" ${unit === "컵" ? "selected" : ""}>컵</option>
		    </select>

		    <button type="button" class="ingDel" data-idx="${i}">삭제</button>
		`;

        list.appendChild(row);
    });

	// 이름 수정
	document.querySelectorAll(".ingEditName").forEach(input => {
	        input.addEventListener("input", () => {
	            const idx = Number(input.dataset.idx);
	            let [_, rest] = ingredients[idx].split(" : ");
	            ingredients[idx] = `${input.value} : ${rest}`;
	        });
	    });

    // 수량 수정
    document.querySelectorAll(".ingEditAmount").forEach(input => {
        input.addEventListener("input", () => {
            const idx = Number(input.dataset.idx);
            let [name, rest] = ingredients[idx].split(" : ");
            let unit = rest.replace(/[0-9\s]/g, "");
            ingredients[idx] = `${name} : ${input.value}${unit}`;
        });
    });

    // 단위 변경
    document.querySelectorAll(".ingEditUnit").forEach(select => {
        select.addEventListener("change", () => {
            const idx = Number(select.dataset.idx);
            let [name, rest] = ingredients[idx].split(" : ");
            let amount = rest.replace(/[^\d]/g, "");
            ingredients[idx] = `${name} : ${amount}${select.value}`;
        });
    });

    // 삭제
    document.querySelectorAll(".ingDel").forEach(btn => {
        btn.addEventListener("click", () => {
            const idx = Number(btn.dataset.idx);
            ingredients.splice(idx, 1);
            renderIngredientList();
        });
    });
}

/* ======================= 조리 순서 ======================= */

function onAddStep() {
    const txt = document.getElementById("stepText").value.trim();
    if (txt === "") {
        alert("조리 순서를 입력하세요.");
        return;
    }

    steps.push(txt);
    document.getElementById("stepText").value = "";
    renderStepList();
}

function renderStepList() {
    const list = document.getElementById("stepList");
    list.innerHTML = "";

    steps.forEach((step, i) => {
        const row = document.createElement("div");
        row.className = "stepRow";

		row.innerHTML = `
		    <span class="stepIndex">${i + 1}.</span>

		    <input type="text" 
		           class="stepEditInput"
		           value="${step}"
		           data-idx="${i}"/>

		    <div class="stepBtnGroup">
		        <button type="button" class="stepBtn stepBtn-move stepUp" data-idx="${i}">▲</button>
		        <button type="button" class="stepBtn stepBtn-move stepDown" data-idx="${i}">▼</button>
		        <button type="button" class="stepBtn stepBtn-delete stepDel" data-idx="${i}">삭제</button>
		    </div>
		`;

        list.appendChild(row);
    });

	
	// 내용 수정
	    list.querySelectorAll(".stepEditInput").forEach(input => {
	        input.addEventListener("input", () => {
	            const index = Number(input.dataset.idx);
	            steps[index] = input.value;
	        });
	    });

	    // 삭제
	    list.querySelectorAll(".stepDel").forEach(btn => {
	        btn.addEventListener("click", () => {
	            const index = Number(btn.dataset.idx);
	            steps.splice(index, 1);
	            renderStepList();
	        });
	    });

	    // 위로
	    list.querySelectorAll(".stepUp").forEach(btn => {
	        btn.addEventListener("click", () => {
	            const index = Number(btn.dataset.idx);
	            if (index === 0) return;

	            const tmp = steps[index - 1];
	            steps[index - 1] = steps[index];
	            steps[index] = tmp;

	            renderStepList();
	        });
	    });

	    // 아래로
	    list.querySelectorAll(".stepDown").forEach(btn => {
	        btn.addEventListener("click", () => {
	            const index = Number(btn.dataset.idx);
	            if (index === steps.length - 1) return;

	            const tmp = steps[index + 1];
	            steps[index + 1] = steps[index];
	            steps[index] = tmp;

	            renderStepList();
	        });
	    });
}

/* ======================= 제출 ======================= */

function onSubmit() {
    const title      = document.getElementById("recipeTitle").value.trim();
    const category   = document.getElementById("recipeCategory").value;  
    const imageInput = document.getElementById("recipeImage");

    if (title === "") {
        alert("레시피 이름을 입력하세요.");
        return;
    }

    if (ingredients.length === 0) {
        alert("재료를 1개 이상 추가하세요.");
        return;
    }
    if (steps.length === 0) {
        alert("조리 순서를 1개 이상 추가하세요.");
        return;
    }

    
    let imageName = "";
    if (imageInput.files.length > 0) {
        imageName = imageInput.files[0].name;
    }
    
	const recipeObj = {
	    name: title,
	    category: category,
	    ingredient: ingredients,
	    cook: steps,
	    image: imageName
	};
    
    document.getElementById("recipeJson").value = JSON.stringify(recipeObj);
    // console.log("보낼 JSON:", JSON.stringify(recipeObj));
    document.getElementById("recipeForm").submit();
}