
// 삭제 여부 confirm
function confirmDelete() {
	return confirm("정말 회원 탈퇴하시겠습니까?\n탈퇴 후에는 복구가 불가능합니다.");
}

// 리셋
function clearAll() {
	const form = document.getElementById("memberForm");
	
	if(!form) return;
	
	form.querySelectorAll('input[type="text"], input[type="password"]').forEach(el => {
		if(el.name !== 'id')
			el.value = '';
	});
	
	form.querySelectorAll('select').forEach(el => {
		el.selectedIndex = 0;
	});
	
	form.querySelectorAll('input[type="radio"], input[type="checkbox"]').forEach(el => {
		el.checked = false;
	});
}