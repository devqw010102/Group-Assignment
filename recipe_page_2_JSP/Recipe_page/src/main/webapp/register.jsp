<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="resources/css/register.css">
</head>
<body>
	<div id = "wrap">
		
		<%@include file = "menu.jsp" %>
		
        <div class = "content">
            <div class = "container">
                <div class="signup-form">
                    <h2 class = "headline">회원가입</h2>
	
                    <div class="form-card">
				      <form action="processRegister.jsp" id = "registerForm" method="post" onsubmit="return checkForm(event)">
				        <!-- 아이디 -->
				        <div class="row">
				          <label class="textLabel" for="username">아이디</label>
				          <div class="control">
				            <input type="text" id="username" name="id" placeholder="영문/숫자 4~20자" autocomplete="username">
				          </div>
				        </div>
				
				        <!-- 비밀번호 -->
				        <div class="row">
				          <label class="textLabel" for="password">비밀번호</label>
				          <div class="control">
				            <input type="password" id="password" name="password" placeholder="최대 20자	" autocomplete="new-password">
				          </div>
				        </div>
				
				        <!-- 비밀번호 확인 -->
				        <div class="row">
				          <label class="textLabel" for="confirm">비밀번호 확인</label>
				          <div class="control">
				            <input type="password" id="confirm" name="password_confirm" placeholder="비밀번호 확인" autocomplete="new-password">
				          </div>
				        </div>
				
				        <!-- 이름 -->
				        <div class="row">
				          <label class="textLabel" for="name">이름</label>
				          <div class="control">
				            <input type="text" id="name" name="name" placeholder="실명을 입력하세요">
				          </div>
				        </div>
				
				        <!-- 성별 -->
				        <div class="row">
				          <label class="textLabel">성별</label>
				          <div class="control radioGroup" role="radiogroup" aria-label="성별 선택">
				            <label><input type="radio" name="gender" value="남"> 남</label>
				            <label><input type="radio" name="gender" value="여"> 여</label>
				          </div>
				        </div>
				
				        <!-- 생일 -->
				        <div class="row">
				          <label class="textLabel">생일</label>
				          <div class="control">
				            <div class="birth-group">
				              <input type="text" name="birthyy" maxlength="4" placeholder="년(4자)" aria-label="출생연도 (년)">
				              <select name="birthmm" aria-label="출생월">
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
				              <input type="text" name="birthdd" maxlength="2" placeholder="일" aria-label="출생일 (일)">
				            </div>
				          </div>
				        </div>
				
				        <!-- 이메일 -->
				        <div class="row">
				          <label class="textLabel" for="email">이메일</label>
				          <div class="control email-group">
				            <input type="text" id="mail1" name="mail1" maxlength="50" placeholder="example" aria-label="이메일 앞부분">
				            <span style="align-self:center">@</span>
				            <select name="mail2" aria-label="이메일 도메인">
				              <option value="naver.com">naver.com</option>
				              <option value="daum.net">daum.net</option>
				              <option value="gmail.com">gmail.com</option>
				              <option value="nate.com">nate.com</option>
				            </select>
				          </div>
				        </div>
				
				        <!-- 전화번호 -->
				        <div class="row">
				          <label class="textLabel" for="phone">전화번호</label>
				          <div class="control">
				            <input type="text" id="phone" name="phone" placeholder="예) 010-1234-5678">
				          </div>
				        </div>
				
				        <!-- 주소 -->
				        <div class="row">
				          <label class="textLabel" for="address">주소</label>
				          <div class="control divAddress">
				            <input type="text" id="address" name="address" placeholder="주소를 입력하세요">
				          </div>
				        </div>
				
				        <!-- 에러 출력 -->
				        <div id="error" class="error" aria-live="polite" style="display:none"></div>
				
				        <!-- 버튼 -->
				        <div class="btnRow">
				          <button type="reset" class="btn ghost" onclick="onReset()">리셋</button>
				          <button type="submit" class="btn primary">등록</button>
				        </div>
				      </form>
				    </div>
                </div>
            </div>
        </div>
		<%@include file = "footer.jsp" %>
	</div>
	<script src = "resources/js/register.js"></script>
</body>
</html>