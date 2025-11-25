<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 1. 폼 파라미터 받기
    String id       = request.getParameter("id");
    String password = request.getParameter("password");
    String name     = request.getParameter("name");
    String gender   = request.getParameter("gender");   // 남 / 여

    String year  = request.getParameter("birthyy");
    String month = request.getParameter("birthmm");
    String day   = request.getParameter("birthdd");
    String birth = null;
    if (year != null && month != null && day != null &&
        !year.isEmpty() && !month.isEmpty() && !day.isEmpty()) {
        birth = year + "-" + month + "-" + day;
    }

    String mail1 = request.getParameter("mail1");
    String mail2 = request.getParameter("mail2");
    String mail  = null;
    if (mail1 != null && mail2 != null && !mail1.isEmpty() && !mail2.isEmpty()) {
        mail = mail1 + "@" + mail2;
    }

    String phone   = request.getParameter("phone");
    String address = request.getParameter("address");

    // 2. 필수값 체크 (아이디 / 비밀번호 / 이름 정도만)
    if (id == null || id.trim().isEmpty()) {
        out.println("아이디가 입력되지 않았습니다.");
        return;
    }
    if (password == null || password.trim().isEmpty()) {
        out.println("비밀번호가 입력되지 않았습니다.");
        return;
    }
    if (name == null || name.trim().isEmpty()) {
        out.println("이름이 입력되지 않았습니다.");
        return;
    }

    // (디버깅용) 실제 들어가는 값 한 번 찍어보기
    System.out.println("REGISTER id=" + id + ", name=" + name + ", mail=" + mail);

    PreparedStatement pstmt = null;

    try {
        // 3. INSERT SQL 작성
        //   ※ 지금 member 테이블 컬럼명이 'gender' 인지 'gendar' 인지 꼭 확인
        String sql =
            "INSERT INTO member " +
            " (id, password, name, gender, birth, mail, phone, address, regist_day) " +
            " VALUES (?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";

        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, id);
        pstmt.setString(2, password);
        pstmt.setString(3, name);
        pstmt.setString(4, gender);
        pstmt.setString(5, birth);
        pstmt.setString(6, mail);
        pstmt.setString(7, phone);
        pstmt.setString(8, address);

        int result = pstmt.executeUpdate();
        System.out.println("member INSERT result = " + result);

        // 4. 가입 성공 → 세션에 로그인 아이디 저장 → 메인으로 이동
        session.setAttribute("sessionId", id);
        response.sendRedirect("index.jsp");

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("회원가입 중 오류 발생: " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch(Exception ignore) {}
        try { if (conn  != null) conn.close(); } catch(Exception ignore) {}
    }
%>
