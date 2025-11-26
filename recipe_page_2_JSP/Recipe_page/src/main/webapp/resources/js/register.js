// Validate 2 Register
function  validateForm() {
	
	const form = document.getElementById("registerForm");
	const id = document.getElementById("username");
	const pwd = document.getElementById("password");
	const pwd_con = document.getElementById("confirm");
	
}

function checkId() {
    const id = document.getElementById("username").value.trim();
    const idResult = document.getElementById("idResult");

    if (!id) {
        idResult.textContent = "";
        return;
    }
	
	if (id.length < 4 || id.length > 20) {
	    idResult.innerHTML = "<span style='color:red'>아이디는 4~20글자여야 합니다.</span>";
	    return;
	}

    // AJAX 방식
    const xhr = new XMLHttpRequest();
    xhr.open("POST", "processRegister.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    xhr.onreadystatechange = function() {
        if(xhr.readyState === 4 && xhr.status === 200) {
            idResult.innerHTML = xhr.responseText;
        }
    };

    xhr.send("id=" + encodeURIComponent(id) + "&type=checkId");
}

function checkPwd() {
	const pwd = document.getElementById("password").value.trim();
	const pwdResult = document.getElementById("pwdResult");
	
	if(!pwd) {
	    pwdResult.textContent = "";
	    return;
	}
	
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "processRegister.jsp", true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
	xhr.onreadystatechange = function() {
		if(xhr.readyState === 4 && xhr.status === 200) {
			pwdResult.innerHTML = xhr.responseText;
		}
	};
	
	xhr.send("password=" + encodeURIComponent(pwd) + "&type=checkPwd");
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