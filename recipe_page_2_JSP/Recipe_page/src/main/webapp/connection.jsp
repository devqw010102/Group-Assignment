<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>Test_Page</title>
</head>
<body>
	<%
		Connection conn = null;
	
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "scott";
			String password = "tiger";
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			out.println("데이터베이스 연결 성공");
		}
		catch(SQLException ex) {
			out.println("데이터베이스 연결 실패<br>");
			out.println(ex.getMessage());
		}
		finally {
			if(conn != null)
				conn.close();	
		}
	%>
</body>
</html>