<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>	
<%@ page import = "org.json.*" %>
<%@ page import="java.io.File" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	// String realFolder = "E:\\KBK\\Task\\recipe_page_2_JSP\\Recipe_page\\src\\main\\webapp\\resources\\images";
	String realFolder = application.getRealPath("/resources/images");
	String encType = "UTF-8";
	int maxSize = 5 * 1024 * 1024;
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String uploadedFile = multi.getFilesystemName("imageFile");
	String oldFile = multi.getParameter("oldFile"); // 기존 DB 이미지

	String fileName;

	if(uploadedFile != null && !uploadedFile.equals("")) {
	    fileName = "resources/images/" + uploadedFile;

	    // 기존 이미지가 있고, 새 이미지와 다르면 삭제
	    if(oldFile != null && !oldFile.equals("") && !oldFile.equals(fileName)) {
	        File oldImg = new File(application.getRealPath("/") + oldFile);
	        if(oldImg.exists()) {
	            boolean deleted = oldImg.delete();
	            System.out.println("이전 이미지 삭제: " + deleted);
	        }
	    }
	} else {
	    // 업로드 없으면 기존 파일 유지
	    fileName = oldFile;
	}
	
	
	String recipe_json = multi.getParameter("recipeJson");
	JSONObject obj = new JSONObject(recipe_json);
	obj.put("image", fileName);
	
	String recipe_id = multi.getParameter("recipe_id");
	
	// out.println(recipe_id);
	// out.println(fileName);
	// out.println(obj);
	
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
	
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");
		
		String sql = "UPDATE recipe SET json = ? WHERE id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, obj.toString());
		pstmt.setString(2, recipe_id);
		
		int result = pstmt.executeUpdate();
		System.out.println("Update : " + result);
		
		if(result > 0) 
			response.sendRedirect("index.jsp");
	}
	catch(Exception e) {
		e.printStackTrace();
		out.println(e.getMessage());
	}
	finally {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
	
%>