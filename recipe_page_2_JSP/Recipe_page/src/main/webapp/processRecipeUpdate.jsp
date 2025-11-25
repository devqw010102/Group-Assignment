<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>	
<%@ page import = "org.json.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String realFolder = "E:\\KBK\\Task\\recipe_page_2_JSP\\Recipe_page\\src\\main\\webapp\\resources\\images";
	String encType = "UTF-8";
	int maxSize = 5 * 1024 * 1024;
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String uploadedFile = multi.getFilesystemName("imageFile");
	String oldFile = multi.getParameter("oldFile");            
	
	String fileName;
	if(uploadedFile != null) {
		fileName = "resources/images/" + uploadedFile;
	}
	else {
		fileName = oldFile;
	}
	
	
	String recipe_json = multi.getParameter("recipeJson");
	JSONObject obj = new JSONObject(recipe_json);
	obj.put("image", fileName);
	
	String recipe_id = multi.getParameter("recipe_id");
	
	out.println(recipe_id);
	out.println(fileName);
	out.println(obj);
	
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