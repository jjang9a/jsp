package co.prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.common.Control;
import co.prod.service.MemberService;
import co.prod.service.MemberServiceMybatis;

public class MemberRemoveJquery implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String[] members = request.getParameterValues("memberId");
		for (String member:members) {
			System.out.println(members); // for문 내용이 1줄인 경우에 중괄호 안써두 됨
		}
		MemberService service = new MemberServiceMybatis();
		service.removeMemberAry(members);
		
		String json = "{\"retCode\" : \"Success\"}";
		return json + ".ajax";
	}
}
