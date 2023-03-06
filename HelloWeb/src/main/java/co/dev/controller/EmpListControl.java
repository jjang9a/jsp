package co.dev.controller;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.dev.common.Control;
import co.dev.service.EmpService;
import co.dev.service.EmpServiceImpl;
import co.dev.vo.EmpVO;

public class EmpListControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		EmpService service = new EmpServiceImpl();
		List<EmpVO> list = service.getEmps();
		req.setAttribute("emp", list);
		
		RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/emp/empList.jsp");
		try {
			rd.forward(req, resp);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
