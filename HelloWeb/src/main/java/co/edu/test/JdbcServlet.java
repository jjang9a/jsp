package co.edu.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

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
		int empId = Integer.parseInt(req.getParameter("empId"));

		Map<String, Object> result = dao.getEmpInpo(empId);
		
		req.setCharacterEncoding("utf-8"); //요청 정보에 있는 인코딩 방식을 지정.
		
		resp.setCharacterEncoding("utf-8"); //응답정보의 인코딩 방식 지정.
		resp.setContentType("text/html;charset=utf-8"); //컨텐트 타입 지정.
		
		//페이지 출력 - 사번/이름(이름+성씨),급여/부서
		PrintWriter out = resp.getWriter();
		
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
		out.close();
		
		
//		Map<String, Object> in = new HashMap<>();
//		in.put("id", Integer.parseInt(req.getParameter("empId")));
//		in.put("first", req.getParameter("first"));
//		in.put("last", req.getParameter("last"));
//		in.put("hire", req.getParameter("hire"));
//		in.put("job", req.getParameter("job"));
//		in.put("email", req.getParameter("email"));
		
		newEmp emp = new newEmp();
		emp.setId(Integer.parseInt(req.getParameter("nempId")));
		emp.setFirst(req.getParameter("first"));
		emp.setLast(req.getParameter("last"));
		emp.setHire(req.getParameter("hire"));
		emp.setJob(req.getParameter("job"));
		emp.setEmail(req.getParameter("email"));
		
		int re = dao.insetEmp(emp);
		if(re>0) {
			System.out.println("입력성공");
		}else {
			System.out.println("입력실패");
		}
		
		
		out.print("<a href='temp.html'>조회-등록으로 이동</a>");
	
	}
}
