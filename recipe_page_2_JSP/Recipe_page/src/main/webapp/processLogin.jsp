<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ include file = "connection.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	String type = request.getParameter("type");
	String id = request.getParameter("id");
	String pwd = request.getParameter("password");
	
	// Check Login
	
	if("checkAjax".equals(type)) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM member WHERE id = ? AND password = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				session.setAttribute("sessionId", id);
				out.print("success");
			}
			else {
				out.print("fail");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			out.println(e.getMessage());
		}
		finally {
			/*
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
			*/
		}
	}
%>

