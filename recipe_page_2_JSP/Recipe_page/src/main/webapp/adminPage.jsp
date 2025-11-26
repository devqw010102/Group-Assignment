<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="connection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String adminId = (String)session.getAttribute("sessionId");
    if (adminId == null || !"admin".equals(adminId)) {
        out.println("관리자만 접근 가능합니다.");
        return;
    }

    String keyword = request.getParameter("keyword");
    if (keyword == null) keyword = "";

    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지 - 회원 관리</title>
    <link rel="stylesheet" href="resources/css/adminPage.css">
</head>

<body>
<div id="wrap">

    <%@ include file="menu.jsp" %>

    <div class="content">
        <div class="container">

            <div class="admin-title">관리자 페이지 - 회원 관리</div>

            <!-- 검색 -->
            <form class="admin-search" method="get" action="adminPage.jsp">
                <span>검색 (아이디 / 이름 / 이메일):</span>
                <input type="text" name="keyword" value="<%= keyword %>">
                <button type="submit">검색</button>
            </form>

            <table class="admin-table">
                <thead>
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>성별</th>
                    <th>이메일</th>
                    <th>가입일</th>
                    <th>레시피 수</th>
                    <th>관리</th>
                </tr>
                </thead>

                <tbody>
                <%
                    try {
                        String sql =
                            "SELECT m.id, m.name, m.gender, m.mail, " +
                            "       TO_CHAR(m.regist_day, 'YYYY-MM-DD') AS regist_day " +
                            "FROM member m ";

                        if (!keyword.trim().isEmpty()) {
                            sql += "WHERE m.id LIKE ? OR m.name LIKE ? OR m.mail LIKE ? ";
                        }

                        sql += "ORDER BY m.regist_day DESC";

                        pstmt = conn.prepareStatement(sql);

                        if (!keyword.trim().isEmpty()) {
                            String like = "%" + keyword.trim() + "%";
                            pstmt.setString(1, like);
                            pstmt.setString(2, like);
                            pstmt.setString(3, like);
                        }

                        rs = pstmt.executeQuery();

                        boolean hasRow = false;

                        while (rs.next()) {
                            String memberId = rs.getString("id");
                            if ("admin".equals(memberId)) {
                                continue;   
                            }

                            hasRow = true;  

                        %>
                <tr>
                    <td><%= rs.getString("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("gender") %></td>
                    <td><%= rs.getString("mail") %></td>
                    <td><%= rs.getString("regist_day") %></td>

                    <!-- 레시피 수는 일단 0(오류 회피) -->
                    <td>0</td>

                    <td>
                        <form method="post" action="admin_member_delete_process.jsp"
                              onsubmit="return confirm('<%= rs.getString("id") %> 회원을 삭제하시겠습니까?');"
                              style="display:inline;">
                            <input type="hidden" name="id" value="<%= rs.getString("id") %>">
                            <button type="submit" class="btn-small btn-delete">삭제</button>
                        </form>
                    </td>
                </tr>
                <%
                        }

                        if (!hasRow) {
                %>
              <c:if test="${empty memberList}">
					    <tr>
					      <td colspan="7" style="text-align:center;">검색 결과가 없습니다.</td>
					    </tr>
					  </c:if>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                <tr>
                    <td colspan="7">
                        회원 목록을 불러오는 중 오류가 발생했습니다.<br>
                        오류 메시지: <%= e.getMessage() %>
                    </td>
                </tr>
                <%
                    } finally {
                        try { if (rs != null) rs.close(); } catch(Exception ignore){}
                        try { if (pstmt != null) pstmt.close(); } catch(Exception ignore){}
                        try { if (conn != null) conn.close(); } catch(Exception ignore){}
                    }
                %>

                </tbody>
            </table>

        </div>
    </div>

</div>
</body>
</html>