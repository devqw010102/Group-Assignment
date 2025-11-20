<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pwd = request.getParameter("password");
%>

<sql:setDataSource var = "dataSource" url = "jdbc:oracle:thin:@localhost:1521:xe" driver = "oracle.jdbc.driver.OracleDriver" user = "scott" password = "tiger"/>

<sql:query dataSource = "${dataSource }" var = "resultSet">
	SELECT * FROM MEMBER WHERE ID = ? AND PASSWORD = ?
	<sql:param value = "<%=id %>" />
	<sql:param value = "<%=pwd %>" />
</sql:query>

<c:forEach var = "row" items = "${resultSet.rows }">
	<%
		session.setAttribute("sessionId", id);
	%>
	<c:redirect url = "index.jsp" />
</c:forEach>

<c:redirect url = "login.jsp?error=1"/>