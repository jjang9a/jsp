package co.prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.common.Control;
import co.prod.service.MemberService;
import co.prod.service.MemberServiceMybatis;

public class MemberRemoveAjax implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 삭제 할 아이디를 받아와야 함 -> 파라미터에 넘겨줌 = 삭제 처리의 매개값
		MemberService service = new MemberServiceMybatis();
		boolean result = service.removeMember(request.getParameter("id"));
		String json = "";
		if(result) { // {"retCode" : "Success"}
			json = "{\"retCode\" : \"Success\"}";
		}else { // {"retCode" : "Fail"}
			json = "{\"retCode\" : \"Fail\"}";
		}
		return json + ".ajax";
	}

}
