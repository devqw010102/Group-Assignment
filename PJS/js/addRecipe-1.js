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

  let payload = {
    title: titleInput.value.trim(),
    category: document.querySelector('.recipeInput#recipeCategory').value,
    desc: document.querySelector('.recipeInput#recipeDesc').value.trim(),
    ingredients: document.querySelector('.recipeInput#recipeIngredients').value.trim(),
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
    document.getElementById('recipeIngredients').value = '';
    document.getElementById('recipeImage').value = '';
  }
});

