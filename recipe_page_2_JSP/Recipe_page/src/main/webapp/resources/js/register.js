const idResult = document.getElementById("idResult");
const pwdResult = document.getElementById("pwdResult");
const pwdConResult = document.getElementById("pwdConResult");
const nameResult = document.getElementById("nameResult");

document.addEventListener("DOMContentLoaded", function() {
	const form = document.getElementById("registerForm");
    
	if(form) form.onsubmit = checkForm;
})

// check Form
function checkForm() {
	
	const idResult = document.getElementById("idResult");
	const pwdResult = document.getElementById("pwdResult");
	const pwdConResult = document.getElementById("pwdConResult");
	const nameResult = document.getElementById("nameResult");
	
	checkId();
	checkPwd();
	checkPwdCon();
	checkName();
	
	if(idResult.innerHTML.includes("✔") && pwdResult.innerHTML.includes("✔") && pwdConResult.innerHTML.includes("✔") && nameResult.innerHTML.includes("✔"))   {
		return true;	
	}
	alert("입력 내용을 확인하세요");
	return false;	
}

function checkId() {
    const id = document.getElementById("username").value.trim();
    
    if (!id) {
        idResult.textContent = "";
        return;
    }
	
	if (id.length < 4 || id.length > 20) {
	    idResult.innerHTML = "<span style='color:red'>❌ 4 ~ 20자 이내여야 합니다.</span>";
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

function checkPwdCon() {
	const pwd = document.getElementById("password").value.trim();
	const confirm = document.getElementById("confirm").value.trim();
	
	
	if(!confirm) {
		pwdConResult.textContent = "";
		return;
	}
	
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "processRegister.jsp", true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
	xhr.onreadystatechange = function() {
		if(xhr.readyState === 4 && xhr.status === 200) {
			pwdConResult.innerHTML = xhr.responseText;
		}
	};
	
	xhr.send("password=" + encodeURIComponent(pwd) + "&confirm=" + encodeURIComponent(confirm) + "&type=checkPwdCon");
}

function checkName() {
	const name = document.getElementById("name").value.trim();
	
	if(!name) {
		nameResult.textContent = "❌";
		return;
	}
	
	const xhr = new XMLHttpRequest();
	xhr.open("POST", "processRegister.jsp", true);
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	
	xhr.onreadystatechange = function() {
		if(xhr.readyState === 4 && xhr.status === 200) {
			nameResult.innerHTML = xhr.responseText;
		}
	};
	
	xhr.send("name=" + encodeURIComponent(name) + "&type=checkName");
}

function onReset() {
	location.reload(true);
}