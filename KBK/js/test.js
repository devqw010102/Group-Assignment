const users = [
  { username: "admin", password: "1234" },
  { username: "hong", password: "abcd" },
  { username: "guest", password: "guest" }
];

// 로그인 시도 횟수 제한
let loginAttempts = 0;
const maxAttempts = 10;
let isBlocked = false;

// 유효성 검사 함수
function validateInput(username, password) {
  const errors = [];
  
  if (!username || username.trim() === "") {
    errors.push("아이디를 입력해주세요.");
  } else if (username.length < 3) {
    errors.push("아이디는 3자 이상이어야 합니다.");
  }
  
  if (!password || password.trim() === "") {
    errors.push("비밀번호를 입력해주세요.");
  } else if (password.length < 4) {
    errors.push("비밀번호는 4자 이상이어야 합니다.");
  }
  
  return errors;
}

// 메시지 표시 함수
function showMessage(message, type) {
  const msg = document.getElementById("message");
  msg.innerHTML = message;
  
  switch(type) {
    case 'success':
      msg.style.color = "green";
      msg.style.backgroundColor = "#f0fff0";
      msg.style.border = "1px solid green";
      break;
    case 'error':
      msg.style.color = "red";
      msg.style.backgroundColor = "#fff0f0";
      msg.style.border = "1px solid red";
      break;
    case 'warning':
      msg.style.color = "orange";
      msg.style.backgroundColor = "#fff8f0";
      msg.style.border = "1px solid orange";
      break;
    default:
      msg.style.backgroundColor = "";
      msg.style.border = "";
  }
  
  msg.style.padding = "10px";
  msg.style.borderRadius = "5px";
  msg.style.marginTop = "10px";
}

// 계정 잠금 해제 함수
function unlockAccount() {
  isBlocked = false;
  loginAttempts = 0;
  showMessage("계정이 잠금 해제되었습니다. 다시 로그인해주세요.", 'success');
}

document.getElementById("login-btn").addEventListener("click", (e) => {
  e.preventDefault(); // 폼 기본 제출 방지
  
  if (isBlocked) {
    showMessage("너무 많은 로그인 실패로 계정이 잠겼습니다. 10초 후 다시 시도해주세요.", 'error');
    return;
  }

  const id = document.getElementById("username").value.trim();
  const pw = document.getElementById("password").value.trim();

  // 유효성 검사
  const errors = validateInput(id, pw);
  if (errors.length > 0) {
    showMessage("❌ " + errors.join("<br>❌ "), 'error');
    return;
  }

  // 로그인 시도
  const user = users.find(u => u.username === id && u.password === pw);

  if (user) {
    // 로그인 성공
    loginAttempts = 0;
    document.getElementById("login-form").style.display = "none";
    
    showMessage(`
      <div style="text-align: center;">
        <h3 style="margin: 0; color: green;">🎉 로그인 성공!</h3>
        <p style="margin: 10px 0;">환영합니다, <strong>${user.username}</strong>님!</p>
        <p style="font-size: 12px; color: #666;">로그인 시간: ${new Date().toLocaleString()}</p>
      </div>
    `, 'success');

    // 5초 후 간단한 메시지로 변경
    setTimeout(() => {
      showMessage(`환영합니다, ${user.username}님! 👋`, 'success');
    }, 5000);

  } else {
    // 로그인 실패
    loginAttempts++;
    const remainingAttempts = maxAttempts - loginAttempts;

    if (remainingAttempts > 0) {
      showMessage(`
        ❌ 로그인 실패!<br>
        아이디 또는 비밀번호가 틀렸습니다.<br>
        <small>남은 시도 횟수: ${remainingAttempts}회</small>
      `, 'error');
    } else {
      // 계정 잠금
      isBlocked = true;
      showMessage(`
        🔒 계정이 잠겼습니다!<br>
        너무 많은 로그인 실패가 발생했습니다.<br>
        10초 후 자동으로 잠금이 해제됩니다.
      `, 'error');
      
      // 10초 후 잠금 해제
      setTimeout(unlockAccount, 10000);
    }
  }
});

// Enter 키로 로그인
document.getElementById("password").addEventListener("keypress", function(e) {
  if (e.key === "Enter") {
    document.getElementById("login-btn").click();
  }
});

// 입력 필드 실시간 유효성 검사
document.getElementById("username").addEventListener("input", function() {
  if (this.value.length >= 3) {
    this.style.borderColor = "green";
  } else {
    this.style.borderColor = "#ccc";
  }
});

document.getElementById("password").addEventListener("input", function() {
  if (this.value.length >= 4) {
    this.style.borderColor = "green";
  } else {
    this.style.borderColor = "#ccc";
  }
});
// box1을 클릭하면 배경색이 랜덤하게 바뀌도록 구현
document.querySelector('.box1').addEventListener('click', function() {
    const colors = ['lightblue', 'lightcoral', 'lightgreen', 'lightyellow', 'lightpink', 'lightcyan', 'lavender', 'lightgoldenrodyellow'];
    const randomColor = colors[Math.floor(Math.random() * colors.length)];
    this.style.backgroundColor = randomColor;
});
document.getElementById("submit-btn").addEventListener("click", function () {
  const answers = document.getElementsByName("answer");
  let selected = null;

  for (let i = 0; i < answers.length; i++) {
    if (answers[i].checked) {
      selected = answers[i].value;
      break;
    }
  }

  const result = document.getElementById("result");

  if (selected === null) {
    result.textContent = "보기를 선택해주세요.";
    result.style.color = "orange";
  } else if (selected === "1") {
    result.textContent = "정답입니다!";
    result.style.color = "green";
  } else {
    result.textContent = "틀렸습니다!";
    result.style.color = "red";
  }
});
function calculate() {
      const n1 = parseFloat(document.getElementById('num1').value);
      const n2 = parseFloat(document.getElementById('num2').value);
      const sum = n1 + n2;
      document.getElementById('result1').innerText = `결과: ${sum}`;
    }
    function showError(message) {
      document.getElementById('result1').innerText = `오류: ${message}`;
      document.getElementById('result1').classList.add('error');
    }
function calculateDiscount() {
      const priceElement = document.querySelector('.box4 #price');
      const discountElement = document.querySelector('.box4 #discount');
      const price = parseFloat(priceElement.value);
      const discount = parseFloat(discountElement.value);
      if (isNaN(price) || isNaN(discount)) {
        document.getElementById('result2').innerText = '숫자를 모두 입력해주세요.';
        return;
      }
      const finalPrice = price - (price * (discount / 100));
      document.getElementById('result2').innerText = `할인된 가격: ${finalPrice.toFixed(0)} 원`;
    }
    document.querySelector('.box4 #calculateBtn').addEventListener('click', calculateDiscount);
    document.querySelector('.box4 #price').addEventListener('input', () => {
      document.getElementById('result2').innerText = '';
    });
    document.querySelector('.box4 #discount').addEventListener('input', () => {
      document.getElementById('result2').innerText = '';
    });