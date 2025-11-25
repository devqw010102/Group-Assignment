<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 관리자 검증
    String sessionId = (String)session.getAttribute("sessionId");
    if (sessionId == null || !"admin".equals(sessionId)) {
        out.println("관리자만 접근 가능합니다.");
        return;
    }

    String id = request.getParameter("id");
    if (id == null || id.trim().equals("")) {
        out.println("잘못된 접근입니다.");
        return;
    }

    PreparedStatement pstmt = null;

    try {
        // 회원이 작성한 레시피 먼저 삭제
        String delRecipe = "DELETE FROM recipe WHERE member_id = ?";
        pstmt = conn.prepareStatement(delRecipe);
        pstmt.setString(1, id);
        pstmt.executeUpdate();
        pstmt.close();

        // 회원 삭제
        String delMember = "DELETE FROM member WHERE id = ?";
        pstmt = conn.prepareStatement(delMember);
        pstmt.setString(1, id);
        pstmt.executeUpdate();

        response.sendRedirect("adminPage.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("회원 삭제 중 오류 발생: " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception ignore) {}
        try { if (conn   != null) conn.close(); } catch (Exception ignore) {}
    }
%>