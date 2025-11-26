<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file = "connection.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String type = request.getParameter("type");
	
	// id 체크(ajax)
	String id = request.getParameter("id");
	if("checkId".equals(type)) {
	    
		if(id.length() < 4 || id.length() > 20){
	        out.print("<span style='color:red'>4 ~ 20자 이내여야 합니다.</span>");
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
	        out.print("<span style='color:green'>✔</span>");
	    }
	    
	    if(rs != null) rs.close();
	    if(pstmt != null) pstmt.close();
	    if(conn != null) conn.close();
	    
	    return;
	}

	// pwd 체크(ajax)
	String pwd = request.getParameter("password");
	if ("checkPwd".equals(type)) {

		if(pwd.length() < 6 || pwd.length() > 20) {
			out.print("<span style='color:red'>❌ 6 ~ 20 자 이내여야 합니다.</span>");
			return;
		}
		
	    if(!pwd.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,20}$")) {
	        out.print("<span style='color:red'>❌ 영문+숫자 조합이어야 합니다.</span>");
	    } else {
	        out.print("<span style='color:green'>✔</span>");
	    }
	    return;
	}
	
	// pwd 재확인 체크(ajax)
	String confirm = request.getParameter("confirm");
	if("checkPwdCon".equals(type)) {
		
		if(pwd.equals(confirm)) {
			out.print("<span style='color:green'>✔</span>");
		}
		else {
			out.print("<span style='color:red'>❌</span>");
		}
		return;
	}
	
	// 이름 체크(ajax)
	String name = request.getParameter("name");
	if("checkName".equals(type)) {
		if(name.length() > 10) {
			out.print("<span style='color:red'>❌ 10 자 이내여야 합니다.</span>");
		}
		else {
			out.print("<span style='color:green'>✔</span>");
		}
		return;
	}
	
	// null 처리
	String gender = request.getParameter("gender");
	if(gender == null) {
		gender = "미입력";
	}
		
	String year = request.getParameter("birthyy");
	String month = request.getParameter("birthmm");
	String day = request.getParameter("birthdd");
	
    // 생일 조합 (모두 입력된 경우에만)
    String birth = null;
    if (year != null && !year.trim().equals("") &&
   		month != null && !month.trim().equals("") &&
		day != null && !day.trim().equals("")) {

        birth = year + "-" + month + "-" + day;
    }
	
 	// 이메일 조합
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameter("mail2");
    String email = null;
    if (mail1 != null && !mail1.trim().equals("") &&
        mail2 != null && !mail2.trim().equals("")) {
        email = mail1 + "@" + mail2;
    }

    // 전화번호
	String phone = request.getParameter("phone");
    if(phone == null) {
    	phone = "미입력";
    }
	String address = request.getParameter("address");
	if(address == null) {
		address = "미입력";
	}
	
	PreparedStatement pstmt = null;
	try {
		String sql = "INSERT INTO member(id, password, name, gender, birth, mail, phone, address)" + 
					 "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pwd);
		pstmt.setString(3, name);
		pstmt.setString(4, gender);
		pstmt.setString(5, birth);
		pstmt.setString(6, email);
		pstmt.setString(7, phone);
		pstmt.setString(8, address);
		
		int result = pstmt.executeUpdate();
		System.out.println("Register : " + result);
		
		if(result > 0) {
			session.setAttribute("sessionId", id);
			response.sendRedirect("index.jsp");
		}	
	}
	catch(Exception e) {
		e.printStackTrace();
		out.println(e.getMessage());
	}
	finally {
		
	}
%>

