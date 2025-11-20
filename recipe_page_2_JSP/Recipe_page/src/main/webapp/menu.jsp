<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>
<div class = "header">
    <div class = "headerLogo">
        <img src = "resources/images/recipe.png" id = "logo">
    </div>
    <div class = "navigate">
        <ul>
        	<li><a href = '<c:url value = "index.jsp"/>'>레시피</a></li>
        	<c:choose>
        		<c:when test = "${empty sessionId }">
        			<li><a href ='<c:url value = "login.jsp"/>'>로그인</a></li>		
        			<li><a href ='<c:url value = "register.jsp"/>'>회원가입</a></li>
        		</c:when>
        		<c:otherwise>
        			<li>[<%= sessionId %>님]</li>
        			<li><a href = '<c:url value = "logout.jsp"/>'>로그아웃</a></li>
		            <li><a href = '<c:url value = "memberUpdate.jsp"/>'>회원 수정</a></li>
        		</c:otherwise>
        	</c:choose>
        </ul>
    </div>
</div>