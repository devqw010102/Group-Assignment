<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 로그인 여부 확인
    String sessionId = (String)session.getAttribute("sessionId");
    if (sessionId == null) {
    	response.sendRedirect("login.jsp");
        return;
    }

    // 어떤 회원을 수정할지
    String id = request.getParameter("id");
    if (id == null || id.trim().equals("")) {
        out.println("잘못된 접근입니다. (id 없음)");
        return;
    }

    // admin이면 아무나 수정 가능 / 일반 회원은 본인만 가능
    if (!"admin".equals(sessionId) && !sessionId.equals(id)) {
        out.println("본인만 수정할 수 있습니다.");
        return;
    }

    // 폼에서 넘어온 값들
    String name    = request.getParameter("name");
    String gender  = request.getParameter("gender");

    String birthyy = request.getParameter("birthyy");
    String birthmm = request.getParameter("birthmm");
    String birthdd = request.getParameter("birthdd");

    String mail1   = request.getParameter("mail1");
    String mail2   = request.getParameter("mail2");
    String phone   = request.getParameter("phone");
    String address = request.getParameter("address");

    // 🔹 비밀번호 / 비밀번호 확인 (필수)
    String password          = request.getParameter("password");
    String password_confirm  = request.getParameter("password_confirm");

    // 생일 조합 (모두 입력된 경우에만)
    String birth = null;
    if (birthyy != null && !birthyy.trim().equals("") &&
        birthmm != null && !birthmm.trim().equals("") &&
        birthdd != null && !birthdd.trim().equals("")) {

        birth = birthyy + "-" + birthmm + "-" + birthdd;   // 예: 1999-03-15
    }

    
    String email = null;
    if (mail1 != null && !mail1.trim().equals("") &&
        mail2 != null && !mail2.trim().equals("")) {
        email = mail1.trim() + "@" + mail2.trim();
    }

    
    if (id == null || id.trim().equals("") ||
        name == null || name.trim().equals("") ||
        password == null || password.trim().equals("") ||
        password_confirm == null || password_confirm.trim().equals("") ||
        !password.equals(password_confirm)) {

    
        response.sendRedirect("memberUpdate.jsp?error=1");
        return;
    }

    PreparedStatement pstmt = null;

    try {
        String sql =
            "UPDATE member " +
            "SET name = ?, password = ?, gender = ?, birth = ?, mail = ?, phone = ?, address = ? " +
            "WHERE id = ?";

        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, name);
        pstmt.setString(2, password);   
        pstmt.setString(3, gender);
        pstmt.setString(4, birth);     
        pstmt.setString(5, email);      
        pstmt.setString(6, phone);      
        pstmt.setString(7, address);    
        pstmt.setString(8, id);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            
            response.sendRedirect("memberUpdate.jsp");
        } else {
            out.println("수정 실패: 회원 정보를 찾을 수 없습니다.");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("회원 수정 중 오류 발생: " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception ignore) {}
        try { if (conn   != null) conn.close(); } catch (Exception ignore) {}
    }
%>
