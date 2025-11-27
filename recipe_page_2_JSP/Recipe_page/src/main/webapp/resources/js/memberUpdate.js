const phoneResult = document.getElementById("phoneResult");

document.addEventListener("DOMContentLoaded", function() {
	const form = document.getElementById("memberForm");
	
	if(form) form.onsubmit = function() {
	    return checkPhone(); // 체크 결과에 따라 제출 여부 결정
	};
	
	const phoneInput = document.getElementById("phone");
	if(phoneInput) {
	    phoneInput.addEventListener("keyup", checkPhone);
	}
});

function checkPhone() {
    const phone = document.getElementById("phone").value.trim();

    // 공백이면 출력 지우고 제출 가능
    if(!phone) {
        phoneResult.textContent = "";
        return true;
    }

    const xhr = new XMLHttpRequest();
    xhr.open("POST", "memberUpdate_process.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function() {
        if(xhr.readyState === 4 && xhr.status === 200) {
            phoneResult.innerHTML = xhr.responseText;
        }
    }
    xhr.send("phone=" + encodeURIComponent(phone) + "&type=checkPhone");

    return true; // AJAX 체크는 비동기라서 제출 허용
}

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