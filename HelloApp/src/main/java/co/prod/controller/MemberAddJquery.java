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
import co.prod.vo.MembersVO;

public class MemberAddJquery implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		MembersVO vo = new MembersVO();
		vo.setMemberId(request.getParameter("id"));
		vo.setMemberName(request.getParameter("name"));
		vo.setMemberAddr(request.getParameter("addr"));
		vo.setMemberPw(request.getParameter("pw"));		
		vo.setMemberTel(request.getParameter("tel"));
		
		MemberService service = new MemberServiceMybatis();
		Gson gson = new GsonBuilder().create();
		String json = "";
		Map<String, Object> map = new HashMap<>();
		if(service.addNewMember(vo)) {
			map.put("retCode", "Success");
			map.put("member", vo);
		}else {
			map.put("retCode", "Fail");
			map.put("member", null);
		}
		json = gson.toJson(map);
		return json + ".ajax";
	}

}
