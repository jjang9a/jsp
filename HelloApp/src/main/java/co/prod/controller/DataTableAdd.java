package co.prod.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prod.common.Control;
import co.prod.service.MemberService;
import co.prod.service.MemberServiceMybatis;
import co.prod.vo.EmpVO;

public class DataTableAdd implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		EmpVO vo = new EmpVO();
		vo.setFirstName(request.getParameter("first"));
		vo.setLastName(request.getParameter("last"));
		vo.setEmail(request.getParameter("email"));
		vo.setHireDate(request.getParameter("hireDate"));
		vo.setSalary(Integer.parseInt(request.getParameter("salary")));
		
		MemberService service = new MemberServiceMybatis();
		Map<String, Object> map = new HashMap<>();
		if(service.addEmp(vo)) {
			map.put("retCode", "Success");
			map.put("emp", vo);
		} else {
			map.put("retCode", "Fail");
			map.put("emp", null);
		}
		Gson gson = new GsonBuilder().create();
		String json = gson.toJson(map);
		
		return json + ".ajax";
	}

}
