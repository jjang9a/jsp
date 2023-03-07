package co.dev.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import co.dev.common.Control;
import co.dev.service.NoticeService;
import co.dev.service.NoticeServiceMybatis;
import co.dev.vo.NoticeVO;

public class NoticeAddControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		// 해야할 작업 : 첨부파일을 서버의 특정 위치에 업로드(cos.jar)
		//				ㄴMultipartRequest에 필요한 매개값(요청정보, 저장위치, 최대크기, 인코딩, 리네임정책)
		//			사용자의 입력값들 db에 입력처리, 목록으로 이동
		String dir = req.getServletContext().getRealPath("upload");
		System.out.println("dir : "+dir);
		int maxSize = 5 * 1024 * 1204; //5MB (Byte기준 : *1024 -> KB *1024 -> MB)
		String enc = "UTF-8";
		
		try {
			MultipartRequest multi = new MultipartRequest(req, dir, maxSize, enc, new DefaultFileRenamePolicy());
			//사용자 입력값 처리
			String title = multi.getParameter("title");
			String writer = multi.getParameter("writer");
			String subject = multi.getParameter("subject");
			String attach = multi.getFilesystemName("attach"); // 업로드 할 때의 파일이름이 아니라 업로드 하면서 리네임된 파일명을 담아둬야함
			
			NoticeVO vo = new NoticeVO();
			vo.setNoticeTitle(title);
			vo.setNoticeWriter(writer);
			vo.setNoticeSubject(subject);
			vo.setAttach(attach);
			
			NoticeService service = new NoticeServiceMybatis();
			if (service.addNotice(vo)) {
				// 정상 처리된 경우 - 목록이동
				resp.sendRedirect("noticeList.do");
			}else {
				try {
					req.getRequestDispatcher("WEB-INF/notice/noticeForm.jsp").forward(req, resp);
				} catch (ServletException e) {
					e.printStackTrace();
				}
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
