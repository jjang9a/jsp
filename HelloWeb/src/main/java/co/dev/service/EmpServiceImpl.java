package co.dev.service;

import java.util.List;

import co.dev.dao.EmpDAO;
import co.dev.vo.EmpVO;

public class EmpServiceImpl implements EmpService{
	
	EmpDAO dao = new EmpDAO();
	
	@Override
	public List<EmpVO> getEmps() {
		return dao.empList();
	}

}
