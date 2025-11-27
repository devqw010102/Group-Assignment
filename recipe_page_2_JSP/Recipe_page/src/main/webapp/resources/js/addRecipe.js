// addRecipe.js

// 전역 배열
let ingredients = [];
let steps = [];

document.addEventListener("DOMContentLoaded", () => {
  const btnAddIng   = document.getElementById("btnAddIng");
  const btnAddStep  = document.getElementById("btnAddStep");
  const btnSubmit   = document.getElementById("btnSubmit");
  const btnCancel   = document.getElementById("btnCancel");

  if (btnAddIng)  btnAddIng.addEventListener("click", onAddIngredient);
  if (btnAddStep) btnAddStep.addEventListener("click", onAddStep);
  if (btnSubmit)  btnSubmit.addEventListener("click", onSubmit);
  if (btnCancel)  btnCancel.addEventListener("click", () => history.back());
});

/* ================= 재료 ================= */

// 재료 추가 버튼 클릭
function onAddIngredient() {
  const nameInput   = document.getElementById("ingName");
  const amountInput = document.getElementById("ingAmount");
  const unitSelect  = document.getElementById("ingUnit");

  if (!nameInput || !amountInput || !unitSelect) return;

  const name   = nameInput.value.trim();
  const amount = amountInput.value.trim();   // 🔥 문자열 그대로 (숫자 제한 없음)
  const unit   = unitSelect.value;

  if (!name || !amount) {
    alert("재료명과 수량을 입력하세요.");
    return;
  }

  // amount = 한글/영어/슬래시 등 자유, unit은 따로 저장
  ingredients.push({
    name: name,
    amount: amount,   // 예: "한 줌", "1/2", "많이"
    unit: unit        // 예: "g", "ml", "개"
  });

  // 입력 칸 초기화
  nameInput.value = "";
  amountInput.value = "";
  unitSelect.selectedIndex = 0;

  renderIngredientList();
}

// 재료 리스트 렌더링
function renderIngredientList() {
  const list = document.getElementById("ingList");
  list.innerHTML = "";

  ingredients.forEach((ing, index) => {
    const row = document.createElement("div");
    row.className = "ingRow";

    // 이름 (읽기 전용)
    const nameSpan = document.createElement("span");
    nameSpan.textContent = ing.name;

    // 수량 (읽기 전용)
    const amountSpan = document.createElement("span");
    amountSpan.textContent = ing.amount;

    // 단위 (읽기 전용)
    const unitSpan = document.createElement("span");
    unitSpan.textContent = ing.unit;

    // 삭제 버튼
    const delBtn = document.createElement("button");
    delBtn.type = "button";
    delBtn.className = "ingDel";
    delBtn.textContent = "삭제";
    delBtn.addEventListener("click", () => {
      ingredients.splice(index, 1);
      renderIngredientList();
    });

    // 🔥 grid 4칸: 이름 / 수량 / 단위 / 삭제
    row.appendChild(nameSpan);
    row.appendChild(amountSpan);
    row.appendChild(unitSpan);
    row.appendChild(delBtn);

    list.appendChild(row);
  });
}

/* ================= 조리 순서 ================= */

// 순서 추가
function onAddStep() {
  const stepInput = document.getElementById("stepText");
  if (!stepInput) return;

  const text = stepInput.value.trim();
  if (!text) {
    alert("조리 순서를 입력하세요.");
    return;
  }

  steps.push(text);
  stepInput.value = "";
  renderStepList();
}

// 위/아래 이동
function moveStepUp(idx) {
  if (idx <= 0) return;
  const temp = steps[idx - 1];
  steps[idx - 1] = steps[idx];
  steps[idx] = temp;
  renderStepList();
}

function moveStepDown(idx) {
  if (idx >= steps.length - 1) return;
  const temp = steps[idx + 1];
  steps[idx + 1] = steps[idx];
  steps[idx] = temp;
  renderStepList();
}

// 조리 순서 리스트 렌더링
function renderStepList() {
  const list = document.getElementById("stepList");
  if (!list) return;

  list.innerHTML = "";

  steps.forEach((stepText, index) => {
    const row = document.createElement("div");
    row.className = "stepRow";

    // 번호
    const indexSpan = document.createElement("span");
    indexSpan.className = "stepIndex";
    indexSpan.textContent = (index + 1) + ".";

    // 내용 (span으로, CSS .stepTextView 적용)
    const textSpan = document.createElement("span");
    textSpan.className = "stepTextView";
    textSpan.textContent = stepText;

    // 버튼 묶음
    const btnBox = document.createElement("div");
    btnBox.style.display = "flex";
    btnBox.style.gap = "4px";

    const upBtn = document.createElement("button");
    upBtn.type = "button";
    upBtn.className = "stepDel";
    upBtn.textContent = "▲";
    upBtn.addEventListener("click", () => moveStepUp(index));

    const downBtn = document.createElement("button");
    downBtn.type = "button";
    downBtn.className = "stepDel";
    downBtn.textContent = "▼";
    downBtn.addEventListener("click", () => moveStepDown(index));

    const delBtn = document.createElement("button");
    delBtn.type = "button";
    delBtn.className = "stepDel";
    delBtn.textContent = "삭제";
    delBtn.addEventListener("click", () => {
      steps.splice(index, 1);
      renderStepList();
    });

    btnBox.appendChild(upBtn);
    btnBox.appendChild(downBtn);
    btnBox.appendChild(delBtn);

    row.appendChild(indexSpan);
    row.appendChild(textSpan);
    row.appendChild(btnBox);

    list.appendChild(row);
  });
}

/* ================= 폼 전송 ================= */

function onSubmit() {
  const titleInput    = document.getElementById("recipeTitle");
  const categoryInput = document.getElementById("recipeCategory");
  const jsonField     = document.getElementById("recipeJson");
  const form          = document.getElementById("recipeForm");
  const imageInput = document.getElementById("recipeImage");

  if (!titleInput || !categoryInput || !jsonField || !form) return;

  const title    = titleInput.value.trim();
  const category = categoryInput.value;

  if (!title) {
    alert("레시피 이름을 입력하세요.");
    return;
  }
  if (ingredients.length === 0) {	
    alert("재료를 한 개 이상 추가하세요.");
    return;
  }
  if (steps.length === 0) {
    alert("조리 순서를 한 개 이상 추가하세요.");
    return;
  }
  
  let imageName = "";
  if (imageInput.files.length > 0) {
      imageName = imageInput.files[0].name;
  }

  let ingJson = [];

  ingredients.forEach((ing) => {
    const ingStr = `${ing.name} : ${ing.amount}${ing.unit}`;
    ingJson.push(ingStr);
  });
  
  const data = {
	name: title,
	category: category,
	ingredient: ingJson,		// 문자열 배열
	cook: steps,	
	image: imageName
  };

  jsonField.value = JSON.stringify(data);

  form.submit();
}