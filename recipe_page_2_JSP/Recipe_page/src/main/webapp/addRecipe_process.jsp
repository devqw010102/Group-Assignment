<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="org.json.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 0. 로그인 세션 체크
    String memberId = (String)session.getAttribute("sessionId");
    if (memberId == null) {
        out.println("로그인 정보가 없습니다. 다시 로그인해 주세요.");
        return;
    }

    // 1. 파일 업로드용 MultipartRequest 생성
    //    /resources/images 실제 서버 경로 얻어서 그 안에 저장
    String uploadPath = application.getRealPath("/resources/images");
    String encType    = "UTF-8";
    int maxSize       = 5 * 1024 * 1024;   // 5MB

    MultipartRequest multi = null;
    try {
        multi = new MultipartRequest(
            request,
            uploadPath,
            maxSize,
            encType,
            new DefaultFileRenamePolicy()
        );
    } catch (Exception e) {
        e.printStackTrace();
        out.println("파일 업로드 중 오류가 발생했습니다: " + e.getMessage());
        return;
    }

    // 2. 파일명 처리 (input name="recipeImage")
    String fileName = "";
    String saved = multi.getFilesystemName("recipeImage");
    if (saved != null) {
        // 웹에서 접근할 때 쓸 상대 경로
        fileName = "resources/images/" + saved;
    }

    // 3. JSON + 날짜 파라미터 읽기
    String recipeJson = multi.getParameter("recipeJson");
    String dateNow    = multi.getParameter("dateNow");   // YYYY-MM-DD 형태

    if (recipeJson == null || recipeJson.trim().length() == 0) {
        out.println("레시피 데이터가 전달되지 않았습니다.");
        return;
    }

    // 4. JSON 파싱 후 image 필드 덮어쓰기
    JSONObject json = null;
    try {
        json = new JSONObject(recipeJson);
        json.put("image", fileName);   // 파일 없으면 "" 들어감
    } catch (Exception e) {
        e.printStackTrace();
        out.println("JSON 처리 중 오류가 발생했습니다: " + e.getMessage());
        return;
    }

    // 5. DB INSERT
    PreparedStatement pstmt = null;

    try {
        // date_now : DATE 컬럼 (YYYY-MM-DD 문자열 기준)
        String sql =
            "INSERT INTO recipe (date_now, member_id, json) " +
            "VALUES (TO_DATE(?, 'YYYY-MM-DD'), ?, ?)";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, dateNow);          // YYYY-MM-DD
        pstmt.setString(2, memberId);         // 세션의 로그인 아이디
        pstmt.setString(3, json.toString());  // 전체 JSON 문자열 저장

        int cnt = pstmt.executeUpdate();
        System.out.println("삽입된 레시피 행 수 : " + cnt);

        if (cnt > 0) {
            // 성공 시 메인(목록)으로 이동
            response.sendRedirect("index.jsp");
        } else {
            out.println("레시피 저장에 실패했습니다.");
        }

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("DB 오류: " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception ignore) {}
        try { if (conn  != null) conn.close(); } catch (Exception ignore) {}
    }
%>
