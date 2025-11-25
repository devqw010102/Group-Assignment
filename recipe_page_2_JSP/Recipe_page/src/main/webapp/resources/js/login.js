/*

const users = [
  { username: "admin", password: "1234" },
  { username: "hong", password: "abcd" },
  { username: "guest", password: "guest" }
];
*/
document.getElementById("login-btn").addEventListener("click", () => {
  const id = document.getElementById("username").value.trim();
  const pw = document.getElementById("password").value.trim();
  const msg = document.getElementById("message");

  if (!id || !pw) {
    msg.textContent = "아이디와 비밀번호를 모두 입력해주세요.";
    msg.style.color = "orange";
    return;
  }

  const user = users.find(u => u.username === id && u.password === pw);

  if (user) {
    msg.textContent = `환영합니다, ${user.username}님!`;
    msg.style.color = "green";
    document.getElementById("login-form").style.display = "none";
  } else {
    msg.textContent = "로그인 실패! 아이디 또는 비밀번호가 틀렸습니다.";
    msg.style.color = "red";
  }
});