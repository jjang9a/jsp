package co.edu.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.edu.jdbc.EmpDAO;

@WebServlet("/getUserInfo")
public class JdbcServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		EmpDAO dao = new EmpDAO();
		
		// get or post 요청을 구분해서 처리
		// get이면 조회, post이면 입력
		String eid = req.getParameter("empId");
		req.setCharacterEncoding("utf-8"); //요청 정보에 있는 인코딩 방식을 지정.
		resp.setCharacterEncoding("utf-8"); //응답정보의 인코딩 방식 지정.
		resp.setContentType("text/html;charset=utf-8"); //컨텐트 타입 지정.
		PrintWriter out = resp.getWriter();
		
		if(req.getMethod().equals("GET")) {
			//조회용으로 Get방식 처리
			
			int empId = Integer.parseInt(eid);
			//페이지 출력 - 사번/이름(이름+성씨),급여/부서
	//		PrintWriter out = resp.getWriter();
			
			Map<String, Object> result = dao.getEmpInpo(empId);
			//페이지 작성
			// {키:값}{키:값}{키:값}{키:값}{키:값} => result.get("키")값을 반환
			String html = "<html><head><title>사원 정보</title></head>";
			html += "사원번호 : "+result.get("id") + "<br>";
			html += "이름 : " + result.get("firstName");
			html += result.get("lastName") + "<br>";
			html += "급여 : " + result.get("salary") + "<br>";
			html += "부서 : " + result.get("department") + "<br>";
			html += "</body></html>";
			out.print(html);
			
			Set<String> set = result.keySet();
			for(String key : set) {
				System.out.println("key : "+key+ "val : "+result.get(key));
			}

		}else if(req.getMethod().equals("POST")) {
			//등록 Post방식 처리
		
	//		Map<String, Object> in = new HashMap<>();
	//		in.put("id", req.getParameter("empId"));
	//		in.put("first", req.getParameter("first"));
	//		in.put("last", req.getParameter("last"));
	//		in.put("hire", req.getParameter("hire"));
	//		in.put("job", req.getParameter("job"));
	//		in.put("email", req.getParameter("email"));
	
			newEmp emp = new newEmp();
			emp.seteId(req.getParameter("empId"));
			emp.setFirst(req.getParameter("first"));
			emp.setLast(req.getParameter("last"));
			emp.setHire(req.getParameter("hire"));
			emp.setJob(req.getParameter("job"));
			emp.setEmail(req.getParameter("email"));
			
			emp.toString();
			
			int re = dao.insertEmp(emp);
			if(re>0) {
				out.print("입력성공");
			}else {
				out.print("입력실패");
			}
			
		}
		out.print("<a href='temp.html'>조회-등록으로 이동</a>");
		out.close();
	}
}
