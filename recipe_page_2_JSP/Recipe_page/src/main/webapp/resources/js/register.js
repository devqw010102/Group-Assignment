// Validate 2 Register
function  validateForm() {
	
	const form = document.getElementById("registerForm");
	const id = document.getElementById("username");
	const pwd = document.getElementById("password");
	
	
}

function checkForm() {
	if(!document.newMember.id.value) {
		alert("아이디를 입력하세요.");
		return false;
	}
	
	if(!document.newMember.password.value) {
		alert("비밀번호를 입력하세요.");
		return false;
	}
	
	if(document.newMember.password.value != document.newMember.password_confirm.value) {
		alert("비밀번호를 동일하게 입력하세요.");
		return false;
	}
}

function onReset() {
	location.reload(true);
}