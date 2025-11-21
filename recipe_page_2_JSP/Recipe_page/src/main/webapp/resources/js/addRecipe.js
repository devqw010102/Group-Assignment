let ingredients = [];
let steps = [];


window.addEventListener("DOMContentLoaded", () => {
    document.getElementById("btnAddIng").addEventListener("click", onAddIngredient);
    document.getElementById("btnAddStep").addEventListener("click", onAddStep);
    document.getElementById("btnSubmit").addEventListener("click", onSubmit);
    document.getElementById("btnCancel").addEventListener("click", () => history.back());
});


function onAddIngredient() {
    const name   = document.getElementById("ingName").value.trim();
    const amount = document.getElementById("ingAmount").value.trim();
    const unit   = document.getElementById("ingUnit").value;

    if (name === "") {
        alert("재료명을 입력하세요.");
        return;
    }

    ingredients.push({ name, amount, unit });

    
    document.getElementById("ingName").value = "";
    document.getElementById("ingAmount").value = "";
    document.getElementById("ingUnit").value = "g";

    renderIngredientList();
}

function renderIngredientList() {
    const list = document.getElementById("ingList");
    list.innerHTML = "";

    ingredients.forEach((ing, i) => {
        const row = document.createElement("div");
        row.className = "ingRow";

        
        row.innerHTML = `
            <span>${ing.name}</span>
            <span>${ing.amount}</span>
            <span>${ing.unit}</span>
            <button type="button" class="ingDel" data-idx="${i}">삭제</button>
        `;

        list.appendChild(row);
    });

    
    document.querySelectorAll(".ingDel").forEach(btn => {
        btn.addEventListener("click", () => {
            const index = Number(btn.dataset.idx);
            ingredients.splice(index, 1);
            renderIngredientList();
        });
    });
}


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
            <span class="stepTextView">${step}</span>
            <button type="button" class="stepDel" data-idx="${i}">삭제</button>
        `;

        list.appendChild(row);
    });

    document.querySelectorAll(".stepDel").forEach(btn => {
        btn.addEventListener("click", () => {
            const index = Number(btn.dataset.idx);
            steps.splice(index, 1);
            renderStepList();
        });
    });
}


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

    
    const today = new Date();
    const yyyy  = today.getFullYear();
    const mm    = String(today.getMonth() + 1).padStart(2, "0");
    const dd    = String(today.getDate()).padStart(2, "0");
    const dateNow = `${yyyy}-${mm}-${dd}`;

    
	const recipeObj = {
	    title: title,
	    category: category,
	    ingredients: ingredients,
	    steps: steps,
	    image_name: imageName,
	    dateNow: dateNow
	};
    
    document.getElementById("recipeJson").value = JSON.stringify(recipeObj);
    document.getElementById("dateNow").value    = dateNow;

    console.log("보낼 JSON:", JSON.stringify(recipeObj));

    
    document.getElementById("recipeForm").submit();
}
