# 레시피 페이지 만들기

### 조별과제

김병국, 강전홍, 박영기, 박주승

---

### Todo
<pre>
    1. SNS 로그인 추가
        1-1) [구글 로그인] https://srrymn.tistory.com/49
        1-2) https://srrymn.tistory.com/50?category=1211097
        1-3) [네이버 로그인] https://thecorative.tistory.com/entry/SNS%EB%A1%9C%EA%B7%B8%EC%9D%B8%EB%84%A4%EC%9D%B4%EB%B2%84-%EB%A1%9C%EA%B7%B8%EC%9D%B8-javascript%EB%A1%9C-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0-theCoding#google_vignette
    
    2. 회원 정보 수정
        2-1) MemberUpdate.html 김병국 작성중
        2-2) 레이아웃, 인원 할당 토의 필요
        2-3) 테스트 회원 등록 후 테스트 해보기
    
    3. 레시피 정보 수정, 삭제
        3-1) 레시피 페이지 Tab Menu에 수정, 삭제 버튼 추가
        3-2) Recipe_update.html 작성할 것인지 addRecipe로 연계할지 토의 필요
    
    4. 레시피 입력 재료처럼 수정
        4-1) addRecipe.html 레시피 입력 칸 수정 필요
    
    5. recipe_object.js 레시피 객체 추가

    6. 관리자 전용 페이지 추가

    7. 레시피 업데이트, 삭제 이벤트 추가
</pre>

---

### 수정사항
<pre>
    1. 레시피 철자 = 수정 完
    2. Index 페이지 이미지 크기 조절 完
    3. 재료 배열, 페이지에 추가 完
    4. Tab1 이름 추가 完
</pre>

---

### 페이지 담당

 | 김병국 | 강전홍 | 박영기 | 박주승 |
 | ----- | ------ | ------| ------|
 | index | login | register | addRecipe |
 | memberUpdate| |          |            |  

---

### 폴더 정리

<table>
  <tr>
    <td>폴더 이름</td>
    <td>폴더 내용</td>
  </tr>
  <tr>
    <td>KBK</td>
    <td>김병국 개인폴더</td>
  </tr>
  <tr>
    <td>KJH</td>
    <td>강전홍 개인폴더</td>
  </tr>
  <tr>
    <td>PYG</td>
    <td>박영기 개인폴더</td>
  </tr>
  <tr>
    <td>PJS</td>
    <td>박주승 개인폴더</td>
  </tr>
  <tr>
    <td>recipe_page</td>
    <td>페이지 종합 폴더</td>
  </tr>
</table>

---

#### 로그인 페이지
<pre>
  담당 : 강전홍
  파일 : login.html, login.js, login.css
</pre>

#### 회원가입 페이지
<pre>
  담당 : 박영기
  파일 : register.html, register.css
</pre>

#### 레시피 페이지
<pre>
  담당 : 김병국
  파일 : index.html, index.css, index.js, recipe_object.js
  레시피 내용 : 이미지, 이름, 재료, 조리방법

  index.js 주석 추가 完
</pre>

#### 레시피 추가 페이지
<pre>
  담당 : 박주승
  파일 : addRecipt.html, addRecipt.css, addRecipt.js
  레시피 내용 : 레시피 페이지와 동일, 조리 방법 입력, 카테고리 추가
</pre>

#### 회원 수정 페이지
<pre>
    담당 : 미정
    파일 : memberUpdate.html, memberUpdate.css, memberUpdate.js
    내용 : 로그인된 회원 정보의 수정(아이디, 비밀번호)
</pre>
