package co.dev.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.dev.common.Control;
import co.dev.service.NoticeService;
import co.dev.service.NoticeServiceMybatis;
import co.dev.vo.NoticeVO;

public class NoticeModifyControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		String nid = req.getParameter("nid");
		String title = req.getParameter("title");
		String subject = req.getParameter("subject");
		
		NoticeVO notice = new NoticeVO();
		notice.setNoticeId(Integer.parseInt(nid));
		notice.setNoticeTitle(title);
		notice.setNoticeSubject(subject);
		System.out.println(notice);
		
		//id 기준으로 title, subject 변경
		//서비스 : noticeModify(NoticeVO), mapper : updateNotice(NoticeVO)
		//완료 후 목록페이지로 이동
		
		NoticeService service = new NoticeServiceMybatis();
		if (service.noticeModify(notice)) {
			try {
				resp.sendRedirect("noticeList.do?page="+NoticeListControl.pageInfo.getPage());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			try {
				req.getRequestDispatcher("WEB-INF/notice/notice.jsp").forward(req, resp);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
	}

}
