package com.example.demo;

import java.sql.*;

public class Main {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");

        PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Member");
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            var user = new Member(rs.getLong("id"), rs.getString("name"), rs.getString("email"), rs.getInt("age"));
            System.out.println(user);
        }
        connection.close();
    }
}
