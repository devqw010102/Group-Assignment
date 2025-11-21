<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String json    = request.getParameter("recipeJson");
    String dateNow = request.getParameter("dateNow");

    
    String memberId = (String)session.getAttribute("sessionid");

    if (memberId == null) {
        out.println("로그인 정보가 없습니다. 다시 로그인하세요.");
        return;
    }

    PreparedStatement pstmt = null;

    try {
        String sql =
            "INSERT INTO recipe (date_now, member_id, json) " +
            "VALUES (TO_DATE(?, 'YYYY-MM-DD'), ?, ?)";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, dateNow);    
        pstmt.setString(2, memberId);   
        pstmt.setString(3, json);       

        int cnt = pstmt.executeUpdate();
        System.out.println("삽입된 행 수 : " + cnt);

        response.sendRedirect("index.jsp");

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("레시피 저장 실패: " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception ignore) {}
        try { if (conn  != null) conn.close(); } catch (Exception ignore) {}
    }
%>
