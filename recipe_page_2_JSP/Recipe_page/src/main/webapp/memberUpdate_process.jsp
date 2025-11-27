<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 1. 로그인 여부 확인
    String sessionId = (String)session.getAttribute("sessionId");
    if (sessionId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. 어떤 회원을 수정할지 (폼에서 넘어온 id)
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

    // 3. 폼 값 받기
    String name    = request.getParameter("name");      // ❗ 필수
    String gender  = request.getParameter("gender");    // 선택

    String birthyy = request.getParameter("birthyy");
    String birthmm = request.getParameter("birthmm");
    String birthdd = request.getParameter("birthdd");

    String mail1   = request.getParameter("mail1");
    String mail2   = request.getParameter("mail2");
    String rawPhone   = request.getParameter("phone");  // 사용자가 입력한 그대로
    String address = request.getParameter("address");

    if (name != null)   name   = name.trim();
    if (birthyy != null) birthyy = birthyy.trim();
    if (birthdd != null) birthdd = birthdd.trim();
    if (mail1 != null)  mail1  = mail1.trim();
    if (mail2 != null)  mail2  = mail2.trim();
    if (rawPhone != null) rawPhone = rawPhone.trim();
    if (address != null) address = address.trim();

    // 4. 생일 조합 (3개 중 하나라도 비어 있으면 birth는 null)
    String birth = null;
    boolean hasY = (birthyy != null && !birthyy.equals(""));
    boolean hasM = (birthmm != null && !birthmm.equals(""));
    boolean hasD = (birthdd != null && !birthdd.equals(""));

    if (hasY && hasM && hasD) {
        // yyyy-MM-dd 형태로 저장
        birth = birthyy + "-" + birthmm + "-" + birthdd;
    } else {
        // 세 칸 중 하나라도 비어 있으면 birth = null
        // (다른 정보는 정상적으로 수정되고, 알림은 그대로 '수정되었습니다' 출력)
        birth = null;
    }

    // 5. 이메일 조합 (둘 다 있을 때만)
    String email = null;
    if (mail1 != null && !mail1.equals("") &&
        mail2 != null && !mail2.equals("")) {
        email = mail1 + "@" + mail2;
    }

    // 6. 전화번호 정규식 검사 + '미입력' 처리
    String phone = null;
    if (rawPhone == null || rawPhone.equals("")) {
        // 리셋 후 수정: 빈 값이면 DB에는 '미입력' 저장
        phone = "미입력";
    } else {
        // 정규식 검사 (휴대전화/일반전화 예시)
        // 예) 010-1234-5678, 02-123-4567 등
        String phonePattern =
            "^(01[016-9]-\\d{3,4}-\\d{4}|0\\d{1,2}-\\d{3,4}-\\d{4})$";

        if (!rawPhone.matches(phonePattern)) {
            // 형식이 틀리면 다시 수정 페이지로
            response.sendRedirect("memberUpdate.jsp?error=2");
            return;
        }
        phone = rawPhone;
    }

    // 7. 필수값 체크 (아이디 + 이름만)
    if (id == null || id.trim().equals("") ||
        name == null || name.trim().equals("")) {

        response.sendRedirect("memberUpdate.jsp?error=1");
        return;
    }

    PreparedStatement pstmt = null;

    try {
        // 8. 비밀번호는 건드리지 않고 나머지만 수정
        String sql =
            "UPDATE member " +
            "SET name = ?, gender = ?, birth = ?, mail = ?, phone = ?, address = ? " +
            "WHERE id = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, gender);   // null 가능
        pstmt.setString(3, birth);    // 3칸 중 하나라도 비어 있으면 null
        pstmt.setString(4, email);    // null 가능
        pstmt.setString(5, phone);    // '미입력' 또는 정상 번호
        pstmt.setString(6, address);  // null 가능
        pstmt.setString(7, id);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<script>");
            out.println("alert('회원 정보가 수정되었습니다.');");
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
