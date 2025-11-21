<%
    String memberId = (String)session.getAttribute("sessionId");

    response.setContentType("application/json; charset=utf-8");
    out.print("{\"sessionId\": \"" + memberId + "\"}");
%>
