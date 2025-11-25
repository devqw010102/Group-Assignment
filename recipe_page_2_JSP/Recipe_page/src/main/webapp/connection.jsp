<%@ page import="java.sql.*" %>
<%
    // Oracle DB 접속 정보
    String driver   = "oracle.jdbc.driver.OracleDriver";
    String url      = "jdbc:oracle:thin:@localhost:1521:XE"; // DB 서버에 맞게 수정
    String dbUser   = "scott"; // DB 계정
    String dbPass   = "tiger"; // DB 비밀번호

    Connection conn = null;

    try {
        // 1. 드라이버 로딩
        Class.forName(driver);

        // 2. 커넥션 생성
        conn = DriverManager.getConnection(url, dbUser, dbPass);

        // 자동 커밋 비활성화 (필요 시)
        // conn.setAutoCommit(false);

    } catch (ClassNotFoundException e) {
        out.println("Oracle JDBC 드라이버 로딩 실패");
        e.printStackTrace();
    } catch (SQLException e) {
        out.println("DB 연결 실패");
        e.printStackTrace();
    }
%>
