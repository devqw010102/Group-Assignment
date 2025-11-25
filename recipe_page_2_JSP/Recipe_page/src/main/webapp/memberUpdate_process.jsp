<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 로그인 여부 확인
    String sessionId = (String)session.getAttribute("sessionId");
    if (sessionId == null) {
        out.println("로그인 후 이용해주세요.");
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

    // 생일 조합 (모두 입력된 경우에만)
    String birth = null;
    if (birthyy != null && !birthyy.trim().equals("") &&
        birthmm != null && !birthmm.trim().equals("") &&
        birthdd != null && !birthdd.trim().equals("")) {

        birth = birthyy + "-" + birthmm + "-" + birthdd;   // 예: 1999-03-15
    }

    // 이메일 조합
    String email = null;
    if (mail1 != null && !mail1.trim().equals("") &&
        mail2 != null && !mail2.trim().equals("")) {
        email = mail1 + "@" + mail2;
    }

    // 🔹 간단 입력 유효성 체크
    // 원하는 조건 더 추가해도 됨 (예: 전화번호 길이, 이름 최소 글자 수 등)
    if (name == null || name.trim().equals("") ||
        phone == null || phone.trim().equals("") ||
        email == null || email.trim().equals("")) {

        // 값이 이상하면 다시 수정 페이지로 돌려보내기
        // 필요하면 error 코드/메시지 더 붙여도 됨
        response.sendRedirect("memberUpdate.jsp?error=1");
        return;
    }

    PreparedStatement pstmt = null;

    try {
        String sql =
            "UPDATE member " +
            "SET name = ?, gender = ?, birth = ?, mail = ?, phone = ?, address = ? " +
            "WHERE id = ?";

        pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, name);
        pstmt.setString(2, gender);
        pstmt.setString(3, birth);      // null이면 DB에 null로 들어감
        pstmt.setString(4, email);
        pstmt.setString(5, phone);
        pstmt.setString(6, address);
        pstmt.setString(7, id);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 수정 성공 → 다시 수정 페이지로 이동
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
