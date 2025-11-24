<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 로그인 세션 확인
    String sessionId = (String) session.getAttribute("sessionId");
    if (sessionId == null) {
        out.println("로그인이 필요합니다.");
        return;
    }

    // 폼에서 넘어온 값 받기
    String id       = request.getParameter("id");          // readonly 아이디
    String name     = request.getParameter("name");
    String gender   = request.getParameter("gender");
    String birthyy  = request.getParameter("birthyy");
    String birthmm  = request.getParameter("birthmm");
    String birthdd  = request.getParameter("birthdd");
    String mail1    = request.getParameter("mail1");
    String mail2    = request.getParameter("mail2");
    String phone    = request.getParameter("phone");
    String address  = request.getParameter("address");

    // 보안상: 세션 아이디와 폼 아이디가 다르면 막기
    if (id == null || !id.equals(sessionId)) {
        out.println("잘못된 접근입니다.");
        return;
    }

    // 생일 문자열 조합 (모두 입력됐을 때만)
    String birth = "";
    if (birthyy != null && birthmm != null && birthdd != null &&
        !birthyy.trim().equals("") &&
        !birthmm.trim().equals("") &&
        !birthdd.trim().equals("")) {

        birth = birthyy.trim() + "-" + birthmm.trim() + "-" + birthdd.trim();
    }

    // 이메일 문자열 조합
    String mail = "";
    if (mail1 != null && mail2 != null &&
        !mail1.trim().equals("") &&
        !mail2.trim().equals("")) {

        mail = mail1.trim() + "@" + mail2.trim();
    }

    PreparedStatement pstmt = null;

    try {
        // member 테이블 업데이트
        String sql =
            "UPDATE member " +
            "SET name = ?, gendar = ?, birth = ?, mail = ?, phone = ?, address = ? " +
            "WHERE id = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, gender);
        pstmt.setString(3, birth);
        pstmt.setString(4, mail);
        pstmt.setString(5, phone);
        pstmt.setString(6, address);
        pstmt.setString(7, id);

        int cnt = pstmt.executeUpdate();
        System.out.println("회원정보 수정된 행 수 : " + cnt);

        if (cnt > 0) {
            // 수정 성공 후 이동할 페이지
            response.sendRedirect("index.jsp");
        } else {
            out.println("회원 정보 수정에 실패했습니다.");
        }

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("DB 오류 : " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception ignore) {}
        try { if (conn  != null) conn.close(); } catch (Exception ignore) {}
    }
%>
