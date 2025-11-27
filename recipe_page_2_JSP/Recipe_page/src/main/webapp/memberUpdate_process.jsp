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

    // 4. 생일 조합 (연/월/일이 모두 있을 때만)
    String birth = null;
    if (birthyy != null && !birthyy.trim().equals("") &&
        birthmm != null && !birthmm.trim().equals("") &&
        birthdd != null && !birthdd.trim().equals("")) {

        birth = birthyy + "-" + birthmm + "-" + birthdd;
    }

    // 5. 이메일 조합 (둘 다 있을 때만)
    String email = null;
    if (mail1 != null && !mail1.trim().equals("") &&
        mail2 != null && !mail2.trim().equals("")) {
        email = mail1.trim() + "@" + mail2.trim();
    }

    // 6. 필수값 체크 (아이디 + 이름만)
    if (id == null || id.trim().equals("") ||
        name == null || name.trim().equals("")) {

        // 이름이 비어있으면 다시 수정 페이지로
        response.sendRedirect("memberUpdate.jsp?error=1");
        return;
    }
    
    // 전화번호, 주소 null 처리
	if(phone == null || phone.trim().equals("")) {
		phone = "미입력";
	}
    if(address == null || address.trim().equals("")) {
    	address = "미입력";
    }
    	
    // 전화번호 정규식
    
    PreparedStatement pstmt = null;

    try {
        String sql =
            "UPDATE member " +
            "SET name = ?, gender = ?, birth = ?, mail = ?, phone = ?, address = ? " +
            "WHERE id = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, gender);   // null 가능
        pstmt.setString(3, birth);    // null 가능
        pstmt.setString(4, email);    // null 가능
        pstmt.setString(5, phone);    // null 가능
        pstmt.setString(6, address);  // null 가능
        pstmt.setString(7, id);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<script>");
            out.println("alert('회원 정보가 저장되었습니다.');");
            out.println("location.href='memberUpdate.jsp';");
            out.println("</script>");
            return;
        } else {
            out.println("<script>");
            out.println("alert('수정 실패: 회원 정보를 찾을 수 없습니다.');");
            out.println("history.back();");
            out.println("</script>");
            return;
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("회원 수정 중 오류 발생: " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception ignore) {}
        try { if (conn   != null) conn.close(); } catch (Exception ignore) {}
    }
%>