package co.edu.test;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 자바 소스 : http 통신방법을 활용해서 request, response 생성 처리.
// HttpServlet 클래스를 상속받아서 사용.
// 서블릿의 실행 : 개발자X, Tomcat 컨테이너가 제어(Inversion Of Control(IOC): 제어의 역전)
// 순서 : 객체 생성 -> init -> service -> destroy
public class FirstServlet extends HttpServlet {

	public FirstServlet() {
		// 생성자 호출은 서블릿이 호출 될 때 한번만 실행
		System.out.println("생성자 호출. FirstServlet");
	}
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		// init 호출은 서블릿이 호출 될 때 한번만 실행
		System.out.println("init 호출. FirstServlet");
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// service 호출은 서블릿이 호출 될 때마다 실행
		System.out.println("service 호출. FirstServlet");
		
		if(req.getMethod().equals("GET")) {
			doGet(req,resp);
		}else if(req.getMethod().equals("POST")) {
			doPost(req, resp);
		}
	}
	
	@Override
	public void destroy() {
		System.out.println("destroy 호출. FirstServlet");
	}
	
	// 클라이언트 -> 서버요청 : get or post.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// get방식의 요청 : 주소창의 url, a href ="", <from method = "get">
		// 특징 : url 사용자가 입력값 노출. 용량제한.
		// 응답정보 -> 클라이언트 측으로 보내기
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter(); // 출력스트림 생성
		out.print("<h3>Get방식요청</h3>");
		// 사용자가 입력했던 값을 읽어오는 방법.
		String id = req.getParameter("id"); //first?id=guest&pw=1234
		String pw = req.getParameter("pw");
		out.print("<p>입력id: " + id + ", 비번 : "+pw+"</p>");
		out.close();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter(); // 출력스트림 생성
		out.print("<h3>Post방식요청</h3>");
		// 사용자가 입력했던 값을 읽어오는 방법.
		String id = req.getParameter("id"); //first?id=guest&pw=1234
		String pw = req.getParameter("pw");
		out.print("<p>입력id: " + id + ", 비번 : "+pw+"</p>");
		out.close();
	}

}
