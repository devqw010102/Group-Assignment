let loginFlag = false;

document.addEventListener("DOMContentLoaded", function() {
	const form = document.getElementById("loginForm");
	if (form) form.onsubmit = checkForm;
});

function checkForm(e) {
	e.preventDefault();
	checkAjax();
}


function checkAjax() {
	const id = document.getElementById("username").value.trim();
	const pwd = document.getElementById("password").value.trim();
	
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "processLogin.jsp", true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
	xhr.onreadystatechange = function() {
		if(xhr.readyState === 4 && xhr.status === 200) {
			if(xhr.responseText.trim() === "success") {
				window.location.href = "index.jsp"; 
			}
			else {
				console.log(xhr.responseText.trim());
				alert("아이디 또는 비밀번호를 확인해주세요.");
			}
		}
	};
	
	xhr.send("id=" + encodeURIComponent(id) + "&password=" + encodeURIComponent(pwd) + "&type=checkAjax");
}