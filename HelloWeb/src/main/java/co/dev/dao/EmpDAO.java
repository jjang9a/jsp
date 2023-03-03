package co.dev.dao;

import java.util.ArrayList;
import java.util.List;

import co.dev.common.DAO;
import co.dev.vo.EmpVO;

public class EmpDAO extends DAO{

	public List<EmpVO> empList(){
		List<EmpVO> list = new ArrayList<>();
		getConn();
		String sql = "select * from employees";
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				EmpVO vo = new EmpVO();
				vo.setId(rs.getInt("employee_id"));
				vo.setFirst(rs.getString("first_name"));
				vo.setLast(rs.getString("last_name"));
				vo.setJob(rs.getString("job_id"));
				vo.setMail(rs.getString("email"));
				list.add(vo);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			disConn();
		}
		return list;
	}
}
