package co.dev.controller;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.dev.common.Control;
import co.dev.service.MemberService;
import co.dev.service.MemberServiceImpl;
import co.dev.vo.MemberVO;

public class MemberListControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		// 회원 목록을 보여주는 페이지 /WEB-INF/member/memberList.jsp
		MemberService service = new MemberServiceImpl();
		service.getMembers();
		List<MemberVO> list = service.getMembers();
		
		req.setAttribute("members", list); // context : sc.setAttribute("param", map)
		
		RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/member/memberList.jsp");
		try {
			rd.forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
		} // 페이지 재지정.
	}

}
