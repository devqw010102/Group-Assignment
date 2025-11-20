<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/plain; charset=UTF-8");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		StringBuilder sb = new StringBuilder();
		String line;
		
		while((line = request.getReader().readLine()) != null) {
			sb.append(line);
		}
		
		JSONObject json = new JSONObject(sb.toString());
		int id = json.getInt("id");
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");
		
		String sql = "DELETE FROM recipe WHERE ID = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		
		int count = pstmt.executeUpdate();
		
		if(count > 0) {
			out.print("DELETE_OK");
		}
		else {
			out.print("DELETE_FAIL");
		}
	}
	catch(Exception e) {
		e.printStackTrace();
		out.print("DELETE_FAIL");
	}
	finally {
		if(pstmt != null) try { pstmt.close(); } catch(Exception e){}
	    if(conn != null) try { conn.close(); } catch(Exception e){}
	}
%>