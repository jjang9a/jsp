package co.edu.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class EmpDAO {
	Connection conn;
	public void connect() {
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, "hr", "hr");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
	
	public Map<String, Object> getEmpInpo(int empId){
		// {키:값}{키:값}{키:값}{키:값}{키:값} => result.get("키")값을 반환
		connect(); //conn객체.
		String sql = "select * from employees where employee_id = ?";
		Map<String, Object> result = new HashMap<>();
		try {
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setInt(1, empId);
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				result.put("id", rs.getInt("employee_id"));
				result.put("firstName", rs.getString("first_name"));
				result.put("lastName", rs.getString("last_name"));
				result.put("salary", rs.getInt("salary"));
				result.put("department", rs.getInt("department_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int insetEmp(Map<String, Object> in) {
		int result = 0;
		try {
			connect();
			String sql = "insert into employees (employee_id, first_name, last_name, hire_date, job_id, email) valuse (?,?,?,?,?)";
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setInt(1, (int) in.get("id"));
			psmt.setString(2, "first");
			psmt.setString(3, "last");
			psmt.setDate(4, "hire");
			
			ResultSet rs = psmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
