<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
	<link rel="stylesheet" href="resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="resources/css/register.css">
    <script type = "text/javascript">
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
    </script>
</head>
<body>
	<div id = "wrap">
		
		<%@include file = "menu.jsp" %>
		
        <div class = "content">
            <div class = "container">
                <div class="signup-form">
                    <h2 class = "headline">회원가입</h2>
	
                    <form action= "processRegister.jsp" method="post" onsubmit = "return checkForm()">

                    <label for="username">아이디</label>
                    <input type="text" id="username" name="id">

                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password">

                    <label for="confirm">비밀번호 확인</label>
                    <input type="password" id="confirm" name="password_confirm">
					
					<label for="name">이름</label>
					<input type = "text" name = "name" >
					
					<label for = "gender">성별</label>
					<input type = "radio" name = "gender" value = "남"/>남
					<input type = "radio" name = "gender" value = "여"/>여
										
					<label for = "birth">생일</label>
					<input type = "text" name = "birthyy" maxlength = "4" placeholder = "년(4자)" size = "6">
					<select name = "birthmm">
						<option value="">월</option>
						<option value="01">1</option>
						<option value="02">2</option>
						<option value="03">3</option>
						<option value="04">4</option>
						<option value="05">5</option>
						<option value="06">6</option>
						<option value="07">7</option>
						<option value="08">8</option>
						<option value="09">9</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
					</select>
					<input type = "text" name = "birthdd" maxlength = "2" placeholder = "일" size = "4">
					
                    <label for="email">이메일</label>
                    <input type = "text" name = "mail1" maxlength = "50" >
                    @
                    <select name = "mail2">
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
                    </select>
                    
                    <label for = "phone">전화번호</label>
                    <input type = "text" name = "phone">
                    
                    <label for = "address">주소</label>
                    <input type = "text" name = "address">
                    
                    <input type = "submit" value = "등록">
                    <input type = "reset" value = "취소" onclick = "reset()">

                    </form>
                </div>
            </div>
        </div>
		
	</div>
	<script src = "resources/js/register.js"></script>
</body>
</html>