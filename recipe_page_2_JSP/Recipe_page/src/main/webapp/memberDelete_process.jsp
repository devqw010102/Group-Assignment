<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String sessionId = (String)session.getAttribute("sessionId");
    if (sessionId == null) {
        out.println("로그인 후 이용해주세요.");
        return;
    }

    String id = request.getParameter("id");
    if (id == null || id.trim().equals("")) {
        out.println("삭제할 회원 정보가 없습니다.");
        return;
    }

    // admin이면 아무나 삭제 가능 / 일반 회원은 본인만 삭제 가능
    if (!sessionId.equals("admin") && !sessionId.equals(id)) {
        out.println("본인만 탈퇴/삭제할 수 있습니다.");
        return;
    }

    PreparedStatement pstmtRecipe = null;
    PreparedStatement pstmtMember = null;

    try {
        // 트랜잭션 시작
        conn.setAutoCommit(false);

        // 1) 이 회원이 작성한 레시피 먼저 삭제 (FK 에러 방지용)
        //    recipe 테이블과 컬럼명이 실제랑 다르면 여기를 맞춰줘야 함
        try {
            String sqlRecipe = "DELETE FROM recipe WHERE member_id = ?";
            pstmtRecipe = conn.prepareStatement(sqlRecipe);
            pstmtRecipe.setString(1, id);
            pstmtRecipe.executeUpdate();
        } catch (Exception e) {
            // recipe 테이블이 없거나 컬럼명이 다르면 여기서 에러날 수 있음
            // 그 경우엔 이 블럭을 주석 처리하거나, 테이블/컬럼명 맞춰서 수정
        }

        // 2) member 삭제
        String sqlMember = "DELETE FROM member WHERE id = ?";
        pstmtMember = conn.prepareStatement(sqlMember);
        pstmtMember.setString(1, id);

        int result = pstmtMember.executeUpdate();

        if (result > 0) {
            conn.commit();

            // 본인 계정을 삭제한 경우에만 세션 종료
            if (sessionId.equals(id)) {
                session.invalidate();
            }

            // 삭제 후 이동할 페이지
            response.sendRedirect("index.jsp");
        } else {
            conn.rollback();
            out.println("삭제 실패: 회원 정보를 찾을 수 없습니다.");
        }

    } catch (Exception e) {
        try { conn.rollback(); } catch (Exception ignore) {}
        e.printStackTrace();
        out.println("회원 삭제 중 오류 발생: " + e.getMessage());
    } finally {
        try { if (pstmtRecipe != null) pstmtRecipe.close(); } catch (Exception ignore) {}
        try { if (pstmtMember != null) pstmtMember.close(); } catch (Exception ignore) {}
        try { if (conn != null) conn.close(); } catch (Exception ignore) {}
    }
%>
