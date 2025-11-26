let ingredients = [];
let steps = [];

window.addEventListener("DOMContentLoaded", () => {
    document.getElementById("btnAddIng").addEventListener("click", onAddIngredient);
    document.getElementById("btnAddStep").addEventListener("click", onAddStep);
    document.getElementById("btnSubmit").addEventListener("click", onSubmit);
    document.getElementById("btnCancel").addEventListener("click", () => history.back());
});

/* ======================= 재료 ======================= */

// 현재 HTML 기준: 입력창 1개 (id="ingText")
function onAddIngredient() {
    const input = document.getElementById("ingText");
    const text  = input.value.trim();

    if (!text) {
        alert("재료를 입력해주세요.");
        return;
    }

    // "간장 1큰술" 같은 한 줄 문자열로 저장
    ingredients.push(text);
    input.value = "";

    renderIngredientList();
}

function renderIngredientList() {
    const list = document.getElementById("ingList");
    list.innerHTML = "";

    ingredients.forEach((ing, i) => {
        const row = document.createElement("div");
        row.className = "ingRow";

        row.innerHTML = `
            <input type="text" 
                   class="ingEditInput" 
                   data-idx="${i}" 
                   value="${ing}">
            <button type="button" 
                    class="ingDel" 
                    data-idx="${i}">삭제</button>
        `;

        list.appendChild(row);
    });

    // 내용 수정
    list.querySelectorAll(".ingEditInput").forEach(input => {
        input.addEventListener("input", () => {
            const idx = Number(input.dataset.idx);
            ingredients[idx] = input.value;
        });
    });

    // 삭제
    list.querySelectorAll(".ingDel").forEach(btn => {
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
    if (!txt) {
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

    if (!title) {
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
        ingredient: ingredients, // 문자열 배열
        cook: steps,
        image: imageName
    };

    document.getElementById("recipeJson").value = JSON.stringify(recipeObj);

    const now = new Date();
    document.getElementById("dateNow").value = now.toISOString();

    document.getElementById("recipeForm").submit();
}
