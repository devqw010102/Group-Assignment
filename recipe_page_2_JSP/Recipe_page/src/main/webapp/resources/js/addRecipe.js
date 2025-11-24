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

    if (name === "") {
        alert("재료명을 입력하세요.");
        return;
    }

    ingredients.push({ name, amount, unit });

    // 입력칸 초기화
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
            <input type="text" class="ingEditName" data-idx="${i}" value="${ing.name}">
            <input type="text" class="ingEditAmount" data-idx="${i}" value="${ing.amount}">
            
            <select class="ingEditUnit" data-idx="${i}">
                <option value="g" ${ing.unit === "g" ? "selected" : ""}>g</option>
                <option value="ml" ${ing.unit === "ml" ? "selected" : ""}>ml</option>
                <option value="개" ${ing.unit === "개" ? "selected" : ""}>개</option>
                <option value="큰술" ${ing.unit === "큰술" ? "selected" : ""}>큰술</option>
                <option value="작은술" ${ing.unit === "작은술" ? "selected" : ""}>작은술</option>
                <option value="컵" ${ing.unit === "컵" ? "selected" : ""}>컵</option>
            </select>

            <button type="button" class="ingDel" data-idx="${i}">삭제</button>
        `;

        list.appendChild(row);
    });

    // 이름 수정
    document.querySelectorAll(".ingEditName").forEach(input => {
        input.addEventListener("input", () => {
            const index = Number(input.dataset.idx);
            ingredients[index].name = input.value;
        });
    });

    // 수량 수정
    document.querySelectorAll(".ingEditAmount").forEach(input => {
        input.addEventListener("input", () => {
            const index = Number(input.dataset.idx);
            ingredients[index].amount = input.value;
        });
    });

    // 단위 변경
    document.querySelectorAll(".ingEditUnit").forEach(select => {
        select.addEventListener("change", () => {
            const index = Number(select.dataset.idx);
            ingredients[index].unit = select.value;
        });
    });

    // 삭제
    document.querySelectorAll(".ingDel").forEach(btn => {
        btn.addEventListener("click", () => {
            const index = Number(btn.dataset.idx);
            ingredients.splice(index, 1);
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

    // 이미지 파일명(선택) – 실제 저장은 서버에서 다시 처리
    let imageName = "";
    if (imageInput.files.length > 0) {
        imageName = imageInput.files[0].name;
    }

    // 오늘 날짜
    const today = new Date();
    const yyyy  = today.getFullYear();
    const mm    = String(today.getMonth() + 1).padStart(2, "0");
    const dd    = String(today.getDate()).padStart(2, "0");
    const dateNow = `${yyyy}-${mm}-${dd}`;

    // DB JSON 구조에 맞춰서 생성
    const recipeObj = {
        name: title,
        category: category,
        ingredient: ingredients,  // [{name, amount, unit}, ...]
        cook: steps,              // ["...", "..."]
        image: imageName          // 서버에서 실제 경로로 덮어씀
    };

    document.getElementById("recipeJson").value = JSON.stringify(recipeObj);
    document.getElementById("dateNow").value    = dateNow;

    console.log("보낼 JSON:", JSON.stringify(recipeObj));

    document.getElementById("recipeForm").submit();
}
