// 재료 추가/삭제
let ingName = document.getElementById('ingName');
let ingAmount = document.getElementById('ingAmount');
let ingUnit = document.getElementById('ingUnit');
let addIngBtn = document.getElementById('btnAddIng');
let ingList = document.getElementById('ingList');

let makeIngRow = (name, amt, unit) => {
  let row = document.createElement('div');
  row.className = 'ingRow';

  let nameInput = document.createElement('input');
  nameInput.type = 'text';
  nameInput.value = name;
  nameInput.placeholder = '재료명';

  let amtInput = document.createElement('input');
  amtInput.type = 'text';
  amtInput.value = amt;
  amtInput.placeholder = '수량';

  let unitSelect = document.createElement('select');
  ['g','ml','개','큰술','작은술','컵'].forEach(v => {
    let opt = document.createElement('option');
    opt.value = v;
    opt.textContent = v;
    if (v === unit) opt.selected = true;
    unitSelect.appendChild(opt);
  });

  let delBtn = document.createElement('button');
  delBtn.type = 'button';
  delBtn.className = 'ingDel';
  delBtn.textContent = '삭제';
  delBtn.addEventListener('click', () => row.remove());

  row.appendChild(nameInput);
  row.appendChild(amtInput);
  row.appendChild(unitSelect);
  row.appendChild(delBtn);
  return row;
};

let addIngredient = () => {
  let name = ingName.value.trim();
  let amt = ingAmount.value.trim();
  let unit = ingUnit.value;

  if (!name) {
    alert('재료명을 입력하세요.');
    ingName.focus();
    return;
  }

  ingList.appendChild(makeIngRow(name, amt, unit));

  ingName.value = '';
  ingAmount.value = '';
  ingUnit.value = 'g';
  ingName.focus();
};

addIngBtn.addEventListener('click', addIngredient);

// 이미지 파일 (1개 제한)
let imageInput = document.querySelector('.recipeInput#recipeImage');

imageInput.addEventListener('change', () => {
  if (imageInput.files.length > 1) {
    alert("대표 사진은 1장만 업로드할 수 있습니다.");
    imageInput.value = "";
  }
});

// 업로드 버튼
let submitBtn = document.getElementById('btnSubmit');
submitBtn.addEventListener('click', () => {
  let titleInput = document.querySelector('.recipeInput#recipeTitle');
  if (!titleInput.value.trim()) {
    alert('레시피 이름을 입력해주세요.');
    titleInput.focus();
    return;
  }

  let desc = document.querySelector('.recipeInput#recipeDesc').value.trim();
  let rows = document.querySelectorAll('#ingList .ingRow');
  let ingredients = [];
  rows.forEach(row => {
    let iName = row.children[0].value.trim();
    let iAmt  = row.children[1].value.trim();
    let iUnit = row.children[2].value;
    if (iName) ingredients.push({ name: iName, amount: iAmt, unit: iUnit });
  });

  let payload = {
    title: titleInput.value.trim(),
    category: document.querySelector('.recipeInput#recipeCategory').value,
    desc: desc,
    ingredients: ingredients,
    image: imageInput.files[0] ? imageInput.files[0].name : null
  };
  console.log('업로드 payload:', payload);
  alert('업로드되었습니다.');
});

// 취소 버튼
let cancelBtn = document.getElementById('btnCancel');
cancelBtn.addEventListener('click', () => {
  if (confirm("작성을 취소하시겠습니까?")) {
    document.getElementById('recipeTitle').value = '';
    document.getElementById('recipeCategory').selectedIndex = 0;
    document.getElementById('recipeDesc').value = '';
    document.getElementById('recipeImage').value = '';
    ingList.innerHTML = '';
  }
});
