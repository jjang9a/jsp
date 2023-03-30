package co.prod.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.controller.CalendarListAjax;
import co.prod.controller.CalendatAddAjax;
import co.prod.controller.CalendatDeleteAjax;
import co.prod.controller.CarlendarControl;
import co.prod.controller.ChartAjax;
import co.prod.controller.ChartControl;
import co.prod.controller.CovidForm;
import co.prod.controller.MapForm;
import co.prod.controller.MemberAddAjax;
import co.prod.controller.MemberListAjax;
import co.prod.controller.MemberListControl;
import co.prod.controller.MemberRemoveAjax;
import co.prod.controller.MembersControl;
import co.prod.controller.ProductInfoControl;
import co.prod.controller.ProductListControl;
import co.prod.controller.ReplyAddAjax;
import co.prod.controller.ReplyListAjax;
import co.prod.controller.ReplyRemoveAjax;
import co.prod.controller.ReplySearchAjax;
import co.prod.controller.ReplyUpdateAjax;

public class FrontController extends HttpServlet {
	private Map<String, Control> map;
	public FrontController() {
		map = new HashMap<>();
	}
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		//url <-> control
		map.put("/memberList.do", new MemberListControl());
		map.put("/members.do", new MembersControl());
		map.put("/memberListAjax.do", new MemberListAjax());
		map.put("/memberRemoveAjax.do", new MemberRemoveAjax());
		map.put("/memberAddAjax.do", new MemberAddAjax());
		
		//상품 목록
		map.put("/productList.do", new ProductListControl());
		//상품 한 건 정보
		map.put("/productInfo.do", new ProductInfoControl());
		//댓글
		map.put("/replyListAjax.do", new ReplyListAjax());
		map.put("/replyRemoveAjax.do", new ReplyRemoveAjax());
		map.put("/replyAddAjax.do", new ReplyAddAjax());
		map.put("/replySearchAjax.do", new ReplySearchAjax());
		map.put("/replyUpdateAjax.do", new ReplyUpdateAjax());
		//차트
		map.put("/chart.do", new ChartControl());
		map.put("/chartAjax.do", new ChartAjax());
		map.put("/covid19.do",new CovidForm());
		map.put("/map.do", new MapForm());
		
		map.put("/calendar.do", new CarlendarControl());
		map.put("/calendarListAjax.do", new CalendarListAjax());
		map.put("/calendarAddAjax.do", new CalendatAddAjax());
		map.put("/calendarDeleteAjax.do", new CalendatDeleteAjax());
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String context = req.getContextPath();
		String page = uri.substring(context.length());
		System.out.println("do page : "+page);
		
		Control command = map.get(page);
		String viewPage = command.exec(req, resp); // product/productlist.tiles가 넘어옴
		
		if(viewPage.endsWith(".jsp")) {
			viewPage = "/WEB-INF/views/" + viewPage;
//		}else if(viewPage.endsWith(".tiles")) {	
		} else if(viewPage.endsWith(".ajax")) {
			resp.setContentType("text/json;charset=utf-8");
			resp.getWriter().append(viewPage.substring(0, viewPage.length()-5));
			return;
		}
		
		RequestDispatcher rd = req.getRequestDispatcher(viewPage);
		rd.forward(req, resp);
		
	}

}
