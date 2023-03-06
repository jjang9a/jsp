package co.dev.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.dev.common.Control;

public class MainControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		RequestDispatcher rd =  req.getRequestDispatcher("WEB-INF/main/main.jsp"); //member폴더 안의 member.jsp로 페이지를 재 요청
		try {
			rd.forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
		} //페이지 재 지정
	}

}
