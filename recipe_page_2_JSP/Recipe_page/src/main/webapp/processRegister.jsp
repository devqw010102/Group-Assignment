<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file = "connection.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String type = request.getParameter("type");
	String id = request.getParameter("id");
	
	if("checkId".equals(type)) {
	    
		if(id.length() < 4 || id.length() > 20){
	        out.print("<span style='color:red'>아이디는 4~20글자여야 합니다.</span>");
	        return;
	    }
		
		String sql = "SELECT COUNT(*) FROM MEMBER WHERE ID = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
	    if(rs.getInt(1) > 0){
	        out.print("<span style='color:red'>❌ 이미 사용중인 아이디</span>");
	    } else {
	        out.print("<span style='color:green'>✔ 사용 가능한 아이디</span>");
	    }
	    
	    if(rs != null) rs.close();
	    if(pstmt != null) pstmt.close();
	    if(conn != null) conn.close();
	    
	    return;
	}

	// 필수	
	String pwd = request.getParameter("password");
	if ("checkPwd".equals(type)) {

		if(pwd.length() < 6 || pwd.length() > 20) {
			out.print("<span style='color:red'>아이디는 4~20글자여야 합니다.</span>");
			return;
		}
		
	    if(!pwd.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,20}$")) {
	        out.print("<span style='color:red'>영문+숫자 조합이어야 합니다.</span>");
	    } else {
	        out.print("<span style='color:green'>✔ 사용 가능한 비밀번호</span>");
	    }
	    return;
	}
	String name = request.getParameter("name");

	// null 처리
	String gender = request.getParameter("gender");
	String year = request.getParameter("birthyy");
	String month = request.getParameter("birthmm");
	String day = request.getParameter("birthdd");
	String birth = year + "/" + month + "/" + day;

	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameter("mail2");
	String mail = mail1 + "@" + mail2;

	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
%>

