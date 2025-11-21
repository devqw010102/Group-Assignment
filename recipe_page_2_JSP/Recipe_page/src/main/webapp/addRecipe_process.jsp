<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>	

<%
    request.setCharacterEncoding("UTF-8");

	String realFolder = "E:\\KBK\\Task\\recipe_page_2_JSP\\Recipe_page\\src\\main\\webapp\\resources\\images";
	String encType = "UTF-8";
	int maxSize = 5 * 1024 * 1024;
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

	// 파일 처리
	String fileName = "";
	Enumeration files = multi.getFileNames();

	if (files.hasMoreElements()) {  // 파일이 있을 경우에만
	    String fname = (String) files.nextElement();
	    fileName = "resources/images/" + multi.getFilesystemName(fname);
	}
	
	String memberId = (String)session.getAttribute("sessionId");
    // String json    = request.getParameter("recipeJson");
    String recipeJson = multi.getParameter("recipeJson");
    org.json.JSONObject json = new org.json.JSONObject(recipeJson);
    json.put("image", fileName);   // fileName이 비어있으면 "" 저장

    System.out.println(json);
    
    if (memberId == null) {
        out.println("로그인 정보가 없습니다. 다시 로그인하세요.");
        return;
    }

    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String user = "scott";
    String password = "tiger";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
    	Class.forName("oracle.jdbc.driver.OracleDriver");
    	conn = DriverManager.getConnection(url, user, password);
    	   
        String sql = "INSERT INTO recipe(member_id, json) VALUES(?, ?)"; 

        pstmt = conn.prepareStatement(sql);    
        pstmt.setString(1, memberId);   
        pstmt.setString(2, json.toString());       

        int result = pstmt.executeUpdate();
        System.out.println("삽입된 행 수 : " + result);

        if( result > 0) 
        	response.sendRedirect("index.jsp");

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("레시피 저장 실패: " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception ignore) {}
        try { if (conn  != null) conn.close(); } catch (Exception ignore) {}
    }
%>