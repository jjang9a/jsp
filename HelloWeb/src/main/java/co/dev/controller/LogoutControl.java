package co.dev.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import co.dev.common.Control;

public class LogoutControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession(); // 요청정보의 세션 정보를 가져오는 메소드
		session.invalidate(); // 세션정보를 삭제하는 메소드
		
		try {
			resp.sendRedirect("noticeList.do");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
