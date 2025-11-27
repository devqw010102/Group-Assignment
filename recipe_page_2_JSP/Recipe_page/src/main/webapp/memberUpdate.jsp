<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String memberId = (String)session.getAttribute("sessionId");
    if (memberId == null) {
        out.println("로그인이 필요합니다.");
        return;
    }

    String id = null, name = null, gender = null, birth = null;
    String mail = null, phone = null, address = null;

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String sql = "SELECT id, name, gender, birth, mail, phone, address FROM member WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, memberId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            id      = rs.getString("id");
            name    = rs.getString("name");
            gender  = rs.getString("gender");
            birth   = rs.getString("birth");
            mail    = rs.getString("mail");
            phone   = rs.getString("phone");
            address = rs.getString("address");
        }
        if (phone == null || "미입력".equals(phone)) {
            phone = "";
        }
        if (address == null) {
            address = "";
        }
    } catch(Exception e) {
        e.printStackTrace();
        out.println("회원 정보 조회 실패");
        return;
    } finally {
        try { if (rs != null) rs.close(); } catch(Exception ignore){}
        try { if (pstmt != null) pstmt.close(); } catch(Exception ignore){}
    }

    // 생일 분리
    String birthyy = "", birthmm = "", birthdd = "";
    if (birth != null && birth.contains("-")) {
        String[] b = birth.split("-");
        if (b.length == 3) {
            birthyy = b[0];
            birthmm = b[1];
            birthdd = b[2];
        }
    }

    // 이메일 분리
    String mail1 = "", mail2 = "";
    if (mail != null && mail.contains("@")) {
        String[] m = mail.split("@");
        if (m.length == 2) {
            mail1 = m[0];
            mail2 = m[1];
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>

    <!-- 이 페이지 전용 CSS (register까지 통합 버전) -->
    <link rel="stylesheet" href="resources/css/memberUpdate.css">

    <!-- 탈퇴 confirm JS -->
    <script>
        function confirmDelete() {
            return confirm("정말 회원 탈퇴하시겠습니까?\n탈퇴 후에는 복구가 불가능합니다.");
        }
        function clearAll() {
        	 const form = document.getElementById("memberForm");
        	    if (!form) return;   // 폼 못 찾으면 그냥 종료

        	    // 🔹 text/password 비우기 (아이디는 제외)
        	    form.querySelectorAll('input[type="text"], input[type="password"]').forEach(el => {
        	        if (el.name !== 'id') {   // 아이디는 그대로
        	            el.value = '';
        	        }
        	    });

        	    // select 초기화
        	    form.querySelectorAll('select').forEach(el => {
        	        el.selectedIndex = 0;
        	    });

        	    // radio/checkbox 해제
        	    form.querySelectorAll('input[type="radio"], input[type="checkbox"]').forEach(el => {
        	        el.checked = false;
        	    });
            }
    </script>
			    <%
			    String error = request.getParameter("error");
			    if ("1".equals(error)) {
			%>
			        <script>alert("입력 정보가 올바르지 않습니다. 다시 확인해주세요.");</script>
			 <%
        } else if ("2".equals(error)) {
    %>
            <script>alert("전화번호 형식이 올바르지 않습니다.\n예) 010-1234-5678");</script>
    <%
        }
    %>
</head>

<body>


<div id="wrap">

    <%@ include file="menu.jsp" %>

    <div class="content">
        <div class="container">

            <div class="signup-form">
                <h2 class="headline">회원 정보 수정</h2>

                <div class="form-card">
                    <!-- 정보 수정 폼 -->
                    <form id="memberForm" action="memberUpdate_process.jsp" method="post">

                        <!-- 아이디 -->
                        <div class="row">
                            <label class="textLabel">아이디</label>
                            <div class="control">
                                <input type="text" name="id" value="<%= id %>"
                                       readonly style="background:#eee; cursor:not-allowed;">
                            </div>
                        </div>

                        <!-- 이름 -->
                        <div class="row">
                            <label class="textLabel">이름</label>
                            <div class="control">
                                <input type="text" name="name" value="<%= name %>">
                            </div>
                        </div>

                        <!-- 성별 -->
                        <div class="row">
                            <label class="textLabel">성별</label>
                            <div class="control radioGroup">
                                <label><input type="radio" name="gender" value="남" <%= "남".equals(gender)?"checked":"" %>> 남</label>
                                <label><input type="radio" name="gender" value="여" <%= "여".equals(gender)?"checked":"" %>> 여</label>
                            </div>
                        </div>

                        <!-- 생일 -->
                        <div class="row">
                            <label class="textLabel">생일</label>
                            <div class="control birth-group">
                                <input type="text" name="birthyy" maxlength="4" value="<%= birthyy %>" placeholder="년">
                                <select name="birthmm">
                                    <option value="">월</option>
                                    <%
                                        for (int m = 1; m <= 12; m++) {
                                            String mm = (m<10)?"0"+m:""+m;
                                    %>
                                        <option value="<%=mm%>" <%=mm.equals(birthmm)?"selected":""%>><%=m%></option>
                                    <% } %>
                                </select>
                                <input type="text" name="birthdd" maxlength="2" value="<%= birthdd %>" placeholder="일">
                            </div>
                        </div>

                        <!-- 이메일 -->
                        <div class="row">
                            <label class="textLabel">이메일</label>
                            <div class="control email-group">
                                <input type="text" name="mail1" value="<%= mail1 %>">
                                <span>@</span>
                                <select name="mail2">
                                    <option value="naver.com" <%= "naver.com".equals(mail2)?"selected":"" %>>naver.com</option>
                                    <option value="daum.net"  <%= "daum.net".equals(mail2) ?"selected":"" %>>daum.net</option>
                                    <option value="gmail.com" <%= "gmail.com".equals(mail2)?"selected":"" %>>gmail.com</option>
                                    <option value="nate.com"  <%= "nate.com".equals(mail2) ?"selected":"" %>>nate.com</option>
                                </select>
                            </div>
                        </div>

                        <!-- 전화번호 -->
                         <div class="row">
                            <label class="textLabel">전화번호</label>
                            <div class="control">
                                <input type="text" name="phone"
                                       value="<%= phone %>"
                                       placeholder="예) 010-1234-5678">
                            </div>
                        </div>

                        <!-- 주소 -->
                        <div class="row">
                            <label class="textLabel">주소</label>
                            <div class="control divAddress">
                                <input type="text" name="address" value="<%= address %>">
                            </div>
                        </div>

                        <!-- 버튼 줄 -->
                        <div class="btnRow">
                            <button type="button" class="btn ghost" onclick="clearAll();">리셋</button>
                            <input type="submit" class="btn primary" value="정보 수정">
                            <button type="button" class="btn delete"
                                    onclick="if(confirmDelete()) location.href='memberDelete_process.jsp?id=<%= id %>';">
                                회원 탈퇴
                            </button>
                        </div>

                    </form>
                </div><!-- /.form-card -->

            </div><!-- /.signup-form -->

        </div><!-- /.container -->
    </div><!-- /.content -->

</div><!-- /#wrap -->

</body>
</html>
