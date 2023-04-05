package co.prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.common.Control;
import co.prod.service.MemberService;
import co.prod.service.MemberServiceMybatis;

public class DataTableDelete implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		int empId = Integer.parseInt(request.getParameter("empId"));
		System.out.println("=============="+empId);
		MemberService service = new MemberServiceMybatis();
		String json = "";
		if(service.delEmp(empId)) {
			json = "{\"retCode\" : \"Success\"}";
		}else {
			json = "{\"retCode\" : \"Fail\"}";
		}
		return json + ".ajax";
	}

}
