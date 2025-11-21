<%@ page language="java" contentType="application/json; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // DB 연결
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String user = "scott";
    String password = "tiger";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    List<Map<String, Object>> list = new ArrayList<>();

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, password);
        String sql = "SELECT id, json, member_id FROM recipe";
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();

        while(rs.next()){
            Map<String, Object> map = new HashMap<>();
            map.put("id", rs.getInt("id"));
            map.put("member_id", rs.getString("member_id"));
            map.put("data", rs.getString("json")); // json 컬럼 자체는 String
            list.add(map);
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(rs!=null) rs.close();
        if(ps!=null) ps.close();
        if(conn!=null) conn.close();
    }

    // JSON 출력
    StringBuilder sb = new StringBuilder();
    sb.append("[");
    for(int i=0; i<list.size(); i++){
        Map<String,Object> m = list.get(i);
        sb.append("{\"id\":").append(m.get("id"))
        .append(",\"member_id\":\"").append(m.get("member_id")).append("\"")
        .append(",\"data\":").append(m.get("data"))
        .append("}");
        if(i < list.size()-1) sb.append(",");
    }
    sb.append("]");
    out.print(sb.toString());
%>