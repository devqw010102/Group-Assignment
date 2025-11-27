# 레시피 페이지 만들기

### 조별과제

김병국, 강전홍, 박영기, 박주승

---

### Todo
<pre>   
    1. 회원 수정 : 1-1) 전화번호 정규식 사용하여 입력 차단, 

    2. menu -> 보이는 것과 버튼 크기가 다름( div 박스 추가)

    3. register -> 회원가입 성공시 바로 로그인 되는 것 조금 이상?(말은 된다)

    4. addRecipe -> 재료추가 할 때 '수량'에 Int 값만 들어감
</pre>

---

### 수정사항
<pre>
    1. 레시피 철자 = 수정 完
    2. Index 페이지 이미지 크기 조절 完
    3. 재료 배열, 페이지에 추가 完
    4. Tab1 이름 추가 完
    5. 삭제 버튼 추가 完
</pre>

---

### 페이지 담당

 | 김병국 | 강전홍 | 박영기 | 박주승 |
 | ----- | ------ | ------| ------|
 | index | login | register | addRecipe |
 | recipeUpdate | |          | memberUpdate |  
 | login, register 기능 | | | adminPage |

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
    <td>페이지 종합 폴더(html)</td>
  </tr>
  <tr>
      <td>recipe_page_2_JSP</td>
      <td>페이지 종합 폴더(JSP)</td>
  </tr>
</table>

---

#### 로그인 페이지
<pre>
  담당 : 강전홍
  파일 : login
</pre>

#### 회원가입 페이지
<pre>
  담당 : 박영기
  파일 : register
</pre>

#### 레시피 페이지
<pre>
  담당 : 김병국
  파일 : index, recipe_object.js, recipeList
  레시피 내용 : 이미지, 이름, 재료, 조리방법

  index.js 주석 추가 完
</pre>

#### 레시피 추가 페이지
<pre>
  담당 : 박주승
  파일 : addRecipt
  레시피 내용 : 레시피 페이지와 동일
</pre>

#### 회원 수정 페이지
<pre>
    담당 : 미정
    파일 : memberUpdate.html, memberUpdate.css, memberUpdate.js
    내용 : 로그인된 회원 정보의 수정(아이디, 비밀번호)
</pre>

### ERD
<img width="294" height="728" alt="image" src="https://github.com/user-attachments/assets/66420ade-49a7-4baf-938b-c38a5e4a6e9e" />


